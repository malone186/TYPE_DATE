import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episode1_script.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../widgets/common.dart';
import '../widgets/choice_list.dart';
import '../widgets/like_effect.dart';
import 'result_report_screen.dart';

/// npc 대사에 들어 있는 "{name}씨" 토큰을 사용자가 입력한 이름으로 치환.
/// 이름이 비어 있으면(예외적인 경우) 중립적인 호칭으로 대체.
String _applyName(String text, String userName) {
  final trimmed = userName.trim();
  return text.replaceAll('{name}씨', trimmed.isEmpty ? '그쪽' : '$trimmed씨');
}

/// 메시지 길이에 비례한 "입력 중..." 표시 시간 — 카카오톡 대화창과 같은 리듬을 주기 위함.
Duration _typingDelayFor(String text) {
  final ms = (500 + text.length * 32).clamp(900, 2600);
  return Duration(milliseconds: ms);
}

/// 소개팅 채팅 화면 — 실제 만나서 대화하는 느낌의 누적형 채팅 스레드.
/// 도입부부터 마지막 턴까지 대화가 전부 위로 계속 쌓이고, 선택지만 화면 하단에 고정된다.
class BlindDateChatScreen extends ConsumerStatefulWidget {
  const BlindDateChatScreen({super.key});

  @override
  ConsumerState<BlindDateChatScreen> createState() => _BlindDateChatScreenState();
}

class _BlindDateChatScreenState extends ConsumerState<BlindDateChatScreen> {
  bool _npcMessageRevealed = false;
  bool _showEffect = false;
  bool _reactionTyping = false;
  bool _reactionRevealed = false;
  Timer? _typingTimer;
  Timer? _advanceTimer;
  int _startedTurnIndex = -1;
  final _scrollController = ScrollController();

  // 도입부(도착·인사·착석) — 선택지 없이 자동으로 흘러가다가 턴1로 이어짐
  bool _openingDone = false;
  bool _openingTyping = false;
  int _openingRevealCount = 0;

  // 마무리(클로징) — 13턴 종료 후, 결과에 따라 갈리는 짧은 연출이 같은 화면에서 이어짐
  DateResult? _pendingResult;
  List<ChatLine> _closingLines = const [];
  int _closingRevealCount = 0;
  bool _closingTyping = false;
  bool _closingFinished = false;

  @override
  void initState() {
    super.initState();
    final opening = ref.read(dateSessionProvider).date.openingScript;
    if (opening.isEmpty) {
      _openingDone = true;
    } else {
      // initState는 부모 위젯의 build 도중 실행되므로 setState를 바로 호출할 수 없다.
      // 다음 이벤트 루프로 미뤄서 시작.
      _typingTimer = Timer(Duration.zero, _scheduleOpeningLine);
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _advanceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scheduleOpeningLine() {
    final opening = ref.read(dateSessionProvider).date.openingScript;
    if (_openingRevealCount >= opening.length) {
      _advanceTimer = Timer(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(() => _openingDone = true);
      });
      return;
    }
    final next = opening[_openingRevealCount];
    final isDialogue = !next.isSystemNote && !next.isMonologue;
    if (isDialogue) {
      setState(() => _openingTyping = true);
    }
    final preDelay = isDialogue
        ? _typingDelayFor(next.text)
        : const Duration(milliseconds: 250);
    _typingTimer = Timer(preDelay, () {
      if (!mounted) return;
      setState(() {
        _openingTyping = false;
        _openingRevealCount++;
      });
      _scrollToBottom();
      final holdMs = isDialogue ? 700 : 1100;
      _advanceTimer = Timer(Duration(milliseconds: holdMs), () {
        if (!mounted) return;
        _scheduleOpeningLine();
      });
    });
  }

  void _maybeStartTurn(int turnIndex) {
    if (_startedTurnIndex == turnIndex) return;
    _startedTurnIndex = turnIndex;
    _npcMessageRevealed = false;
    _showEffect = false;
    _reactionTyping = false;
    _reactionRevealed = false;
    _typingTimer?.cancel();
    final npcMessage = ref.read(dateSessionProvider).date.turns[turnIndex].npcMessage;
    _typingTimer = Timer(_typingDelayFor(npcMessage), () {
      if (mounted) {
        setState(() => _npcMessageRevealed = true);
        _scrollToBottom();
      }
    });
  }

  void _onChoiceSelected(Choice choice) {
    ref.read(dateSessionProvider.notifier).selectChoice(choice);
    setState(() => _showEffect = true);
    _scrollToBottom();
  }

  void _onEffectFinished() {
    if (!mounted) return;
    final reactionText = ref.read(dateSessionProvider).lastChoice?.npcReaction ?? '';
    setState(() {
      _showEffect = false;
      _reactionTyping = true;
    });
    _scrollToBottom();
    _advanceTimer = Timer(_typingDelayFor(reactionText), () {
      if (!mounted) return;
      setState(() {
        _reactionTyping = false;
        _reactionRevealed = true;
      });
      _scrollToBottom();
      _advanceTimer = Timer(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        final notifier = ref.read(dateSessionProvider.notifier);
        final session = ref.read(dateSessionProvider);
        if (session.isLastTurn) {
          final result = notifier.buildResult();
          _startClosingScene(result);
        } else {
          notifier.advanceTurn();
        }
      });
    });
  }

