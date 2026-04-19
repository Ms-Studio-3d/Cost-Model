import 'package:flutter/material.dart';

class AppSectionTitle extends StatelessWidget {
  const AppSectionTitle(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
      ),
    );
  }
}
