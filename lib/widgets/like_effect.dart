import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// 호감도 이펙트 (❤️ / 💔) — UI 디자인 명세서 §4-4. 점수/숫자 노출 금지.
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;
          if (widget.isLike) {
            final scale = t < 0.4 ? 1.0 + (t / 0.4) * 0.2 : 1.2 - ((t - 0.4) / 0.6) * 0.3;
            final opacity = t < 0.7 ? 1.0 : 1.0 - ((t - 0.7) / 0.3);
            final dy = -20 * t;
            return Align(
              alignment: const Alignment(0, -0.55),
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, dy),
                  child: Transform.scale(
                    scale: scale,
                    child: Icon(Icons.favorite, color: c.accentCoral, size: 56),
                  ),
                ),
              ),
            );
          } else {
            final shake = (t < 0.8) ? (8 * (1 - t) * ((t * 40).floor().isEven ? 1 : -1)) : 0.0;
            final opacity = t < 0.7 ? 1.0 : 1.0 - ((t - 0.7) / 0.3);
            return Align(
              alignment: const Alignment(0, -0.55),
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(shake, 0),
                  child: Icon(Icons.heart_broken, color: c.breakBlue, size: 52),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
