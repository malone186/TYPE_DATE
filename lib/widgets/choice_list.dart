import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/theme.dart';
import '../models/models.dart';

/// 선택지 라벨(A/B/C/D)을 브랜드 그라디언트의 한 지점에 매핑 — 점(dot) 색상용.
Color _dotColorFor(String label, TypeDateTokens c) {
  switch (label) {
    case 'A':
      return c.accentCoral;
    case 'B':
      return c.accentCoralSoft;
    case 'C':
      return c.accentLavender;
    case 'D':
      return c.accentLavenderDeep;
    default:
      return c.accentCoral;
  }
}

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 44),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: c.surface.withValues(alpha: _pressed ? 0.85 : 0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.isSelected
                        ? c.accentLavenderDeep
                        : c.textPrimary.withValues(alpha: 0.08),
                    width: widget.isSelected ? 1.5 : 0.5,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: _dotColorFor(widget.choice.label, c),
                        shape: BoxShape.circle,
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
        ),
      ),
    );
  }
}
