import 'package:flutter/material.dart';

import '../../domain/models/buildings_project.dart';

class BuildingsSetupPage extends StatefulWidget {
  const BuildingsSetupPage({super.key});

  @override
  State<BuildingsSetupPage> createState() => _BuildingsSetupPageState();
}

class _BuildingsSetupPageState extends State<BuildingsSetupPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _buaController;
  late final TextEditingController _idBuaController;
  late final TextEditingController _profitMarginController;
  late final TextEditingController _otherExpensesController;

  BuildingsProject _project = const BuildingsProject();

  @override
  void initState() {
    super.initState();
    _buaController = TextEditingController();
    _idBuaController = TextEditingController();
    _profitMarginController = TextEditingController(text: '30');
    _otherExpensesController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _buaController.dispose();
    _idBuaController.dispose();
    _profitMarginController.dispose();
    _otherExpensesController.dispose();
    super.dispose();
  }

  void _saveDraft() {
    if (!_formKey.currentState!.validate()) return;

    final project = _project.copyWith(
      builtUpArea: double.tryParse(_buaController.text.trim()) ?? 0,
      idBuiltUpArea: double.tryParse(_idBuaController.text.trim()) ?? 0,
      profitMargin: double.tryParse(_profitMarginController.text.trim()) ?? 0,
      otherExpenses:
          double.tryParse(_otherExpensesController.text.trim()) ?? 0,
    );

    setState(() {
      _project = project;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buildings project data saved locally.'),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buildings Setup'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Enter the main project inputs',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This is the first clean version of the buildings input form.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Project Basics'),
              DropdownButtonFormField<ProjectCategory>(
                initialValue: _project.projectCategory,
                decoration: _decoration('Project Category'),
                items: ProjectCategory.values
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
                    _project = _project.copyWith(projectCategory: value);
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<BuildingProjectType>(
                initialValue: _project.projectType,
                decoration: _decoration('Project Type'),
                items: BuildingProjectType.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_projectTypeLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(projectType: value);
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ProjectSystem>(
                initialValue: _project.projectSystem,
                decoration: _decoration('Project System'),
                items: ProjectSystem.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_projectSystemLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _project = _project.copyWith(projectSystem: value);
                  });
                },
              ),
              const SizedBox(height: 24),
              _sectionTitle('Areas'),
              TextFormField(
                controller: _buaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'Built Up Area',
                  hint: 'Enter total built up area',
                ),
                validator: (value) => _requiredNumber(value, 'Built Up Area'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idBuaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'ID Built Up Area',
                  hint: 'Enter interior design built up area',
                ),
                validator: (value) =>
                    _requiredNumber(value, 'ID Built Up Area'),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Pricing'),
              TextFormField(
                controller: _profitMarginController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'Profit Margin %',
                  hint: 'Default 30',
                ),
                validator: (value) => _requiredNumber(value, 'Profit Margin'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _otherExpensesController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'Other Expenses',
                  hint: 'Default 0',
                ),
                validator: (value) => _requiredNumber(value, 'Other Expenses'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Currency>(
                initialValue: _project.currency,
                decoration: _decoration('Currency'),
                items: Currency.values
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
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _saveDraft,
                child: const Text('Save and Continue'),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DefaultTextStyle(
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF374151),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Draft',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Category: ${_categoryLabel(_project.projectCategory)}',
                        ),
                        Text(
                          'Type: ${_projectTypeLabel(_project.projectType)}',
                        ),
                        Text(
                          'System: ${_projectSystemLabel(_project.projectSystem)}',
                        ),
                        Text('BUA: ${_project.builtUpArea}'),
                        Text('ID BUA: ${_project.idBuiltUpArea}'),
                        Text('Profit Margin: ${_project.profitMargin}%'),
                        Text('Other Expenses: ${_project.otherExpenses}'),
                        Text(
                          'Currency: ${_currencyLabel(_project.currency)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
