import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';

class StepperButtonWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const StepperButtonWidget({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray200),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _StepperButton(
            icon: Icons.remove,
            tooltip: 'Decrease quantity',
            onTap: onDecrement,
          ),
        ),
        SizedBox(
          width: 24,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray200),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _StepperButton(
            icon: Icons.add,
            tooltip: 'Increase quantity',
            onTap: onIncrement,
          ),
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _StepperButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 36,
              height: 36,
              child: Center(
                child: Icon(icon, size: 18, color: AppColors.gray900),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
