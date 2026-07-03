import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../data/episode1_data.dart';
import '../models/models.dart';
import '../widgets/common.dart';

/// SNS 공유용 카드 — PRD §8-3
class SnsCardScreen extends StatelessWidget {
  final DateResult result;
  const SnsCardScreen({super.key, required this.result});

  String get _endingEmoji {
    switch (result.ending) {
      case Ending.success:
        return '💘';
      case Ending.friend:
        return '🤝';
      case Ending.fail:
        return '💨';
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = styleInfoMap[result.styleType] ?? styleInfoMap['EF']!;

    return Scaffold(
      backgroundColor: c.bg,
      appBar: AppBar(
        backgroundColor: c.bg,
        elevation: 0,
        iconTheme: IconThemeData(color: c.textPrimary),
        title: Text('공유 카드', style: TypeDateTextStyles.screenTitle(c.textPrimary)),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: c.bg,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: c.border, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite, size: 16, color: c.accentCoral),
                              const SizedBox(width: 6),
                              Text('TYPE DATE',
                                  style: TypeDateTextStyles.choiceLabel(c.textSecondary)),
                            ],
                          ),
                          const Spacer(flex: 2),
                          Text(style.emoji, style: const TextStyle(fontSize: 40)),
                          const SizedBox(height: 12),
                          Text(
                            style.title,
                            textAlign: TextAlign.center,
                            style: TypeDateTextStyles.resultTitle(c.textPrimary),
                          ),
                          const SizedBox(height: 20),
                          Text('추정 유형   ????',
                              style: TypeDateTextStyles.chatMessage(c.textSecondary)),
                          const SizedBox(height: 6),
                          Text('궁합   ${style.compatibilityStars}',
                              style: TypeDateTextStyles.chatMessage(c.accentCoral)),
                          const Spacer(flex: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '"${style.summary}"',
                              textAlign: TextAlign.center,
                              style: TypeDateTextStyles.monologue(c.textSecondary),
                            ),
                          ),
                          const Spacer(flex: 2),
                          Text('$_endingEmoji   1 / 16',
                              style: TypeDateTextStyles.choiceButton(c.textPrimary)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CoralButton(
                      label: '저장',
                      outlined: true,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('데모 버전에서는 저장 기능이 비활성화되어 있어요')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CoralButton(
                      label: '공유',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('데모 버전에서는 공유 기능이 비활성화되어 있어요')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
