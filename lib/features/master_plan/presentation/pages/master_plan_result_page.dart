import 'package:flutter/material.dart';

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

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _summaryCard({
    required BuildContext context,
    required String title,
    required String value,
    String? subtitle,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lineItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
        trailing: Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
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
            _sectionTitle(context, 'Project Overview'),
            _summaryCard(
              context: context,
              title: 'Category',
              value: _categoryLabel(project.category),
              subtitle: 'Currency: ${_currencyLabel(project.currency)}',
            ),
            const SizedBox(height: 16),
            _summaryCard(
              context: context,
              title: 'Land Area',
              value: '${project.landArea.toStringAsFixed(2)} m²',
              subtitle: '${feddan.toStringAsFixed(2)} feddan',
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, 'Core Metrics'),
            _summaryCard(
              context: context,
              title: 'Master Plan Rate',
              value: rate.toStringAsFixed(2),
            ),
            const SizedBox(height: 16),
            _summaryCard(
              context: context,
              title: 'Planned Hours',
              value: plannedHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, 'Discipline Breakdown'),
            _lineItem(
              context: context,
              title: 'Landscape',
              subtitle: 'Discipline hours',
              value: landscapeHours.toStringAsFixed(2),
            ),
            _lineItem(
              context: context,
              title: 'Urban',
              subtitle: 'Discipline hours',
              value: urbanHours.toStringAsFixed(2),
            ),
            _lineItem(
              context: context,
              title: 'Roads',
              subtitle: 'Discipline hours',
              value: roadsHours.toStringAsFixed(2),
            ),
            _lineItem(
              context: context,
              title: 'Infrastructure Wet',
              subtitle: 'Discipline hours',
              value: wetHours.toStringAsFixed(2),
            ),
            _lineItem(
              context: context,
              title: 'Infrastructure Dry',
              subtitle: 'Discipline hours',
              value: dryHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 24),
            _sectionTitle(context, 'Final Summary'),
            _summaryCard(
              context: context,
              title: 'Total Cost',
              value: _formatCurrency(totalCost),
            ),
            const SizedBox(height: 16),
            _summaryCard(
              context: context,
              title: 'Final Price',
              value: _formatCurrency(finalPrice),
              subtitle: 'Profit Margin: ${project.profitMargin.toStringAsFixed(2)}%',
            ),
          ],
        ),
      ),
    );
  }
}
