import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_line_item_card.dart';
import '../../../../shared/widgets/app_metric_card.dart';
import '../../../../shared/widgets/app_section_title.dart';
import '../../domain/models/buildings_project.dart';
import '../../domain/services/building_rate_engine.dart';

class BuildingsResultsPage extends StatelessWidget {
  const BuildingsResultsPage({
    super.key,
    required this.project,
  });

  final BuildingsProject project;

  String _currencyLabel(Currency value) {
    switch (value) {
      case Currency.egp:
        return 'EGP';
      case Currency.sar:
        return 'SAR';
      case Currency.aed:
        return 'AED';
      case Currency.usd:
        return 'USD';
    }
  }

  String _projectSystemLabel(ProjectSystem value) {
    switch (value) {
      case ProjectSystem.cad:
        return 'CAD';
      case ProjectSystem.bim:
        return 'BIM';
      case ProjectSystem.both:
        return 'BOTH';
    }
  }

  String _categoryLabel(ProjectCategory value) {
    switch (value) {
      case ProjectCategory.a:
        return 'A';
      case ProjectCategory.b:
        return 'B';
      case ProjectCategory.c:
        return 'C';
    }
  }

  String _projectTypeLabel(BuildingProjectType value) {
    switch (value) {
      case BuildingProjectType.allProjectTypes:
        return 'All Project Types';
      case BuildingProjectType.administrative:
        return 'Administrative';
      case BuildingProjectType.factory:
        return 'Factory';
      case BuildingProjectType.mixedUse:
        return 'Mixed Use';
      case BuildingProjectType.residential:
        return 'Residential';
    }
  }

