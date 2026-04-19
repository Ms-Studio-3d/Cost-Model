import 'package:flutter/material.dart';

import '../../domain/models/buildings_project.dart';

class ScopeModeChip extends StatelessWidget {
  const ScopeModeChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: selected ? Colors.white : const Color(0xFF374151),
      ),
      selectedColor: theme.colorScheme.primary,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? theme.colorScheme.primary
              : const Color(0xFFD1D5DB),
        ),
      ),
      showCheckmark: false,
    );
  }
}

String scopeModeLabel(ScopeMode mode) {
  switch (mode) {
    case ScopeMode.full:
      return 'Full';
    case ScopeMode.validation:
      return 'Validation';
    case ScopeMode.off:
      return 'Off';
  }
}
