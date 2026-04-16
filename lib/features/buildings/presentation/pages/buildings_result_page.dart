import 'package:flutter/material.dart';
import 'package:cost_model/features/buildings/domain/models/buildings_project_input.dart';

class BuildingsResultPage extends StatelessWidget {
  const BuildingsResultPage({
    super.key,
    required this.project,
  });

  final BuildingsProjectInput project;

  String _format(double value) {
    return value.toStringAsFixed(2);
  }

  Widget _resultCard(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              project.projectName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${project.projectType} • ${project.projectSystem} • Category ${project.category}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            _resultCard(
              context,
              'Built Up Area',
              '${_format(project.builtUpArea)} ${project.currency}',
            ),
            _resultCard(
              context,
              'ID Built Up Area',
              '${_format(project.idBuiltUpArea)} ${project.currency}',
            ),
            _resultCard(
              context,
              'Assumed Rate',
              _format(project.assumedRatePerSqm),
            ),
            _resultCard(
              context,
              'Planned Hours',
              _format(project.plannedHours),
            ),
            _resultCard(
              context,
              'Estimated Cost',
              '${_format(project.estimatedCost)} ${project.currency}',
            ),
            _resultCard(
              context,
              'Estimated Price',
              '${_format(project.estimatedPrice)} ${project.currency}',
            ),
          ],
        ),
      ),
    );
  }
}
