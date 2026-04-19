import 'package:flutter/material.dart';

import '../../domain/models/master_plan_project.dart';
import '../../domain/services/master_plan_engine.dart';
import '../pages/master_plan_results_page.dart';

class MasterPlanSetupPage extends StatefulWidget {
  const MasterPlanSetupPage({super.key});

  @override
  State<MasterPlanSetupPage> createState() => _MasterPlanSetupPageState();
}

class _MasterPlanSetupPageState extends State<MasterPlanSetupPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _landAreaController;
  late final TextEditingController _landscapeValidationController;
  late final TextEditingController _urbanValidationController;
  late final TextEditingController _roadsValidationController;
  late final TextEditingController _infrastructureValidationController;
  late final TextEditingController _profitMarginController;
  late final TextEditingController _otherExpensesController;

  MasterPlanProject _project = const MasterPlanProject();

  @override
  void initState() {
    super.initState();
    _landAreaController = TextEditingController();
    _landscapeValidationController = TextEditingController(text: '0.5');
    _urbanValidationController = TextEditingController(text: '0.5');
    _roadsValidationController = TextEditingController(text: '0.5');
    _infrastructureValidationController = TextEditingController(text: '0.5');
    _profitMarginController = TextEditingController(text: '30');
    _otherExpensesController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _landAreaController.dispose();
    _landscapeValidationController.dispose();
    _urbanValidationController.dispose();
    _roadsValidationController.dispose();
    _infrastructureValidationController.dispose();
    _profitMarginController.dispose();
    _otherExpensesController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    final project = _project.copyWith(
      landArea: double.tryParse(_landAreaController.text.trim()) ?? 0,
      landscapeValidationFactor:
          double.tryParse(_landscapeValidationController.text.trim()) ?? 0.5,
      urbanValidationFactor:
          double.tryParse(_urbanValidationController.text.trim()) ?? 0.5,
      roadsValidationFactor:
          double.tryParse(_roadsValidationController.text.trim()) ?? 0.5,
      infrastructureValidationFactor:
          double.tryParse(_infrastructureValidationController.text.trim()) ?? 0.5,
      profitMargin: double.tryParse(_profitMarginController.text.trim()) ?? 30,
      otherExpenses: double.tryParse(_otherExpensesController.text.trim()) ?? 0,
    );

    setState(() {
      _project = project;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MasterPlanResultsPage(project: project),
      ),
    );
  }

  double _currentLandArea() {
    return double.tryParse(_landAreaController.text.trim()) ?? _project.landArea;
  }

  double _currentRate() {
    return MasterPlanEngine.calculateRate(
      category: _project.category,
      landArea: _currentLandArea(),
    );
  }

  double _currentPlannedHours() {
    return MasterPlanEngine.calculatePlannedHours(
      category: _project.category,
      landArea: _currentLandArea(),
    );
  }

  double _currentTotalCost() {
    return MasterPlanEngine.calculateTotalCost(
      category: _project.category,
      landArea: _currentLandArea(),
      otherExpenses:
          double.tryParse(_otherExpensesController.text.trim()) ?? _project.otherExpenses,
    );
  }

  double _currentFinalPrice() {
    return MasterPlanEngine.calculateFinalPrice(
      category: _project.category,
      landArea: _currentLandArea(),
      otherExpenses:
          double.tryParse(_otherExpensesController.text.trim()) ?? _project.otherExpenses,
      profitMargin:
          double.tryParse(_profitMarginController.text.trim()) ?? _project.profitMargin,
    );
  }

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
    return '${value.toStringAsFixed(2)} ${_currencyLabel(_project.currency)}';
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
    );
  }

  String? _requiredNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Enter a valid number';
    }

    if (parsed < 0) {
      return '$fieldName cannot be negative';
    }

    return null;
  }

  String? _validationFactorValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Enter a valid number';
    }

    if (parsed < 0 || parsed > 1) {
      return '$fieldName must be between 0 and 1';
    }

    return null;
  }

  Widget _sectionTitle(String title) {
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

  Widget _buildMetricCard({
    required ThemeData theme,
    required String subtitle,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
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
        title: const Text('Master Plan Setup'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Enter the main master plan inputs',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This is the first full master plan module.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Project Basics'),
              DropdownButtonFormField<MasterPlanCategory>(
                initialValue: _project.category,
                decoration: _decoration('Category'),
                items: MasterPlanCategory.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_categoryLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(category: value);
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MasterPlanCurrency>(
                initialValue: _project.currency,
                decoration: _decoration('Currency'),
                items: MasterPlanCurrency.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_currencyLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(currency: value);
                  });
                },
              ),
              const SizedBox(height: 24),
              _sectionTitle('Land Area'),
              TextFormField(
                controller: _landAreaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Land Area',
                  hint: 'Enter land area in m²',
                ),
                validator: (value) => _requiredNumber(value, 'Land Area'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Core Numbers'),
              _buildMetricCard(
                theme: theme,
                subtitle: 'Calculated Master Plan Rate',
                value: _currentRate().toStringAsFixed(2),
              ),
              const SizedBox(height: 16),
              _buildMetricCard(
                theme: theme,
                subtitle: 'Calculated Planned Hours',
                value: _currentPlannedHours().toStringAsFixed(2),
              ),
              const SizedBox(height: 16),
              _buildMetricCard(
                theme: theme,
                subtitle: 'Calculated Total Cost',
                value: _formatCurrency(_currentTotalCost()),
              ),
              const SizedBox(height: 16),
              _buildMetricCard(
                theme: theme,
                subtitle: 'Calculated Final Price',
                value: _formatCurrency(_currentFinalPrice()),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Validation Factors'),
              TextFormField(
                controller: _landscapeValidationController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Landscape Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) =>
                    _validationFactorValidator(value, 'Landscape Validation Factor'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urbanValidationController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Urban Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) =>
                    _validationFactorValidator(value, 'Urban Validation Factor'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roadsValidationController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Roads Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) =>
                    _validationFactorValidator(value, 'Roads Validation Factor'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _infrastructureValidationController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Infrastructure Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) => _validationFactorValidator(
                  value,
                  'Infrastructure Validation Factor',
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Pricing'),
              TextFormField(
                controller: _profitMarginController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Profit Margin %',
                  hint: 'Default 30',
                ),
                validator: (value) => _requiredNumber(value, 'Profit Margin'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _otherExpensesController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Other Expenses',
                  hint: 'Default 0',
                ),
                validator: (value) => _requiredNumber(value, 'Other Expenses'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _saveAndContinue,
                child: const Text('Save and Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
