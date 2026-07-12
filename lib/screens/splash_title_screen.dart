import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../widgets/common.dart';
import 'name_input_screen.dart';
import 'character_select_screen.dart';

class SplashTitleScreen extends StatelessWidget {
  const SplashTitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: GlowBackground(
        child: SafeArea(
        child: Column(
          children: [
            const PhoneStatusBar(),
            Expanded(
              child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // 폰트 워밍업 — 이모지/특수문자는 Pretendard에 글리프가 없어서 CanvasKit이
              // Noto 폰트를 런타임에 내려받는다. 앱 중간에 처음 만나면 글자가 깨졌다
              // 돌아오는 것처럼 보이므로, 스플래시에서 투명 텍스트로 미리 그려
              // 다운로드와 전역 재레이아웃을 여기서 미리 끝내둔다.
              const Text(
                '—「」→─☆★❤️⚡•🌙🌟👀💔💘💨💪🔍🔥😊🤝',
                style: TextStyle(color: Colors.transparent, fontSize: 1),
              ),
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              const Spacer(flex: 3),
              Image.asset(
                'assets/images/logo_mark.png',
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
                  MaterialPageRoute(builder: (_) => const NameInputScreen()),
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
          ],
        ),
        ),
      ),
    );
  }
}
