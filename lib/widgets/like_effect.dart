import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// 호감도 이펙트 — 점수/숫자 노출 금지, 색과 움직임으로만 전달.
/// 호감(❤️): 코랄색 테두리 플래시 + 하트 파편 버스트.
/// 비호감(💔): 회색 테두리 플래시 + 갈라지는 하트, 흔들림.
class LikeEffectOverlay extends StatefulWidget {
  final bool isLike; // true = ❤️, false = 💔
  final VoidCallback onFinished;

  const LikeEffectOverlay({
    super.key,
    required this.isLike,
    required this.onFinished,
  });

  @override
  State<LikeEffectOverlay> createState() => _LikeEffectOverlayState();
}

class _LikeEffectOverlayState extends State<LikeEffectOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _dislikeGray = Color(0xFF9B9B9B);
  static const _particleAngles = [-70.0, -35.0, -8.0, 20.0, 50.0, 80.0, -105.0, 110.0];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onFinished();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final flashColor = widget.isLike ? c.accentCoral : _dislikeGray;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;
          return Stack(
            fit: StackFit.expand,
            children: [
              _borderFlash(t, flashColor),
              if (widget.isLike) ..._heartBurst(t, c) else ..._crackShards(t),
              _centerIcon(t, c),
            ],
          );
        },
      ),
    );
  }

  /// 화면 가장자리가 순간적으로 확 번쩍이고 빠르게 사라짐
  Widget _borderFlash(double t, Color color) {
    final riseT = (t / 0.18).clamp(0.0, 1.0);
    final fadeT = t < 0.18 ? 1.0 : (1.0 - (t - 0.18) / 0.55).clamp(0.0, 1.0);
    final opacity = (riseT * fadeT).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 14),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 60, spreadRadius: -10),
          ],
        ),
      ),
    );
  }

  /// 하트가 여러 조각으로 퍼져나가며 사라지는 버스트
  List<Widget> _heartBurst(double t, TypeDateTokens c) {
    final burstT = Curves.easeOut.transform((t / 0.75).clamp(0.0, 1.0));
    final opacity = t < 0.55 ? 1.0 : (1.0 - (t - 0.55) / 0.45).clamp(0.0, 1.0);
    return [
      for (final angle in _particleAngles)
        Align(
          alignment: const Alignment(0, -0.55),
          child: Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(
                burstT * 90 * math.cos(angle * math.pi / 180),
                burstT * 90 * math.sin(angle * math.pi / 180) - 6,
              ),
              child: Transform.scale(
                scale: 0.5 + burstT * 0.4,
                child: Icon(Icons.favorite, color: c.accentCoral, size: 15),
              ),
            ),
          ),
        ),
    ];
  }

  /// 비호감 — 회색 파편이 살짝 떨어지듯 흩어짐
  List<Widget> _crackShards(double t) {
    final fallT = Curves.easeIn.transform((t / 0.75).clamp(0.0, 1.0));
    final opacity = t < 0.5 ? 1.0 : (1.0 - (t - 0.5) / 0.5).clamp(0.0, 1.0);
    const angles = [-50.0, -15.0, 15.0, 50.0];
    return [
      for (var i = 0; i < angles.length; i++)
        Align(
          alignment: const Alignment(0, -0.55),
          child: Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(
                fallT * 50 * math.cos(angles[i] * math.pi / 180),
                fallT * 60 + fallT * 30 * math.sin(angles[i] * math.pi / 180).abs(),
              ),
              child: Transform.rotate(
                angle: fallT * (i.isEven ? 1 : -1) * 1.2,
                child: const Icon(Icons.close, color: _dislikeGray, size: 10),
              ),
            ),
          ),
        ),
    ];
  }

  Widget _centerIcon(double t, TypeDateTokens c) {
    if (widget.isLike) {
      final scale = t < 0.35 ? 1.0 + (t / 0.35) * 0.35 : 1.35 - ((t - 0.35) / 0.65) * 0.45;
      final opacity = t < 0.6 ? 1.0 : 1.0 - ((t - 0.6) / 0.4);
      final dy = -24 * t;
      return Align(
        alignment: const Alignment(0, -0.55),
        child: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, dy),
            child: Transform.scale(
              scale: scale,
              child: Icon(Icons.favorite, color: c.accentCoral, size: 60),
            ),
          ),
        ),
      );
    } else {
      final shake = (t < 0.7) ? (8 * (1 - t) * ((t * 40).floor().isEven ? 1 : -1)) : 0.0;
      final scale = t < 0.35 ? 1.0 + (t / 0.35) * 0.15 : 1.15 - ((t - 0.35) / 0.65) * 0.3;
      final opacity = t < 0.6 ? 1.0 : 1.0 - ((t - 0.6) / 0.4);
      return Align(
        alignment: const Alignment(0, -0.55),
        child: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(shake, 0),
            child: Transform.scale(
              scale: scale,
              child: const Icon(Icons.heart_broken, color: _dislikeGray, size: 54),
            ),
          ),
        ),
      );
    }
  }
}
