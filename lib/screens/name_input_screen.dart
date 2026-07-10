import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../state/game_state.dart';
import '../widgets/common.dart';
import 'prologue_screen.dart';

/// 시작 시 사용자 이름을 입력받는 화면 — 이후 소개팅 상대가 "{이름}씨"로 불러줌
class NameInputScreen extends ConsumerStatefulWidget {
  const NameInputScreen({super.key});

  @override
  ConsumerState<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends ConsumerState<NameInputScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    ref.read(userNameProvider.notifier).setName(name);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PrologueScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: GlowBackground(
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(alignment: Alignment.topRight, child: ThemeToggleButton()),
              const Spacer(flex: 3),
              Text('만나기 전에,', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
              const SizedBox(height: 8),
              Text(
                '상대가 당신을 뭐라고 부르면 좋을까요?',
                style: TypeDateTextStyles.resultTitle(c.textPrimary).copyWith(fontSize: 20),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                onChanged: (_) => setState(() {}),
                style: TypeDateTextStyles.chatMessage(c.textPrimary),
                decoration: InputDecoration(
                  hintText: '이름 또는 닉네임',
                  hintStyle: TypeDateTextStyles.chatMessage(c.textMuted),
                  filled: true,
                  fillColor: c.surface.withValues(alpha: 0.72),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: c.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: c.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: c.accentCoral, width: 1.5),
                  ),
                ),
              ),
              const Spacer(flex: 4),
              CoralButton(
                label: '다음',
                onPressed: _controller.text.trim().isEmpty ? null : _submit,
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
