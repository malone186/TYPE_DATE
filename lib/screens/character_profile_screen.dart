import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episodes.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import '../widgets/common.dart';
import 'blind_date_chat_screen.dart';

/// 캐릭터 프로필 화면 — §5-4
class CharacterProfileScreen extends ConsumerWidget {
  final TDCharacter character;
  const CharacterProfileScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: c.textPrimary),
        actions: const [ThemeToggleButton()],
      ),
      body: GlowBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: kToolbarHeight),
          child: Column(
            children: [
              const SizedBox(height: 12),
              if (character.facePath != null) ...[
                Container(
                  width: 160,
                  height: 160,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        c.accentCoral,
                        c.accentCoralSoft,
                        c.accentLavender,
                        c.accentLavenderDeep,
                        c.accentCoral,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: c.accentCoral.withValues(alpha: 0.35),
                          blurRadius: 16,
                          spreadRadius: 1),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(character.facePath!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Text('${character.name} · ${character.age}세',
                  style: TypeDateTextStyles.resultTitle(c.textPrimary).copyWith(fontSize: 20)),
              const SizedBox(height: 6),
              Text(character.mbti,
                  style: TypeDateTextStyles.choiceButton(c.accentLavenderDeep)
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${character.job} · ${character.location}',
                  style: TypeDateTextStyles.caption(c.textSecondary)),
              const SizedBox(height: 16),
              Text(
                character.intro,
                textAlign: TextAlign.center,
                style: TypeDateTextStyles.chatMessage(c.textPrimary),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: character.tags
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: c.accentLavender.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(tag,
                              style: TypeDateTextStyles.caption(c.accentLavenderText)),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),
              CoralButton(
                label: '소개팅 시작',
                onPressed: () {
                  final episode = episodeForCharacter(character);
                  if (episode == null) return;
                  ref.read(selectedEpisodeProvider.notifier).state = episode;
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const BlindDateChatScreen()),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
