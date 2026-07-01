import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';
import 'prologue_screen.dart';
import 'character_select_screen.dart';

class SplashTitleScreen extends StatelessWidget {
  const SplashTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Image.asset(
                'assets/images/소개팅신 배경.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                '당신의 진짜 인연을 찾아드립니다',
                style: TypeDateTextStyles.caption(c.textSecondary),
              ),
              const Spacer(flex: 4),
              CoralButton(
                label: '시작하기',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PrologueScreen()),
                ),
              ),
              const SizedBox(height: 12),
              CoralButton(
                label: '이어하기',
                outlined: true,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CharacterSelectScreen()),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
