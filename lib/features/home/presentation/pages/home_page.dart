import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/project_type_card.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openDashboard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DashboardPage(),
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
              'Start Pricing',
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
              title: 'Open Dashboard',
              description:
                  'Access Buildings, Master Plan, and Combined modules from one place.',
              icon: Icons.space_dashboard_rounded,
              onTap: () => _openDashboard(context),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Progress',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'The app now includes:\n'
                      '• Buildings workflow\n'
                      '• Master Plan workflow\n'
                      '• Combined workflow\n'
                      '• Results screens\n'
                      '• Costing and pricing calculations',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF374151),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
