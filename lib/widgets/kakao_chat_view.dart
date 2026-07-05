import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../models/models.dart';
import 'common.dart';

/// 프롤로그/에필로그용 카카오톡 모방 채팅 뷰.
/// 기본은 자동으로 다음 메시지가 나타나고, "건너뛰기"를 누르면 화면을 탭할 때마다
/// 한 줄씩 즉시 넘어가는 모드로 전환된다 (끝까지 다 봐야 다음 화면으로 넘어감).
class KakaoChatView extends StatefulWidget {
  final String contactName;
  final List<ChatLine> lines;
  final VoidCallback onComplete;
  // null이면 대화가 끝나자마자 자동으로 onComplete 호출(기존 동작).
  // 값을 주면 대화가 다 끝난 뒤 이 라벨의 버튼이 나타나고, 눌러야 onComplete 호출.
  final String? completeButtonLabel;

  const KakaoChatView({
    super.key,
    required this.contactName,
    required this.lines,
    required this.onComplete,
    this.completeButtonLabel,
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

  void _enableSkipMode() {
    _timer?.cancel();
    setState(() {
      _skipMode = true;
      _typing = false;
    });
  }

  void _advanceOnTap() {
    if (!_skipMode) return;
    if (_visibleCount >= widget.lines.length) {
      if (widget.completeButtonLabel != null) {
        setState(() => _finished = true);
      } else {
        widget.onComplete();
      }
      return;
    }
    setState(() => _visibleCount++);
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: c.surface,
                border: Border(bottom: BorderSide(color: c.border, width: 0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 16, color: c.textPrimary),
                  const SizedBox(width: 12),
                  Text(widget.contactName,
                      style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                  const Spacer(),
                  if (!_skipMode)
                    TextButton(
                      onPressed: _enableSkipMode,
                      child: Text('건너뛰기', style: TypeDateTextStyles.caption(c.textMuted)),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('탭해서 계속', style: TypeDateTextStyles.caption(c.textMuted)),
                    ),
                  const ThemeToggleButton(),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _skipMode ? _advanceOnTap : null,
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
            ),
            if (widget.completeButtonLabel != null && _finished)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: CoralButton(
                  label: widget.completeButtonLabel!,
                  onPressed: widget.onComplete,
                ),
              ),
          ],
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
          child: Text(
            '— ${line.text} —',
            textAlign: TextAlign.center,
            style: TypeDateTextStyles.monologue(c.textMuted),
          ),
        ),
      );
    }

    final isMe = line.sender == 'me';
    final bubbleColor = isMe ? c.accentCoralSoft : c.surface;
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
                  border: isMe ? null : Border.all(color: c.border, width: 0.5),
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
