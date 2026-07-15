import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../state/game_state.dart';

/// 새벽빛 메시 그라디언트를 이루는 부드러운 원형 글로우 한 덩어리.
class GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const GlowBlob({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: 0.38), color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// 앱 전체 공용 배경 — bg 위에 코랄/라벤더 글로우가 떠 있는 새벽빛 무드.
/// Scaffold body를 이 위젯으로 감싸면 모든 화면이 같은 톤을 공유한다.
/// [showLogoWatermark]를 켜면 중앙에 TD 로고 마크가 은은하게 깔린다 (채팅 화면용).
/// [photoBackground]를 켜면 로고 워터마크 대신 카페 사진을 은은하게 깔아 실제 만난 장소 느낌을 준다 (소개팅 채팅 화면용).
class GlowBackground extends StatelessWidget {
  final Widget child;
  final bool showLogoWatermark;
  final bool photoBackground;
  const GlowBackground({
    super.key,
    required this.child,
    this.showLogoWatermark = false,
    this.photoBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // 사진의 라벤더→퍼플→핑크 메시 그라디언트.
    final baseGradient = isDark
        ? const [Color(0xFF241E38), Color(0xFF1F1A30), Color(0xFF2A2142)]
        : const [Color(0xFFCCD2F2), Color(0xFFDBCDEE), Color(0xFFEBD3E7)];
    final blobPeriwinkle = isDark ? const Color(0xFF4A3F7A) : const Color(0xFFB9C2F0);
    final blobLavender = isDark ? const Color(0xFF5B4A8C) : const Color(0xFFD8C4EC);
    final blobPink = isDark ? const Color(0xFF6E4A78) : const Color(0xFFEBC8DE);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: baseGradient,
            ),
          ),
        ),
        if (photoBackground) ...[
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          Container(color: c.bg.withValues(alpha: isDark ? 0.55 : 0.35)),
        ],
        Positioned(top: -90, left: -70, child: GlowBlob(color: blobPeriwinkle, size: 320)),
        Positioned(top: 10, right: -110, child: GlowBlob(color: blobLavender, size: 300)),
        Positioned(bottom: -140, right: -60, child: GlowBlob(color: blobPink, size: 300)),
        Positioned(bottom: -110, left: -80, child: GlowBlob(color: blobLavender, size: 260)),
        if (showLogoWatermark && !photoBackground)
          Center(
            child: IgnorePointer(
              child: Opacity(
                // 다크 모드에선 배경이 어두워 로고 색이 덜 비치므로 살짝 더 진하게
                opacity: isDark ? 0.09 : 0.06,
                child: FractionallySizedBox(
                  // 화면 크기에 비례해 큼직하게 — 잘리지 않도록 contain으로 맞춘다
                  widthFactor: 0.8,
                  heightFactor: 0.65,
                  child: Image.asset('assets/images/logo_mark.png', fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        child,
      ],
    );
  }
}

/// 유리질 블러 패널 — 글로우 배경 위에 떠 있는 반투명 카드/말풍선 공용.
class GlassPanel extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final BoxConstraints? constraints;

  const GlassPanel({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(24),
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          constraints: constraints,
          padding: padding,
          decoration: BoxDecoration(
            color: c.surface.withValues(alpha: 0.72),
            border: Border.all(color: c.border.withValues(alpha: 0.6), width: 0.5),
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}

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
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: c.surface.withValues(alpha: 0.8),
          border: Border.all(color: c.border, width: 1),
        ),
        child: Icon(icon, size: 18, color: c.textPrimary),
      ),
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

/// 원형 프사 — 브랜드 그라디언트 글로우 링 + 이미지, 이미지가 없으면 이니셜 placeholder
class CharacterAvatar extends StatelessWidget {
  final TDCharacter character;
  final double size;

  const CharacterAvatar({super.key, required this.character, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
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
          BoxShadow(color: c.accentCoral.withValues(alpha: 0.35), blurRadius: 8, spreadRadius: 0.5),
        ],
      ),
      child: ClipOval(
        child: character.imagePath != null
            ? Image.asset(character.imagePath!, fit: BoxFit.cover)
            : Container(
                color: c.accentCoralSoft,
                alignment: Alignment.center,
                child: Text(
                  character.name.isNotEmpty ? character.name.substring(0, 1) : '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

/// 10턴 진행 바 — UI 디자인 명세서 §4-5
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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [c.accentCoral, c.accentLavender]),
                ),
              ),
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

/// 아이폰 상단 상태바 모방 — 시간 / 신호 / 데이터 / 배터리 잔량(충전 아님).
/// SafeArea 안 최상단에 놓아 실제 폰 화면 위에서 앱이 도는 느낌을 준다.
class PhoneStatusBar extends StatefulWidget {
  const PhoneStatusBar({super.key});

  @override
  State<PhoneStatusBar> createState() => _PhoneStatusBarState();
}

class _PhoneStatusBarState extends State<PhoneStatusBar> {
  late String _time;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _time = _formatNow();
    // 분 단위 시계 — 20초마다 확인해 분이 바뀌면 갱신.
    _timer = Timer.periodic(const Duration(seconds: 20), (_) {
      final t = _formatNow();
      if (mounted && t != _time) setState(() => _time = t);
    });
  }

  String _formatNow() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fg = context.colors.textPrimary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 6, 20, 2),
      child: Row(
        children: [
          Text(
            _time,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: fg,
            ),
          ),
          const Spacer(),
          Icon(Icons.signal_cellular_alt, size: 16, color: fg),
          const SizedBox(width: 6),
          Icon(Icons.wifi, size: 16, color: fg),
          const SizedBox(width: 6),
          _BatteryIndicator(color: fg, level: 0.8),
        ],
      ),
    );
  }
}

/// 배터리 잔량 표시 — 퍼센트 숫자 + 채워진 배터리 아이콘(충전 번개 없음).
class _BatteryIndicator extends StatelessWidget {
  final Color color;
  final double level; // 0.0 ~ 1.0

  const _BatteryIndicator({required this.color, required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${(level * 100).round()}%',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
        ),
        const SizedBox(width: 4),
        // 배터리 몸통
        Container(
          width: 24,
          height: 12,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.5),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 20 * level.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 1),
        // 배터리 양극 꼭지
        Container(
          width: 2,
          height: 4,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(1)),
          ),
        ),
      ],
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
