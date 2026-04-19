import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_line_item_card.dart';
import '../../../../shared/widgets/app_metric_card.dart';
import '../../../../shared/widgets/app_section_title.dart';
import '../../domain/models/master_plan_project.dart';
import '../../domain/services/master_plan_engine.dart';

class MasterPlanResultsPage extends StatelessWidget {
  const MasterPlanResultsPage({
    super.key,
    required this.project,
  });

  final MasterPlanProject project;

  String _categoryLabel(MasterPlanCategory value) {
    switch (value) {
      case MasterPlanCategory.a:
        return 'A';
      case MasterPlanCategory.b:
        return 'B';
      case MasterPlanCategory.c:
        return 'C';
    }
  }

  String _currencyLabel(MasterPlanCurrency value) {
    switch (value) {
      case MasterPlanCurrency.egp:
        return 'EGP';
      case MasterPlanCurrency.sar:
        return 'SAR';
      case MasterPlanCurrency.aed:
        return 'AED';
      case MasterPlanCurrency.usd:
        return 'USD';
    }
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(2)} ${_currencyLabel(project.currency)}';
  }

  @override
  Widget build(BuildContext context) {
    final feddan = MasterPlanEngine.landAreaToFeddan(project.landArea);
    final rate = MasterPlanEngine.calculateRate(
      category: project.category,
      landArea: project.landArea,
    );
    final plannedHours = MasterPlanEngine.calculatePlannedHours(
      category: project.category,
      landArea: project.landArea,
    );

    final landscapeHours = MasterPlanEngine.calculateLandscapeHours(
      category: project.category,
      landArea: project.landArea,
    );
    final urbanHours = MasterPlanEngine.calculateUrbanHours(
      category: project.category,
      landArea: project.landArea,
    );
    final roadsHours = MasterPlanEngine.calculateRoadsHours(
      category: project.category,
      landArea: project.landArea,
    );
    final wetHours = MasterPlanEngine.calculateInfrastructureWetHours(
      category: project.category,
      landArea: project.landArea,
    );
    final dryHours = MasterPlanEngine.calculateInfrastructureDryHours(
      category: project.category,
      landArea: project.landArea,
    );

    final totalCost = MasterPlanEngine.calculateTotalCost(
      category: project.category,
      landArea: project.landArea,
      otherExpenses: project.otherExpenses,
    );
    final finalPrice = MasterPlanEngine.calculateFinalPrice(
      category: project.category,
      landArea: project.landArea,
      otherExpenses: project.otherExpenses,
      profitMargin: project.profitMargin,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Plan Results'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Final Master Plan Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page shows the current calculation snapshot for the master plan module.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Project Overview'),
            AppMetricCard(
              title: 'Category',
              value: _categoryLabel(project.category),
              subtitle: 'Currency: ${_currencyLabel(project.currency)}',
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Land Area',
              value: '${project.landArea.toStringAsFixed(2)} m²',
              subtitle: '${feddan.toStringAsFixed(2)} feddan',
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Core Metrics'),
            AppMetricCard(
              title: 'Master Plan Rate',
              value: rate.toStringAsFixed(2),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Planned Hours',
              value: plannedHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Discipline Breakdown'),
            AppLineItemCard(
              title: 'Landscape',
              subtitle: 'Discipline hours',
              value: landscapeHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Urban',
              subtitle: 'Discipline hours',
              value: urbanHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Roads',
              subtitle: 'Discipline hours',
              value: roadsHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Infrastructure Wet',
              subtitle: 'Discipline hours',
              value: wetHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Infrastructure Dry',
              subtitle: 'Discipline hours',
              value: dryHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Final Summary'),
            AppMetricCard(
              title: 'Total Cost',
              value: _formatCurrency(totalCost),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Final Price',
              value: _formatCurrency(finalPrice),
              subtitle:
                  'Profit Margin: ${project.profitMargin.toStringAsFixed(2)}%',
            ),
          ],
        ),
      ),
    );
  }
}
