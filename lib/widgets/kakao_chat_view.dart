import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../models/models.dart';
import 'common.dart';

/// 프롤로그/에필로그용 카카오톡 모방 채팅 뷰.
/// 기본은 자동으로 다음 메시지가 나타나고, "건너뛰기"를 누르면 남은 대화가
/// 전부 즉시 펼쳐진 뒤 "다음" 버튼을 눌러야 다음 화면으로 넘어간다.
class KakaoChatView extends StatefulWidget {
  final String contactName;
  final List<ChatLine> lines;
  final VoidCallback onComplete;
  // null이면 대화가 끝나자마자 자동으로 onComplete 호출(기존 동작).
  // 값을 주면 대화가 다 끝난 뒤 이 라벨의 버튼이 나타나고, 눌러야 onComplete 호출.
  final String? completeButtonLabel;
  // 켜면 최상단에 아이폰 상태바(시간·신호·데이터·배터리)를 표시.
  final bool showStatusBar;

  const KakaoChatView({
    super.key,
    required this.contactName,
    required this.lines,
    required this.onComplete,
    this.completeButtonLabel,
    this.showStatusBar = false,
  });

  @override
  State<KakaoChatView> createState() => _KakaoChatViewState();
}

class _KakaoChatViewState extends State<KakaoChatView> {
  int _visibleCount = 1;
  bool _typing = false;
  bool _skipMode = false;
  bool _finished = false;
  Timer? _timer;
  final _scrollController = ScrollController();

  String get _npcInitial {
    for (final line in widget.lines) {
      if (!line.isSystemNote && line.sender != 'me') {
        return line.sender.isNotEmpty ? line.sender.substring(0, 1) : '?';
      }
    }
    return widget.contactName.substring(0, 1);
  }

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _delayFor(ChatLine line) {
    if (line.isSystemNote) return const Duration(milliseconds: 1400);
    final ms = (450 + line.text.length * 28).clamp(700, 2200);
    return Duration(milliseconds: ms);
  }

  bool get _nextIsNpcMessage {
    if (_visibleCount >= widget.lines.length) return false;
    final next = widget.lines[_visibleCount];
    return !next.isSystemNote && next.sender != 'me';
  }

  bool get _nextIsMyMessage {
    if (_visibleCount >= widget.lines.length) return false;
    final next = widget.lines[_visibleCount];
    return !next.isSystemNote && next.sender == 'me';
  }

  void _scheduleNext() {
    if (_visibleCount >= widget.lines.length) {
      if (widget.completeButtonLabel != null) {
        setState(() => _finished = true);
      } else {
        _timer = Timer(const Duration(milliseconds: 900), widget.onComplete);
      }
      return;
    }

    Duration preDelay;
    if (_nextIsNpcMessage) {
      setState(() => _typing = true);
      preDelay = const Duration(milliseconds: 700);
    } else if (_nextIsMyMessage) {
      preDelay = const Duration(milliseconds: 400);
    } else {
      preDelay = const Duration(milliseconds: 300);
    }

    _timer = Timer(preDelay, () {
      if (!mounted) return;
      final line = widget.lines[_visibleCount];
      setState(() {
        _typing = false;
        _visibleCount++;
      });
      _scrollToBottom();
      _timer = Timer(_delayFor(line), () {
        if (!mounted) return;
        _scheduleNext();
      });
    });
  }

  /// 건너뛰기 — 한 줄씩 기다릴 필요 없이 남은 대화를 전부 즉시 펼치고,
  /// "다음" 버튼을 눌러야 다음 화면으로 넘어가게 한다.
  void _enableSkipMode() {
    _timer?.cancel();
    setState(() {
      _skipMode = true;
      _typing = false;
      _visibleCount = widget.lines.length;
      _finished = true;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final visibleLines = widget.lines.take(_visibleCount).toList();

    return Scaffold(
      backgroundColor: c.bg,
      body: GlowBackground(
        showLogoWatermark: true,
        child: SafeArea(
        child: Column(
          children: [
            if (widget.showStatusBar) const PhoneStatusBar(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 16, color: c.textPrimary),
                  const SizedBox(width: 12),
                  Text(widget.contactName,
                      style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                  const Spacer(),
                  if (!_skipMode) _SkipButton(onPressed: _enableSkipMode, c: c),
                  const ThemeToggleButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemCount: visibleLines.length + (_typing ? 1 : 0),
                itemBuilder: (context, i) {
                  if (i == visibleLines.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: _TypingBubble(senderInitial: _npcInitial),
                    );
                  }
                  return _ChatLineWidget(line: visibleLines[i]);
                },
              ),
            ),
            if (_finished)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: CoralButton(
                  label: widget.completeButtonLabel ?? '다음',
                  onPressed: widget.onComplete,
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}

/// 건너뛰기 버튼 — 배경 위에서도 눈에 띄도록 테두리 있는 칩 형태로.
class _SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TypeDateTokens c;
  const _SkipButton({required this.onPressed, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: c.surface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: c.border, width: 1),
            ),
            child: Text('건너뛰기', style: TypeDateTextStyles.caption(c.textPrimary)),
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  final String senderInitial;
  const _TypingBubble({required this.senderInitial});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: c.accentCoralSoft,
          child: Text(senderInitial, style: const TextStyle(fontSize: 11, color: Colors.white)),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: c.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.border.withValues(alpha: 0.6), width: 0.5),
          ),
          child: const TypingIndicator(),
        ),
      ],
    );
  }
}

class _ChatLineWidget extends StatelessWidget {
  final ChatLine line;

  const _ChatLineWidget({required this.line});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    if (line.isSystemNote) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: c.surface.withValues(alpha: 0.6),
                  border: Border.all(color: c.border.withValues(alpha: 0.5), width: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '— ${line.text} —',
                  textAlign: TextAlign.center,
                  style: TypeDateTextStyles.monologue(c.textMuted),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final isMe = line.sender == 'me';
    final bubbleColor = isMe ? c.accentCoralSoft : c.surface.withValues(alpha: 0.8);
    final textColor = isMe ? Colors.white : c.textPrimary;
    final radius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 12,
              backgroundColor: c.accentCoralSoft,
              child: Text(
                line.sender.isNotEmpty ? line.sender.substring(0, 1) : '?',
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 8),
                  child: child,
                ),
              ),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: radius,
                  border: isMe ? null : Border.all(color: c.border.withValues(alpha: 0.6), width: 0.5),
                ),
                child: Text(
                  line.text,
                  style: TypeDateTextStyles.chatMessage(textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
