import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../widgets/common.dart';
import '../widgets/choice_list.dart';
import '../widgets/like_effect.dart';
import 'result_report_screen.dart';

/// 소개팅 채팅 화면 — 실제 만나서 대화하는 느낌의 누적형 채팅 스레드.
/// 선택지를 고르면 그 텍스트가 내가 보낸 메시지로 쌓이고, 대화는 계속 위로 쌓인다.
class BlindDateChatScreen extends ConsumerStatefulWidget {
  const BlindDateChatScreen({super.key});

  @override
  ConsumerState<BlindDateChatScreen> createState() => _BlindDateChatScreenState();
}

class _BlindDateChatScreenState extends ConsumerState<BlindDateChatScreen> {
  bool _npcMessageRevealed = false;
  bool _showEffect = false;
  bool _reactionRevealed = false;
  Timer? _typingTimer;
  Timer? _advanceTimer;
  int _startedTurnIndex = -1;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _typingTimer?.cancel();
    _advanceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _maybeStartTurn(int turnIndex) {
    if (_startedTurnIndex == turnIndex) return;
    _startedTurnIndex = turnIndex;
    _npcMessageRevealed = false;
    _showEffect = false;
    _reactionRevealed = false;
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 700), () {
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
    setState(() {
      _showEffect = false;
      _reactionRevealed = true;
    });
    _scrollToBottom();
    _advanceTimer = Timer(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      final notifier = ref.read(dateSessionProvider.notifier);
      final session = ref.read(dateSessionProvider);
      if (session.isLastTurn) {
        final result = notifier.buildResult();
        ref.read(gameProgressProvider.notifier).completeDate(result);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => ResultReportScreen(result: result)),
        );
      } else {
        notifier.advanceTurn();
      }
    });
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
    _maybeStartTurn(session.currentTurnIndex);

    final turn = session.currentTurn;
    final character = session.date.character;
    final displayProgress =
        (session.currentTurnIndex + (session.choicePending ? 1 : 0)) / session.date.turns.length;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/소개팅신 배경.png', fit: BoxFit.cover),
          SafeArea(
            child: _chatBody(context, c, session, turn, character, displayProgress),
          ),
        ],
      ),
    );
  }

  Widget _chatBody(BuildContext context, TypeDateTokens c, dynamic session, dynamic turn, dynamic character, double displayProgress) {
    return Column(
          children: [
            // 헤더
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: c.surface.withValues(alpha: 0.92),
                border: Border(bottom: BorderSide(color: c.border, width: 0.5)),
              ),
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
                      Text(character.name, style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                      const Spacer(),
                      Text('${turn.turnNumber} / ${session.date.turns.length}',
                          style: TypeDateTextStyles.caption(c.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TurnProgressBar(progress: displayProgress),
                ],
              ),
            ),
            // 누적 대화 스레드
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이미 끝난 턴들 — 계속 쌓이는 대화 기록
                        for (var i = 0; i < session.history.length; i++)
                          _CompletedTurnBlock(
                            character: character,
                            turn: session.date.turns[i],
                            choice: session.history[i],
                            c: c,
                          ),
                        // 진행 중인 현재 턴
                        if (!_npcMessageRevealed)
                          _TypingRow(character: character, c: c)
                        else ...[
                          _NpcBubble(character: character, text: turn.npcMessage, c: c),
                          const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              turn.monologue,
                              textAlign: TextAlign.center,
                              style: TypeDateTextStyles.monologue(c.textSecondary),
                            ),
                          ),
                          const SizedBox(height: 18),
                          if (session.lastChoice == null)
                            ChoiceList(
                              choices: turn.choices,
                              selected: null,
                              onSelect: _onChoiceSelected,
                            )
                          else
                            _PlayerBubble(text: session.lastChoice!.text, c: c),
                          if (_reactionRevealed && session.lastChoice != null) ...[
                            const SizedBox(height: 14),
                            _NpcBubble(
                              character: character,
                              text: session.lastChoice!.npcReaction,
                              c: c,
                            ),
                          ],
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
          ],
        );
  }
}

/// 완료된 턴 하나를 통째로 — 상대 메시지 + 독백 + 내가 보낸 메시지 + 상대 반응
class _CompletedTurnBlock extends StatelessWidget {
  final TDCharacter character;
  final Turn turn;
  final Choice choice;
  final TypeDateTokens c;

  const _CompletedTurnBlock({
    required this.character,
    required this.turn,
    required this.choice,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NpcBubble(character: character, text: turn.npcMessage, c: c),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              turn.monologue,
              textAlign: TextAlign.center,
              style: TypeDateTextStyles.monologue(c.textSecondary),
            ),
          ),
          const SizedBox(height: 18),
          _PlayerBubble(text: choice.text, c: c),
          const SizedBox(height: 14),
          _NpcBubble(character: character, text: choice.npcReaction, c: c),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.border, width: 0.5),
          ),
          child: const TypingIndicator(),
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

  @override
  Widget build(BuildContext context) {
    return _FadeSlideIn(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CharacterAvatar(character: character, size: 24),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: c.surface,
                border: Border.all(color: c.border, width: 0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(text, style: TypeDateTextStyles.chatMessage(c.textPrimary)),
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