  void _startClosingScene(DateResult result) {
    setState(() {
      _pendingResult = result;
      _closingLines = closingScriptFor(result.ending);
      _closingRevealCount = 0;
    });
    _scrollToBottom();
    _scheduleClosingLine();
  }

  void _scheduleClosingLine() {
    if (_closingRevealCount >= _closingLines.length) {
      setState(() => _closingFinished = true);
      _scrollToBottom();
      return;
    }
    final next = _closingLines[_closingRevealCount];
    final isDialogue = !next.isSystemNote && !next.isMonologue;
    if (isDialogue) {
      setState(() => _closingTyping = true);
    }
    final preDelay =
        isDialogue ? _typingDelayFor(next.text) : const Duration(milliseconds: 300);
    _typingTimer = Timer(preDelay, () {
      if (!mounted) return;
      setState(() {
        _closingTyping = false;
        _closingRevealCount++;
      });
      _scrollToBottom();
      final holdMs = isDialogue ? 700 : 1100;
      _advanceTimer = Timer(Duration(milliseconds: holdMs), () {
        if (!mounted) return;
        _scheduleClosingLine();
      });
    });
  }

  void _goToResult() {
    final result = _pendingResult!;
    ref.read(gameProgressProvider.notifier).completeDate(result);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ResultReportScreen(result: result)),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 200,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final session = ref.watch(dateSessionProvider);
    final character = session.date.character;
    final userName = ref.watch(userNameProvider);

    if (_openingDone) {
      _maybeStartTurn(session.currentTurnIndex);
    }

    final turn = session.currentTurn;
    final displayProgress =
        (session.currentTurnIndex + (session.choicePending ? 1 : 0)) / session.date.turns.length;

    return Scaffold(
      body: GlowBackground(
        photoBackground: true,
        child: SafeArea(
          child: _chatBody(context, c, session, turn, character, displayProgress, userName),
        ),
      ),
    );
  }

  /// 도입부부터 마지막 턴까지 하나의 스크롤 안에서 계속 쌓인다. 선택지만 하단에 고정.
  Widget _chatBody(
    BuildContext context,
    TypeDateTokens c,
    DateSessionState session,
    Turn turn,
    TDCharacter character,
    double displayProgress,
    String userName,
  ) {
    final opening = session.date.openingScript;
    final openingVisible = opening.take(_openingRevealCount).toList();
    final showChoices = _openingDone &&
        _npcMessageRevealed &&
        session.lastChoice == null &&
        !_showEffect;

    return Column(
      children: [
        // 헤더 — 배경 그라디언트 위에 떠 있는 느낌으로, 별도 배경 없이 투명하게
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.arrow_back_ios_new, size: 16, color: c.textPrimary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  CharacterAvatar(character: character, size: 32),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(character.name, style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                      Text('${character.mbti} · ${character.age}',
                          style: TypeDateTextStyles.caption(c.textSecondary)),
                    ],
                  ),
                  const Spacer(),
                  if (_openingDone)
                    Text('${turn.turnNumber} / ${session.date.turns.length}',
                        style: TypeDateTextStyles.caption(c.textMuted)),
                  const ThemeToggleButton(),
                ],
              ),
              if (_openingDone) ...[
                const SizedBox(height: 10),
                TurnProgressBar(progress: displayProgress),
              ],
            ],
          ),
        ),
        // 누적 대화 스레드 — 도입부 + 지금까지의 모든 턴이 계속 쌓인다
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in openingVisible)
                      _openingLine(character, line, c, userName),
                    if (!_openingDone && _openingTyping)
                      _TypingRow(character: character, c: c),
                    if (_openingDone) ...[
                      // 이미 끝난 턴들 — 계속 쌓이는 대화 기록
                      for (var i = 0; i < session.history.length; i++)
                        _CompletedTurnBlock(
                          character: character,
                          turn: session.date.turns[i],
                          choice: session.history[i],
                          c: c,
                          userName: userName,
                        ),
                      // 진행 중인 현재 턴
                      if (!_npcMessageRevealed)
                        _TypingRow(character: character, c: c)
                      else ...[
                        _NpcBubble(
                          character: character,
                          text: _applyName(turn.npcMessage, userName),
                          c: c,
                        ),
                        const SizedBox(height: 10),
                        _MonologueBubble(text: turn.monologue, c: c),
                        if (session.lastChoice != null) ...[
                          const SizedBox(height: 18),
                          _PlayerBubble(text: session.lastChoice!.text, c: c),
                          if (_reactionTyping) ...[
                            const SizedBox(height: 14),
                            _TypingRow(character: character, c: c),
                          ] else if (_reactionRevealed) ...[
                            const SizedBox(height: 14),
                            _NpcBubble(
                              character: character,
                              text: _applyName(session.lastChoice!.npcReaction, userName),
                              c: c,
                            ),
                          ],
                        ],
                      ],
                    ],
                    if (_pendingResult != null) ...[
                      const SizedBox(height: 18),
                      for (final line in _closingLines.take(_closingRevealCount))
                        _openingLine(character, line, c, userName),
                      if (_closingTyping)
                        _TypingRow(character: character, c: c),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              if (_showEffect && session.lastChoice != null)
                LikeEffectOverlay(
                  isLike: session.lastChoice!.likeScore > 0,
                  onFinished: _onEffectFinished,
                ),
            ],
          ),
        ),
        // 선택지 — 화면 하단에 고정, 배경은 투명
        if (showChoices)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: ChoiceList(
              choices: turn.choices,
              selected: null,
              onSelect: _onChoiceSelected,
            ),
          ),
        if (_closingFinished)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: CoralButton(label: '결과 확인하기', onPressed: _goToResult),
          ),
      ],
    );
  }

  Widget _openingLine(TDCharacter character, ChatLine line, TypeDateTokens c, String userName) {
    if (line.isSystemNote) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            line.text,
            textAlign: TextAlign.center,
            style: TypeDateTextStyles.caption(c.textMuted),
          ),
        ),
      );
    }
    if (line.isMonologue) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _MonologueBubble(text: line.text, c: c),
      );
    }
    if (line.sender == 'me') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: _PlayerBubble(text: line.text, c: c),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _NpcBubble(character: character, text: _applyName(line.text, userName), c: c),
    );
  }
}

