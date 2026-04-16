import 'package:flutter/material.dart';
import 'package:cost_model/core/utils/number_formatter.dart';
import 'package:cost_model/features/master_plan/domain/models/master_plan_project_input.dart';
import 'package:cost_model/features/master_plan/domain/services/master_plan_calculator.dart';
import 'package:cost_model/shared/widgets/result_card.dart';

class MasterPlanResultPage extends StatelessWidget {
  const MasterPlanResultPage({
    super.key,
    required this.input,
  });

  final MasterPlanProjectInput input;

  @override
  Widget build(BuildContext context) {
    final result = MasterPlanCalculator.calculate(input);
    final currency = input.currency;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Plan Results'),
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
              'Category ${input.category}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            ResultCard(
              title: 'Land Area (m²)',
              value: NumberFormatter.number(input.landArea),
            ),
            ResultCard(
              title: 'Land Area (Feddan)',
              value: NumberFormatter.number(result.landAreaFeddan),
            ),
            ResultCard(
              title: 'Rate / Feddan',
              value: NumberFormatter.number(result.ratePerFeddan),
            ),
            ResultCard(
              title: 'Total Hours',
              value: NumberFormatter.number(result.totalHours),
            ),
            ResultCard(
              title: 'Landscape Hours',
              value: NumberFormatter.number(result.landscapeHours),
            ),
            ResultCard(
              title: 'Urban Hours',
              value: NumberFormatter.number(result.urbanHours),
            ),
            ResultCard(
              title: 'Roads Hours',
              value: NumberFormatter.number(result.roadsHours),
            ),
            ResultCard(
              title: 'Infrastructure Wet Hours',
              value: NumberFormatter.number(result.infraWetHours),
            ),
            ResultCard(
              title: 'Infrastructure Dry Hours',
              value: NumberFormatter.number(result.infraDryHours),
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
