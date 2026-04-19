import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_line_item_card.dart';
import '../../../../shared/widgets/app_metric_card.dart';
import '../../../../shared/widgets/app_section_title.dart';
import '../../../buildings/domain/models/buildings_project.dart' as b_models;
import '../../../buildings/domain/services/building_rate_engine.dart';
import '../../../master_plan/domain/models/master_plan_project.dart' as mp_models;
import '../../../master_plan/domain/services/master_plan_engine.dart';
import '../../domain/models/combined_project.dart';

class CombinedResultsPage extends StatelessWidget {
  const CombinedResultsPage({
    super.key,
    required this.project,
  });

  final CombinedProject project;

  String _buildingCategoryLabel(b_models.ProjectCategory value) {
    switch (value) {
      case b_models.ProjectCategory.a:
        return 'A';
      case b_models.ProjectCategory.b:
        return 'B';
      case b_models.ProjectCategory.c:
        return 'C';
    }
  }

  String _buildingProjectTypeLabel(b_models.BuildingProjectType value) {
    switch (value) {
      case b_models.BuildingProjectType.allProjectTypes:
        return 'All Project Types';
      case b_models.BuildingProjectType.administrative:
        return 'Administrative';
      case b_models.BuildingProjectType.factory:
        return 'Factory';
      case b_models.BuildingProjectType.mixedUse:
        return 'Mixed Use';
      case b_models.BuildingProjectType.residential:
        return 'Residential';
    }
  }

  String _buildingSystemLabel(b_models.ProjectSystem value) {
    switch (value) {
      case b_models.ProjectSystem.cad:
        return 'CAD';
      case b_models.ProjectSystem.bim:
        return 'BIM';
      case b_models.ProjectSystem.both:
        return 'BOTH';
    }
  }

  String _masterPlanCategoryLabel(mp_models.MasterPlanCategory value) {
    switch (value) {
      case mp_models.MasterPlanCategory.a:
        return 'A';
      case mp_models.MasterPlanCategory.b:
        return 'B';
      case mp_models.MasterPlanCategory.c:
        return 'C';
    }
  }

  String _currencyLabel(b_models.Currency value) {
    switch (value) {
      case b_models.Currency.egp:
        return 'EGP';
      case b_models.Currency.sar:
        return 'SAR';
      case b_models.Currency.aed:
        return 'AED';
      case b_models.Currency.usd:
        return 'USD';
    }
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(2)} ${_currencyLabel(project.buildingsProject.currency)}';
  }

  @override
  Widget build(BuildContext context) {
    final buildingsProject = project.buildingsProject;
    final masterPlanProject = project.masterPlanProject;

    final buildingsRate = BuildingRateEngine.calculate(
      category: buildingsProject.projectCategory,
      builtUpArea: buildingsProject.builtUpArea,
    );

    final buildingsPlannedHours = BuildingRateEngine.calculatePlannedHours(
      category: buildingsProject.projectCategory,
      builtUpArea: buildingsProject.builtUpArea,
    );

    final buildingsTotalCost = BuildingRateEngine.calculateTotalCost(
      category: buildingsProject.projectCategory,
      builtUpArea: buildingsProject.builtUpArea,
      idBuiltUpArea: buildingsProject.idBuiltUpArea,
      projectSystem: buildingsProject.projectSystem,
      otherExpenses: buildingsProject.otherExpenses,
    );

    final buildingsFinalPrice = BuildingRateEngine.calculateFinalPrice(
      category: buildingsProject.projectCategory,
      builtUpArea: buildingsProject.builtUpArea,
      idBuiltUpArea: buildingsProject.idBuiltUpArea,
      projectSystem: buildingsProject.projectSystem,
      otherExpenses: buildingsProject.otherExpenses,
      profitMargin: buildingsProject.profitMargin,
    );

    final masterPlanRate = MasterPlanEngine.calculateRate(
      category: masterPlanProject.category,
      landArea: masterPlanProject.landArea,
    );

    final masterPlanPlannedHours = MasterPlanEngine.calculatePlannedHours(
      category: masterPlanProject.category,
      landArea: masterPlanProject.landArea,
    );

    final masterPlanTotalCost = MasterPlanEngine.calculateTotalCost(
      category: masterPlanProject.category,
      landArea: masterPlanProject.landArea,
      otherExpenses: masterPlanProject.otherExpenses,
    );

    final masterPlanFinalPrice = MasterPlanEngine.calculateFinalPrice(
      category: masterPlanProject.category,
      landArea: masterPlanProject.landArea,
      otherExpenses: masterPlanProject.otherExpenses,
      profitMargin: masterPlanProject.profitMargin,
    );

    final combinedHours = buildingsPlannedHours + masterPlanPlannedHours;
    final combinedCost = buildingsTotalCost + masterPlanTotalCost;
    final combinedPrice = buildingsFinalPrice + masterPlanFinalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Results'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Combined Project Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page combines Buildings and Master Plan results in one summary.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Combined Totals'),
            AppMetricCard(
              title: 'Combined Planned Hours',
              value: combinedHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Combined Total Cost',
              value: _formatCurrency(combinedCost),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Combined Final Price',
              value: _formatCurrency(combinedPrice),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Buildings Summary'),
            AppLineItemCard(
              title: 'Buildings Category',
              subtitle: _buildingProjectTypeLabel(buildingsProject.projectType),
              value: _buildingCategoryLabel(buildingsProject.projectCategory),
            ),
            AppLineItemCard(
              title: 'Buildings System',
              subtitle:
                  'BUA ${buildingsProject.builtUpArea.toStringAsFixed(2)} / ID ${buildingsProject.idBuiltUpArea.toStringAsFixed(2)}',
              value: _buildingSystemLabel(buildingsProject.projectSystem),
            ),
            AppLineItemCard(
              title: 'Buildings Rate',
              subtitle: 'Calculated building rate',
              value: buildingsRate.toStringAsFixed(3),
            ),
            AppLineItemCard(
              title: 'Buildings Planned Hours',
              subtitle: 'Calculated from BUA × rate',
              value: buildingsPlannedHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Buildings Total Cost',
              subtitle: 'Department cost + other expenses',
              value: _formatCurrency(buildingsTotalCost),
            ),
            AppLineItemCard(
              title: 'Buildings Final Price',
              subtitle:
                  'Profit Margin ${buildingsProject.profitMargin.toStringAsFixed(2)}%',
              value: _formatCurrency(buildingsFinalPrice),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Master Plan Summary'),
            AppLineItemCard(
              title: 'Master Plan Category',
              subtitle:
                  'Land Area ${masterPlanProject.landArea.toStringAsFixed(2)} m²',
              value: _masterPlanCategoryLabel(masterPlanProject.category),
            ),
            AppLineItemCard(
              title: 'Master Plan Rate',
              subtitle: 'Calculated master plan rate',
              value: masterPlanRate.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Master Plan Planned Hours',
              subtitle: 'Calculated from land area',
              value: masterPlanPlannedHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Master Plan Total Cost',
              subtitle: 'Department cost + other expenses',
              value: _formatCurrency(masterPlanTotalCost),
            ),
            AppLineItemCard(
              title: 'Master Plan Final Price',
              subtitle:
                  'Profit Margin ${masterPlanProject.profitMargin.toStringAsFixed(2)}%',
              value: _formatCurrency(masterPlanFinalPrice),
            ),
          ],
        ),
      ),
    );
  }
}
