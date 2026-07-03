import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../models/models.dart';

/// 선택지 버튼 (A/B/C/D) — UI 디자인 명세서 §4-3
class ChoiceList extends StatelessWidget {
  final List<Choice> choices;
  final Choice? selected;
  final ValueChanged<Choice> onSelect;

  const ChoiceList({
    super.key,
    required this.choices,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final choice in choices) ...[
          _ChoiceButton(
            choice: choice,
            isSelected: selected == choice,
            isHidden: selected != null && selected != choice,
            onTap: selected == null ? () => onSelect(choice) : null,
          ),
          if (choice != choices.last) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _ChoiceButton extends StatefulWidget {
  final Choice choice;
  final bool isSelected;
  final bool isHidden;
  final VoidCallback? onTap;

  const _ChoiceButton({
    required this.choice,
    required this.isSelected,
    required this.isHidden,
    required this.onTap,
  });

  @override
  State<_ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<_ChoiceButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: widget.isHidden ? 0 : 1,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _pressed ? 0.97 : 1.0,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 44),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _pressed
                  ? c.surface.withValues(alpha: 0.16)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.isSelected ? c.accentLavenderDeep : c.textPrimary.withValues(alpha: 0.35),
                width: widget.isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: c.accentLavender,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    widget.choice.label,
                    style: TypeDateTextStyles.choiceLabel(c.accentLavenderText),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.choice.text,
                    style: TypeDateTextStyles.choiceButton(c.textPrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
