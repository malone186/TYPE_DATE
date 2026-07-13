import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episodes.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../widgets/kakao_chat_view.dart';
import '../widgets/common.dart';
import 'character_select_screen.dart';

/// 에필로그 — Scene 1(알림) → Scene 2(민준 카톡) → Scene 3(다음 화 예고)
class EpilogueScreen extends ConsumerStatefulWidget {
  final DateResult result;

  const EpilogueScreen({super.key, required this.result});

  @override
  ConsumerState<EpilogueScreen> createState() => _EpilogueScreenState();
}

enum _EpilogueStep { notification, minjun, teaser }

class _EpilogueScreenState extends ConsumerState<EpilogueScreen> {
  _EpilogueStep _step = _EpilogueStep.notification;

  @override
  Widget build(BuildContext context) {
    final completedCount = ref.watch(gameProgressProvider).totalCompleted;
    final episodeIndex =
        allEpisodes.indexWhere((e) => e.id == widget.result.dateId);
    final nextEpisode = (episodeIndex >= 0 && episodeIndex + 1 < allEpisodes.length)
        ? allEpisodes[episodeIndex + 1]
        : null;

    switch (_step) {
      case _EpilogueStep.notification:
        return _NotificationScene(
          completedCount: completedCount,
          onNext: () => setState(() => _step = _EpilogueStep.minjun),
        );
      case _EpilogueStep.minjun:
        return KakaoChatView(
          contactName: '최민준',
          lines: epilogueLinesByDateId[widget.result.dateId] ?? epilogueLines,
          completeButtonLabel: '다음 화 예고 보기',
          onComplete: () => setState(() => _step = _EpilogueStep.teaser),
        );
      case _EpilogueStep.teaser:
        return _TeaserScene(
          episodeNumber: episodeIndex + 2,
          nextCharacter: nextEpisode?.character,
          onNext: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const CharacterSelectScreen()),
            (route) => false,
          ),
        );
    }
  }
}

class _NotificationScene extends StatelessWidget {
  final int completedCount;
  final VoidCallback onNext;
  const _NotificationScene({required this.completedCount, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final remaining = 16 - completedCount;
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
                    Text('$completedCount/16 완료', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                    const SizedBox(height: 16),
                    Text(
                      '이번 만남이 끝났어요.\n$remaining명이 더 기다리고 있어요.\n\n진짜 인연은 아직 시작도 안 했을 수 있어요 👀',
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
  final int episodeNumber;
  final TDCharacter? nextCharacter; // null 이면 아직 제작되지 않은 화
  final VoidCallback onNext;
  const _TeaserScene({
    required this.episodeNumber,
    required this.nextCharacter,
    required this.onNext,
  });

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
                    Text(
                        nextCharacter != null
                            ? '$episodeNumber화 — ${nextCharacter!.mbti} ???'
                            : '$episodeNumber화 — ????',
                        style: TypeDateTextStyles.choiceButton(c.accentLavenderDeep)
                            .copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                      nextCharacter != null
                          ? '"${nextCharacter!.intro}"'
                          : '다음 인연을 준비 중이에요.',
                      style: TypeDateTextStyles.chatMessage(c.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                        nextCharacter != null
                            ? '이 사람이 진짜 인연일까요? 캐릭터 목록에서 해금됐어요.'
                            : '업데이트를 기다려주세요!',
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
