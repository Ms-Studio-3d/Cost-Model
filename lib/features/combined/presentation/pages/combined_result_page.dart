import 'package:flutter/material.dart';
import 'package:cost_model/core/utils/number_formatter.dart';
import 'package:cost_model/features/buildings/domain/models/buildings_project_input.dart';
import 'package:cost_model/features/buildings/domain/services/buildings_calculator.dart';
import 'package:cost_model/features/master_plan/domain/models/master_plan_project_input.dart';
import 'package:cost_model/features/master_plan/domain/services/master_plan_calculator.dart';
import 'package:cost_model/shared/widgets/result_card.dart';

class CombinedResultPage extends StatelessWidget {
  const CombinedResultPage({
    super.key,
    required this.buildingsInput,
    required this.masterPlanInput,
    required this.otherExpenses,
  });

  final BuildingsProjectInput buildingsInput;
  final MasterPlanProjectInput masterPlanInput;
  final double otherExpenses;

  @override
  Widget build(BuildContext context) {
    final buildings = BuildingsCalculator.calculate(buildingsInput);
    final masterPlan = MasterPlanCalculator.calculate(masterPlanInput);

    final totalHours = buildings.totalPlannedHours + masterPlan.totalHours;
    final totalCost = buildings.totalCost + masterPlan.totalCost;
    final totalPrice =
        buildings.totalPrice + masterPlan.totalPrice + otherExpenses;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Results'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              buildingsInput.projectName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buildings + Master Plan',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            ResultCard(
              title: 'Buildings Cost',
              value:
                  '${NumberFormatter.money(buildings.totalCost)} ${buildingsInput.currency}',
            ),
            ResultCard(
              title: 'Buildings Price',
              value:
                  '${NumberFormatter.money(buildings.totalPrice)} ${buildingsInput.currency}',
            ),
            ResultCard(
              title: 'Master Plan Cost',
              value:
                  '${NumberFormatter.money(masterPlan.totalCost)} ${buildingsInput.currency}',
            ),
            ResultCard(
              title: 'Master Plan Price',
              value:
                  '${NumberFormatter.money(masterPlan.totalPrice)} ${buildingsInput.currency}',
            ),
            ResultCard(
              title: 'Combined Hours',
              value: NumberFormatter.number(totalHours),
            ),
            ResultCard(
              title: 'Combined Cost',
              value:
                  '${NumberFormatter.money(totalCost)} ${buildingsInput.currency}',
            ),
            ResultCard(
              title: 'Combined Price',
              value:
                  '${NumberFormatter.money(totalPrice)} ${buildingsInput.currency}',
            ),
          ],
        ),
      ),
    );
  }
}
