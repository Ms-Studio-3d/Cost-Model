import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_metric_card.dart';
import '../../../buildings/presentation/pages/buildings_setup_page.dart';
import '../../../combined/presentation/pages/combined_setup_page.dart';
import '../../../master_plan/presentation/pages/master_plan_setup_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget _moduleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  void _openBuildings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BuildingsSetupPage(),
      ),
    );
  }

  void _openMasterPlan(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const MasterPlanSetupPage(),
      ),
    );
  }

  void _openCombined(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CombinedSetupPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Cost Model Dashboard',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a module to start a pricing scenario or continue estimating.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(
                  child: AppMetricCard(
                    title: 'Modules',
                    value: '3',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: AppMetricCard(
                    title: 'Status',
                    value: 'Ready',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _moduleCard(
              context: context,
              title: 'Buildings',
              subtitle:
                  'Building pricing, scope matrix, validation factors, costing and results.',
              icon: Icons.apartment_rounded,
              onTap: () => _openBuildings(context),
            ),
            _moduleCard(
              context: context,
              title: 'Master Plan',
              subtitle:
                  'Land area based pricing, discipline distribution, costing and results.',
              icon: Icons.map_rounded,
              onTap: () => _openMasterPlan(context),
            ),
            _moduleCard(
              context: context,
              title: 'Combined',
              subtitle:
                  'Create one scenario that includes Buildings and Master Plan together.',
              icon: Icons.dashboard_customize_rounded,
              onTap: () => _openCombined(context),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current App Scope',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '• Buildings module\n'
                      '• Master Plan module\n'
                      '• Combined module\n'
                      '• Results pages\n'
                      '• Costing and pricing engine',
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
