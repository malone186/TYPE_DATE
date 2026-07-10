import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episode1_data.dart';
import '../models/models.dart';
import '../widgets/kakao_chat_view.dart';
import '../widgets/common.dart';
import 'character_select_screen.dart';

/// 에필로그 — Scene 1(알림) → Scene 2(민준 카톡) → Scene 3(2화 예고)
class EpilogueScreen extends StatefulWidget {
  final DateResult result;

  const EpilogueScreen({super.key, required this.result});

  @override
  State<EpilogueScreen> createState() => _EpilogueScreenState();
}

enum _EpilogueStep { notification, minjun, teaser }

class _EpilogueScreenState extends State<EpilogueScreen> {
  _EpilogueStep _step = _EpilogueStep.notification;

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _EpilogueStep.notification:
        return _NotificationScene(
          onNext: () => setState(() => _step = _EpilogueStep.minjun),
        );
      case _EpilogueStep.minjun:
        return KakaoChatView(
          contactName: '최민준',
          lines: epilogueLines,
          completeButtonLabel: '다음 화 예고 보기',
          onComplete: () => setState(() => _step = _EpilogueStep.teaser),
        );
      case _EpilogueStep.teaser:
        return _TeaserScene(
          onNext: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const CharacterSelectScreen()),
            (route) => false,
          ),
        );
    }
  }
}

class _NotificationScene extends StatelessWidget {
  final VoidCallback onNext;
  const _NotificationScene({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: GlowBackground(
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              GlassPanel(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Column(
                  children: [
                    const Text('💘', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 8),
                    Text('1/16 완료', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                    const SizedBox(height: 16),
                    Text(
                      '첫 번째 만남이 끝났어요.\n15명이 더 기다리고 있어요.\n\n진짜 인연은 아직 시작도 안 했을 수 있어요 👀',
                      textAlign: TextAlign.center,
                      style: TypeDateTextStyles.chatMessage(c.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CoralButton(label: '계속', onPressed: onNext),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

class _TeaserScene extends StatelessWidget {
  final VoidCallback onNext;
  const _TeaserScene({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: GlowBackground(
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              GlassPanel(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('💘', style: TextStyle(fontSize: 22)),
                        const SizedBox(width: 8),
                        Text('다음 인연', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('2화 — INTJ ???',
                        style: TypeDateTextStyles.choiceButton(c.accentLavenderDeep)
                            .copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                      '"차갑다는 말 많이 들어요.\n근데 사실 그게 싫어요"',
                      style: TypeDateTextStyles.chatMessage(c.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    Text('이 사람이 진짜 인연일까요? 곧 만나볼 수 있어요.',
                        style: TypeDateTextStyles.caption(c.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CoralButton(label: '캐릭터 목록으로', onPressed: onNext),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
