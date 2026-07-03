import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episode1_data.dart';
import '../widgets/kakao_chat_view.dart';
import '../widgets/common.dart';
import 'character_select_screen.dart';

/// 프롤로그 — Scene 1(민준) → Scene 2(온보딩) → Scene 3(배정 카드)
class PrologueScreen extends StatefulWidget {
  const PrologueScreen({super.key});

  @override
  State<PrologueScreen> createState() => _PrologueScreenState();
}

enum _PrologueStep { minjun, onboarding, assignment }

class _PrologueScreenState extends State<PrologueScreen> {
  _PrologueStep _step = _PrologueStep.minjun;

  @override
  Widget build(BuildContext context) {
    switch (_step) {
      case _PrologueStep.minjun:
        return KakaoChatView(
          key: const ValueKey('minjun'),
          contactName: '최민준',
          lines: prologueLines,
          onComplete: () => setState(() => _step = _PrologueStep.onboarding),
        );
      case _PrologueStep.onboarding:
        return _OnboardingScene(
          onNext: () => setState(() => _step = _PrologueStep.assignment),
        );
      case _PrologueStep.assignment:
        return _AssignmentScene(
          onNext: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const CharacterSelectScreen()),
          ),
        );
    }
  }
}

class _OnboardingScene extends StatelessWidget {
  final VoidCallback onNext;
  const _OnboardingScene({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              const Spacer(flex: 2),
              Image.asset('assets/images/logo.png', width: 100, height: 100),
              const SizedBox(height: 8),
              const SizedBox(height: 24),
              Text(
                '"당신의 진짜 인연을 찾아드립니다"',
                textAlign: TextAlign.center,
                style: TypeDateTextStyles.screenTitle(c.textPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                '16가지 유형의 상대를 만나보세요.\n16번의 만남이 끝날 때,\n당신이 진짜 설레는 인연 유형이 밝혀집니다.',
                textAlign: TextAlign.center,
                style: TypeDateTextStyles.chatMessage(c.textSecondary),
              ),
              const SizedBox(height: 28),
              Text(
                '...혹시 진짜 있긴 한 건가.',
                style: TypeDateTextStyles.monologue(c.textMuted),
              ),
              const Spacer(flex: 3),
              CoralButton(label: '시작하기', onPressed: onNext),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssignmentScene extends StatelessWidget {
  final VoidCallback onNext;
  const _AssignmentScene({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: c.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('💘', style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 8),
                        Text('첫 번째 인연', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _InfoRow(label: '상대', value: '지수 (26세)', c: c),
                    _InfoRow(label: '직업', value: '콘텐츠 기획자', c: c),
                    _InfoRow(label: '장소', value: '홍대 카페', c: c),
                    _InfoRow(label: '시간', value: '오늘 오후 2시', c: c),
                    const SizedBox(height: 16),
                    Text(
                      '"이 사람이 당신의 인연일까요?"',
                      style: TypeDateTextStyles.chatMessage(c.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('...뭐, 한번 보긴 해야겠지.',
                  style: TypeDateTextStyles.monologue(c.textMuted)),
              const SizedBox(height: 32),
              CoralButton(label: '소개팅 출발하기', onPressed: onNext),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TypeDateTokens c;
  const _InfoRow({required this.label, required this.value, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(label, style: TypeDateTextStyles.caption(c.textMuted)),
          ),
          Text(value, style: TypeDateTextStyles.chatMessage(c.textPrimary)),
        ],
      ),
    );
  }
}
