import 'package:flutter/material.dart';
import 'package:cost_model/core/constants/app_strings.dart';
import 'package:cost_model/shared/widgets/project_type_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showComingSoon(BuildContext context, String projectType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$projectType screen is coming next.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              AppStrings.startNewProject,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.appSubtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            ProjectTypeCard(
              title: AppStrings.buildings,
              description:
                  'Create a pricing scenario for building disciplines and phases.',
              icon: Icons.apartment_rounded,
              onTap: () => _showComingSoon(context, AppStrings.buildings),
            ),
            ProjectTypeCard(
              title: AppStrings.masterPlan,
              description:
                  'Create a pricing scenario for master plan disciplines and land area.',
              icon: Icons.map_rounded,
              onTap: () => _showComingSoon(context, AppStrings.masterPlan),
            ),
            ProjectTypeCard(
              title: AppStrings.combined,
              description:
                  'Combine buildings and master plan pricing in one project.',
              icon: Icons.dashboard_customize_rounded,
              onTap: () => _showComingSoon(context, AppStrings.combined),
            ),
          ],
        ),
      ),
    );
  }
}
