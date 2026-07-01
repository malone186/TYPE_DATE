import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episode1_data.dart';
import '../models/models.dart';
import '../state/game_state.dart';
import 'character_profile_screen.dart';

/// 캐릭터 선택 화면 — 2열 그리드, 16슬롯, 1화만 해금 (§5-3)
class CharacterSelectScreen extends ConsumerWidget {
  const CharacterSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final progress = ref.watch(gameProgressProvider);
    final completedCount = progress.totalCompleted;

    return Scaffold(
      backgroundColor: c.bg,
      appBar: AppBar(
        backgroundColor: c.bg,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('소개팅 상대', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6_outlined, color: c.textSecondary),
            tooltip: '테마 전환',
            onPressed: () {
              final current = ref.read(themeModeProvider);
              final next = current == ThemeMode.light
                  ? ThemeMode.dark
                  : (current == ThemeMode.dark ? ThemeMode.system : ThemeMode.light);
              ref.read(themeModeProvider.notifier).state = next;
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$completedCount / 16 완료', style: TypeDateTextStyles.caption(c.textSecondary)),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: allCharacterSlots.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, i) {
                  final char = allCharacterSlots[i];
                  return _CharacterSlot(
                    character: char,
                    isCompleted: progress.results.containsKey(char.id),
                    onTap: char.isUnlocked
                        ? () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CharacterProfileScreen(character: jisu),
                              ),
                            )
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _CharacterSlot extends StatelessWidget {
  final TDCharacter character;
  final bool isCompleted;
  final VoidCallback? onTap;

  const _CharacterSlot({required this.character, required this.isCompleted, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final locked = !character.isUnlocked;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: c.bg,
                    child: locked
                        ? Icon(Icons.person_outline, size: 40, color: c.textMuted)
                        : (character.imagePath != null
                            ? Image.asset(character.imagePath!, fit: BoxFit.cover)
                            : Icon(Icons.person, size: 40, color: c.accentCoralSoft)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locked ? '?????' : character.mbti,
                        style: TypeDateTextStyles.choiceLabel(c.accentLavenderDeep),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        locked ? '???' : '${character.name} · ${character.age}세',
                        style: TypeDateTextStyles.caption(c.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (locked)
              Positioned.fill(
                child: Container(
                  color: c.bg.withValues(alpha: 0.55),
                  child: Center(
                    child: Icon(Icons.lock_outline, color: c.textMuted, size: 28),
                  ),
                ),
              ),
            if (isCompleted)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: c.success, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
