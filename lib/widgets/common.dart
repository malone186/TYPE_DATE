import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../state/game_state.dart';

/// 라이트/다크/시스템 테마를 순환 전환하는 버튼 — 어느 화면에서든 재사용
class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final mode = ref.watch(themeModeProvider);
    final icon = switch (mode) {
      ThemeMode.light => Icons.light_mode_outlined,
      ThemeMode.dark => Icons.dark_mode_outlined,
      ThemeMode.system => Icons.brightness_auto_outlined,
    };
    return IconButton(
      icon: Icon(icon, color: c.textSecondary),
      tooltip: '테마 전환 (${_label(mode)})',
      onPressed: () {
        final current = ref.read(themeModeProvider);
        final next = current == ThemeMode.light
            ? ThemeMode.dark
            : (current == ThemeMode.dark ? ThemeMode.system : ThemeMode.light);
        ref.read(themeModeProvider.notifier).state = next;
      },
    );
  }

  String _label(ThemeMode mode) => switch (mode) {
        ThemeMode.light => '라이트',
        ThemeMode.dark => '다크',
        ThemeMode.system => '시스템',
      };
}

/// 원형 프사 — 이미지가 없으면 이니셜 placeholder
class CharacterAvatar extends StatelessWidget {
  final TDCharacter character;
  final double size;

  const CharacterAvatar({super.key, required this.character, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    if (character.imagePath != null) {
      return ClipOval(
        child: Image.asset(
          character.imagePath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: c.accentCoralSoft, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        character.name.isNotEmpty ? character.name.substring(0, 1) : '?',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// 13턴 진행 바 — UI 디자인 명세서 §4-5
class TurnProgressBar extends StatelessWidget {
  final double progress; // 0.0 ~ 1.0

  const TurnProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
        height: 4,
        child: Stack(
          children: [
            Container(color: c.border),
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(color: c.accentLavenderDeep),
            ),
          ],
        ),
      ),
    );
  }
}

/// 타이핑 인디케이터 — 점 3개 순차 바운스
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = (_controller.value - i * 0.2) % 1.0;
              final bounce = t < 0.5 ? (t / 0.5) : (1 - (t - 0.5) / 0.5);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Transform.translate(
                  offset: Offset(0, -4 * bounce),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        color: c.textMuted, shape: BoxShape.circle),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// 공통 코랄 CTA 버튼
class CoralButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;

  const CoralButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: c.accentCoral, width: 1.5),
                foregroundColor: c.accentCoral,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(label,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: c.accentCoral,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(label,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
    );
  }
}
