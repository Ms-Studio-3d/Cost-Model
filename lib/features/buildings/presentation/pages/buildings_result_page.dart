import 'package:flutter/material.dart';
import 'package:cost_model/core/utils/number_formatter.dart';
import 'package:cost_model/features/buildings/domain/models/buildings_project_input.dart';
import 'package:cost_model/features/buildings/domain/services/buildings_calculator.dart';
import 'package:cost_model/shared/widgets/result_card.dart';

class BuildingsResultPage extends StatelessWidget {
  const BuildingsResultPage({
    super.key,
    required this.input,
  });

  final BuildingsProjectInput input;

  @override
  Widget build(BuildContext context) {
    final result = BuildingsCalculator.calculate(input);
    final currency = input.currency;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buildings Results'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              input.projectName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${input.projectType} • ${input.projectSystem} • Category ${input.category}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            ResultCard(
              title: 'Rate / sqm',
              value: NumberFormatter.number(result.ratePerSqm),
            ),
            ResultCard(
              title: 'Total Planned Hours',
              value: NumberFormatter.number(result.totalPlannedHours),
            ),
            ResultCard(
              title: 'Production Hours',
              value: NumberFormatter.number(result.productionHours),
            ),
            ResultCard(
              title: 'Supportive Hours',
              value: NumberFormatter.number(result.supportiveHours),
            ),
            ResultCard(
              title: 'Architecture Hours',
              value: NumberFormatter.number(result.architectureHours),
            ),
            ResultCard(
              title: 'Structure Hours',
              value: NumberFormatter.number(result.structureHours),
            ),
            ResultCard(
              title: 'Electrical Hours',
              value: NumberFormatter.number(result.electricalHours),
            ),
            ResultCard(
              title: 'Plumbing Hours',
              value: NumberFormatter.number(result.plumbingHours),
            ),
            ResultCard(
              title: 'HVAC Hours',
              value: NumberFormatter.number(result.hvacHours),
            ),
            ResultCard(
              title: 'QS Hours',
              value: NumberFormatter.number(result.qsHours),
            ),
            ResultCard(
              title: 'ID Hours',
              value: NumberFormatter.number(result.idHours),
            ),
            ResultCard(
              title: 'Estimated Cost',
              value: '${NumberFormatter.money(result.totalCost)} $currency',
            ),
            ResultCard(
              title: 'Estimated Price',
              value: '${NumberFormatter.money(result.totalPrice)} $currency',
            ),
          ],
        ),
      ),
    );
  }
}
