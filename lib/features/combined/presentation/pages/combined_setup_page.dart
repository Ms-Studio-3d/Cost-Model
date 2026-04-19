import 'package:flutter/material.dart';

import '../../../buildings/domain/models/buildings_project.dart' as b_models;
import '../../../buildings/domain/services/building_rate_engine.dart';
import '../../../master_plan/domain/models/master_plan_project.dart' as mp_models;
import '../../../master_plan/domain/services/master_plan_engine.dart';
import '../../domain/models/combined_project.dart';
import 'combined_results_page.dart';

class CombinedSetupPage extends StatefulWidget {
  const CombinedSetupPage({super.key});

  @override
  State<CombinedSetupPage> createState() => _CombinedSetupPageState();
}

class _CombinedSetupPageState extends State<CombinedSetupPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _buildingsBuaController;
  late final TextEditingController _buildingsIdBuaController;
  late final TextEditingController _buildingsProfitMarginController;
  late final TextEditingController _buildingsOtherExpensesController;

  late final TextEditingController _masterPlanLandAreaController;
  late final TextEditingController _masterPlanProfitMarginController;
  late final TextEditingController _masterPlanOtherExpensesController;

  CombinedProject _project = const CombinedProject(
    buildingsProject: b_models.BuildingsProject(),
    masterPlanProject: mp_models.MasterPlanProject(),
  );

  @override
  void initState() {
    super.initState();
    _buildingsBuaController = TextEditingController();
    _buildingsIdBuaController = TextEditingController();
    _buildingsProfitMarginController = TextEditingController(text: '30');
    _buildingsOtherExpensesController = TextEditingController(text: '0');

    _masterPlanLandAreaController = TextEditingController();
    _masterPlanProfitMarginController = TextEditingController(text: '30');
    _masterPlanOtherExpensesController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _buildingsBuaController.dispose();
    _buildingsIdBuaController.dispose();
    _buildingsProfitMarginController.dispose();
    _buildingsOtherExpensesController.dispose();

    _masterPlanLandAreaController.dispose();
    _masterPlanProfitMarginController.dispose();
    _masterPlanOtherExpensesController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    final updatedBuildings = _project.buildingsProject.copyWith(
      builtUpArea: double.tryParse(_buildingsBuaController.text.trim()) ?? 0,
      idBuiltUpArea: double.tryParse(_buildingsIdBuaController.text.trim()) ?? 0,
      profitMargin:
          double.tryParse(_buildingsProfitMarginController.text.trim()) ?? 30,
      otherExpenses:
          double.tryParse(_buildingsOtherExpensesController.text.trim()) ?? 0,
    );

    final updatedMasterPlan = _project.masterPlanProject.copyWith(
      landArea: double.tryParse(_masterPlanLandAreaController.text.trim()) ?? 0,
      profitMargin:
          double.tryParse(_masterPlanProfitMarginController.text.trim()) ?? 30,
      otherExpenses:
          double.tryParse(_masterPlanOtherExpensesController.text.trim()) ?? 0,
    );

    final updatedProject = _project.copyWith(
      buildingsProject: updatedBuildings,
      masterPlanProject: updatedMasterPlan,
    );

    setState(() {
      _project = updatedProject;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CombinedResultsPage(project: updatedProject),
      ),
    );
  }

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
    return '${value.toStringAsFixed(2)} ${_currencyLabel(_project.buildingsProject.currency)}';
  }

  double _currentBuildingsBua() {
    return double.tryParse(_buildingsBuaController.text.trim()) ??
        _project.buildingsProject.builtUpArea;
  }

  double _currentBuildingsIdBua() {
    return double.tryParse(_buildingsIdBuaController.text.trim()) ??
        _project.buildingsProject.idBuiltUpArea;
  }

  double _currentBuildingsProfitMargin() {
    return double.tryParse(_buildingsProfitMarginController.text.trim()) ??
        _project.buildingsProject.profitMargin;
  }

  double _currentBuildingsOtherExpenses() {
    return double.tryParse(_buildingsOtherExpensesController.text.trim()) ??
        _project.buildingsProject.otherExpenses;
  }

  double _currentMasterPlanLandArea() {
    return double.tryParse(_masterPlanLandAreaController.text.trim()) ??
        _project.masterPlanProject.landArea;
  }

  double _currentMasterPlanProfitMargin() {
    return double.tryParse(_masterPlanProfitMarginController.text.trim()) ??
        _project.masterPlanProject.profitMargin;
  }

  double _currentMasterPlanOtherExpenses() {
    return double.tryParse(_masterPlanOtherExpensesController.text.trim()) ??
        _project.masterPlanProject.otherExpenses;
  }

  double _currentBuildingsPrice() {
    return BuildingRateEngine.calculateFinalPrice(
      category: _project.buildingsProject.projectCategory,
      builtUpArea: _currentBuildingsBua(),
      idBuiltUpArea: _currentBuildingsIdBua(),
      projectSystem: _project.buildingsProject.projectSystem,
      otherExpenses: _currentBuildingsOtherExpenses(),
      profitMargin: _currentBuildingsProfitMargin(),
    );
  }

  double _currentMasterPlanPrice() {
    return MasterPlanEngine.calculateFinalPrice(
      category: _project.masterPlanProject.category,
      landArea: _currentMasterPlanLandArea(),
      otherExpenses: _currentMasterPlanOtherExpenses(),
      profitMargin: _currentMasterPlanProfitMargin(),
    );
  }

  double _currentCombinedPrice() {
    return _currentBuildingsPrice() + _currentMasterPlanPrice();
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

  Widget _metricCard({
    required ThemeData theme,
    required String title,
    required String value,
    String? subtitle,
  }) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Setup'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Enter Buildings + Master Plan inputs',
                style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'This module combines both workflows into one project.',
                style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF6B7280),
                    ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Buildings Basics'),
              DropdownButtonFormField<b_models.ProjectCategory>(
                initialValue: _project.buildingsProject.projectCategory,
                decoration: _decoration('Buildings Category'),
                items: b_models.ProjectCategory.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_buildingCategoryLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(
                      buildingsProject: _project.buildingsProject.copyWith(
                        projectCategory: value,
                      ),
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<b_models.BuildingProjectType>(
                initialValue: _project.buildingsProject.projectType,
                decoration: _decoration('Buildings Project Type'),
                items: b_models.BuildingProjectType.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_buildingProjectTypeLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(
                      buildingsProject: _project.buildingsProject.copyWith(
                        projectType: value,
                      ),
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<b_models.ProjectSystem>(
                initialValue: _project.buildingsProject.projectSystem,
                decoration: _decoration('Buildings Project System'),
                items: b_models.ProjectSystem.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_buildingSystemLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(
                      buildingsProject: _project.buildingsProject.copyWith(
                        projectSystem: value,
                      ),
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _buildingsBuaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Buildings Built Up Area',
                  hint: 'Enter buildings BUA',
                ),
                validator: (value) => _requiredNumber(value, 'Buildings BUA'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _buildingsIdBuaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Buildings ID Built Up Area',
                  hint: 'Enter ID BUA',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'Buildings ID Built Up Area'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _buildingsProfitMarginController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Buildings Profit Margin %',
                  hint: 'Default 30',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'Buildings Profit Margin'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _buildingsOtherExpensesController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Buildings Other Expenses',
                  hint: 'Default 0',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'Buildings Other Expenses'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Master Plan Basics'),
              DropdownButtonFormField<mp_models.MasterPlanCategory>(
                initialValue: _project.masterPlanProject.category,
                decoration: _decoration('Master Plan Category'),
                items: mp_models.MasterPlanCategory.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_masterPlanCategoryLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(
                      masterPlanProject: _project.masterPlanProject.copyWith(
                        category: value,
                      ),
                    );
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _masterPlanLandAreaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Master Plan Land Area',
                  hint: 'Enter land area in m²',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'Master Plan Land Area'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _masterPlanProfitMarginController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Master Plan Profit Margin %',
                  hint: 'Default 30',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'Master Plan Profit Margin'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _masterPlanOtherExpensesController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: _decoration(
                  'Master Plan Other Expenses',
                  hint: 'Default 0',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'Master Plan Other Expenses'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Quick Combined Snapshot'),
              _metricCard(
                theme: theme,
                title: 'Buildings Price',
                value: _formatCurrency(_currentBuildingsPrice()),
              ),
              const SizedBox(height: 16),
              _metricCard(
                theme: theme,
                title: 'Master Plan Price',
                value: _formatCurrency(_currentMasterPlanPrice()),
              ),
              const SizedBox(height: 16),
              _metricCard(
                theme: theme,
                title: 'Combined Price',
                value: _formatCurrency(_currentCombinedPrice()),
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