  String _bimCadLabel() {
    return project.projectSystem == ProjectSystem.cad ? 'CAD' : 'BIM';
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(2)} ${_currencyLabel(project.currency)}';
  }

  @override
  Widget build(BuildContext context) {
    final rate = BuildingRateEngine.calculate(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final plannedHours = BuildingRateEngine.calculatePlannedHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final productionHours = BuildingRateEngine.calculateProductionHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final supportiveHours = BuildingRateEngine.calculateSupportiveHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final architectureHours = BuildingRateEngine.calculateArchitectureHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final structureHours = BuildingRateEngine.calculateStructureHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final electricalHours = BuildingRateEngine.calculateElectricalHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final plumbingHours = BuildingRateEngine.calculatePlumbingHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final hvacHours = BuildingRateEngine.calculateHvacHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final qsHours = BuildingRateEngine.calculateQsHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final idHours = BuildingRateEngine.calculateIdHours(
      idBuiltUpArea: project.idBuiltUpArea,
    );

    final pmHours = BuildingRateEngine.calculateProjectManagementHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final qcHours = BuildingRateEngine.calculateQualityControlHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final bimCadHours = BuildingRateEngine.calculateBimCadHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final dcHours = BuildingRateEngine.calculateDocumentControlHours(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final architectureCost = BuildingRateEngine.calculateArchitectureCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final structureCost = BuildingRateEngine.calculateStructureCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final electricalCost = BuildingRateEngine.calculateElectricalCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final plumbingCost = BuildingRateEngine.calculatePlumbingCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final hvacCost = BuildingRateEngine.calculateHvacCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final qsCost = BuildingRateEngine.calculateQsCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
    );

    final idCost = BuildingRateEngine.calculateIdCost(
      idBuiltUpArea: project.idBuiltUpArea,
    );

    final pmCost = BuildingRateEngine.calculateProjectManagementCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final qcCost = BuildingRateEngine.calculateQualityControlCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final bimCadCost = BuildingRateEngine.calculateBimCadCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final dcCost = BuildingRateEngine.calculateDocumentControlCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      projectSystem: project.projectSystem,
    );

    final totalCost = BuildingRateEngine.calculateTotalCost(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      idBuiltUpArea: project.idBuiltUpArea,
      projectSystem: project.projectSystem,
      otherExpenses: project.otherExpenses,
    );

    final finalPrice = BuildingRateEngine.calculateFinalPrice(
      category: project.projectCategory,
      builtUpArea: project.builtUpArea,
      idBuiltUpArea: project.idBuiltUpArea,
      projectSystem: project.projectSystem,
      otherExpenses: project.otherExpenses,
      profitMargin: project.profitMargin,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buildings Results'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Final Buildings Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page shows the current calculation snapshot for the buildings module.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Project Overview'),
            AppMetricCard(
              title: 'Category',
              value: _categoryLabel(project.projectCategory),
              subtitle: _projectTypeLabel(project.projectType),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Project System',
              value: _projectSystemLabel(project.projectSystem),
              subtitle: 'Currency: ${_currencyLabel(project.currency)}',
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Areas',
              value:
                  'BUA ${project.builtUpArea.toStringAsFixed(2)} / ID ${project.idBuiltUpArea.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Core Metrics'),
            AppMetricCard(
              title: 'Building Rate',
              value: rate.toStringAsFixed(3),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Planned Hours',
              value: plannedHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Production Hours',
              value: productionHours.toStringAsFixed(2),
              subtitle: '85% of planned hours',
            ),
            const SizedBox(height: 16),
            AppMetricCard(
              title: 'Supportive Hours',
              value: supportiveHours.toStringAsFixed(2),
              subtitle: '15% of planned hours',
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Production Breakdown'),
            AppLineItemCard(
              title: 'Architecture',
              subtitle: 'Production department hours',
              value: architectureHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Structure',
              subtitle: 'Production department hours',
              value: structureHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Electrical',
              subtitle: 'Production department hours',
              value: electricalHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Plumbing',
              subtitle: 'Production department hours',
              value: plumbingHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'HVAC',
              subtitle: 'Production department hours',
              value: hvacHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'QS',
              subtitle: 'Production department hours',
              value: qsHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'ID',
              subtitle: 'ID-based hours',
              value: idHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Supportive Breakdown'),
            AppLineItemCard(
              title: 'Project Management',
              subtitle: 'Supportive department hours',
              value: pmHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Quality Control',
              subtitle: 'Supportive department hours',
              value: qcHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: _bimCadLabel(),
              subtitle: 'System-based supportive hours',
              value: bimCadHours.toStringAsFixed(2),
            ),
            AppLineItemCard(
              title: 'Document Control',
              subtitle: 'Supportive department hours',
              value: dcHours.toStringAsFixed(2),
            ),
            const SizedBox(height: 24),
            const AppSectionTitle('Cost Breakdown'),
            AppLineItemCard(
              title: 'Architecture Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(architectureCost),
            ),
            AppLineItemCard(
              title: 'Structure Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(structureCost),
            ),
            AppLineItemCard(
              title: 'Electrical Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(electricalCost),
            ),
            AppLineItemCard(
              title: 'Plumbing Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(plumbingCost),
            ),
            AppLineItemCard(
              title: 'HVAC Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(hvacCost),
            ),
            AppLineItemCard(
              title: 'QS Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(qsCost),
            ),
            AppLineItemCard(
              title: 'ID Cost',
              subtitle: 'Hours × rate',
              value: _formatCurrency(idCost),
            ),
            AppLineItemCard(
              title: 'Project Management Cost',
              subtitle: 'Supportive department cost',
              value: _formatCurrency(pmCost),
            ),
            AppLineItemCard(
              title: 'Quality Control Cost',
              subtitle: 'Supportive department cost',
              value: _formatCurrency(qcCost),
            ),
            AppLineItemCard(
              title: '${_bimCadLabel()} Cost',
              subtitle: 'Supportive department cost',
              value: _formatCurrency(bimCadCost),
            ),
            AppLineItemCard(
              title: 'Document Control Cost',
              subtitle: 'Supportive department cost',
              value: _formatCurrency(dcCost),
            ),
            AppLineItemCard(
              title: 'Other Expenses',
              subtitle: 'Direct expenses',
              value: _formatCurrency(project.otherExpenses),
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
