import 'package:flutter/material.dart';
import 'package:cost_model/features/master_plan/domain/models/master_plan_project_input.dart';
import 'package:cost_model/features/master_plan/presentation/pages/master_plan_result_page.dart';
import 'package:cost_model/shared/widgets/app_text_field.dart';

class MasterPlanSetupPage extends StatefulWidget {
  const MasterPlanSetupPage({super.key});

  @override
  State<MasterPlanSetupPage> createState() => _MasterPlanSetupPageState();
}

class _MasterPlanSetupPageState extends State<MasterPlanSetupPage> {
  final _projectNameController = TextEditingController();
  final _landAreaController = TextEditingController();
  final _profitMarginController = TextEditingController(text: '30');
  final _otherExpensesController = TextEditingController(text: '0');

  String _selectedCategory = 'B';
  String _selectedCurrency = 'EGP';

  @override
  void dispose() {
    _projectNameController.dispose();
    _landAreaController.dispose();
    _profitMarginController.dispose();
    _otherExpensesController.dispose();
    super.dispose();
  }

  double _parseNumber(String value) {
    return double.tryParse(value.trim()) ?? 0;
  }

  void _calculate() {
    final input = MasterPlanProjectInput(
      projectName: _projectNameController.text.trim().isEmpty
          ? 'Untitled Master Plan Project'
          : _projectNameController.text.trim(),
      category: _selectedCategory,
      landArea: _parseNumber(_landAreaController.text),
      profitMargin: _parseNumber(_profitMarginController.text),
      otherExpenses: _parseNumber(_otherExpensesController.text),
      currency: _selectedCurrency,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MasterPlanResultPage(input: input),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Plan Setup'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Master Plan Information',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the main master plan pricing inputs.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _projectNameController,
              label: 'Project Name',
              hint: 'Enter project name',
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Project Category'),
              items: const [
                DropdownMenuItem(value: 'A', child: Text('A')),
                DropdownMenuItem(value: 'B', child: Text('B')),
                DropdownMenuItem(value: 'C', child: Text('C')),
              ],
              onChanged: (value) {
                setState(() => _selectedCategory = value ?? 'B');
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _landAreaController,
              label: 'Land Area (m²)',
              hint: 'Enter land area',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _profitMarginController,
              label: 'Profit Margin %',
              hint: 'Enter profit margin',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _otherExpensesController,
              label: 'Other Expenses',
              hint: 'Enter other expenses',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedCurrency,
              decoration: const InputDecoration(labelText: 'Currency'),
              items: const [
                DropdownMenuItem(value: 'EGP', child: Text('EGP')),
                DropdownMenuItem(value: 'SAR', child: Text('SAR')),
                DropdownMenuItem(value: 'AED', child: Text('AED')),
              ],
              onChanged: (value) {
                setState(() => _selectedCurrency = value ?? 'EGP');
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate Master Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