/// 완료된 턴 하나를 통째로 — 상대 메시지 + 독백 + 내가 보낸 메시지 + 상대 반응
class _CompletedTurnBlock extends StatelessWidget {
  final TDCharacter character;
  final Turn turn;
  final Choice choice;
  final TypeDateTokens c;
  final String userName;

  const _CompletedTurnBlock({
    required this.character,
    required this.turn,
    required this.choice,
    required this.c,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NpcBubble(character: character, text: _applyName(turn.npcMessage, userName), c: c),
          const SizedBox(height: 10),
          _MonologueBubble(text: turn.monologue, c: c),
          const SizedBox(height: 14),
          _PlayerBubble(text: choice.text, c: c),
          const SizedBox(height: 14),
          _NpcBubble(character: character, text: _applyName(choice.npcReaction, userName), c: c),
        ],
      ),
    );
  }
}

class _TypingRow extends StatelessWidget {
  final TDCharacter character;
  final TypeDateTokens c;
  const _TypingRow({required this.character, required this.c});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CharacterAvatar(character: character, size: 24),
        const SizedBox(width: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: c.surface.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: c.border.withValues(alpha: 0.6), width: 0.5),
              ),
              child: const TypingIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}

class _NpcBubble extends StatelessWidget {
  final TDCharacter character;
  final String text;
  final TypeDateTokens c;

  const _NpcBubble({required this.character, required this.text, required this.c});

  static const _radius = BorderRadius.only(
    topLeft: Radius.circular(4),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
  );

  @override
  Widget build(BuildContext context) {
    return _FadeSlideIn(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CharacterAvatar(character: character, size: 24),
          const SizedBox(width: 8),
          Flexible(
            child: ClipRRect(
              borderRadius: _radius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: c.surface.withValues(alpha: 0.72),
                    border: Border.all(color: c.border.withValues(alpha: 0.6), width: 0.5),
                    borderRadius: _radius,
                  ),
                  child: Text(text, style: TypeDateTextStyles.chatMessage(c.textPrimary)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 선택지를 고르면 실제로 "보낸" 내 메시지 말풍선 — 퀴즈가 아니라 대화처럼 보이게
class _PlayerBubble extends StatelessWidget {
  final String text;
  final TypeDateTokens c;
  const _PlayerBubble({required this.text, required this.c});

  @override
  Widget build(BuildContext context) {
    return _FadeSlideIn(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: c.accentCoralSoft,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(text, style: TypeDateTextStyles.chatMessage(Colors.white)),
        ),
      ),
    );
  }
}

/// 주인공 속마음 — 실제로 보내는 채팅과 구분되도록 회색 이탤릭 텍스트로 은은하게.
/// 배경 카페 사진 위에서도 읽히도록 옅은 유리질 배경 위에 얹는다.
class _MonologueBubble extends StatelessWidget {
  final String text;
  final TypeDateTokens c;
  const _MonologueBubble({required this.text, required this.c});

  @override
  Widget build(BuildContext context) {
    return _FadeSlideIn(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TypeDateTextStyles.monologue(c.textSecondary),
          ),
        ),
      ),
    );
  }
}

class _FadeSlideIn extends StatelessWidget {
  final Widget child;
  const _FadeSlideIn({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      builder: (context, value, c) => Opacity(
        opacity: value,
        child: Transform.translate(offset: Offset(0, (1 - value) * 8), child: c),
      ),
      child: child,
    );
  }
}
