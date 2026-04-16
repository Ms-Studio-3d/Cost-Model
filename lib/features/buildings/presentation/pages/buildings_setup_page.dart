import 'package:flutter/material.dart';
import 'package:cost_model/features/buildings/domain/models/buildings_project_input.dart';
import 'package:cost_model/features/buildings/presentation/pages/buildings_result_page.dart';
import 'package:cost_model/shared/widgets/app_text_field.dart';

class BuildingsSetupPage extends StatefulWidget {
  const BuildingsSetupPage({super.key});

  @override
  State<BuildingsSetupPage> createState() => _BuildingsSetupPageState();
}

class _BuildingsSetupPageState extends State<BuildingsSetupPage> {
  final _formKey = GlobalKey<FormState>();

  final _projectNameController = TextEditingController();
  final _buaController = TextEditingController();
  final _idBuaController = TextEditingController();
  final _profitMarginController = TextEditingController(text: '30');
  final _otherExpensesController = TextEditingController(text: '0');

  String _selectedCategory = 'C';
  String _selectedProjectType = 'Mixed Use';
  String _selectedProjectSystem = 'BIM';
  String _selectedCurrency = 'EGP';

  @override
  void dispose() {
    _projectNameController.dispose();
    _buaController.dispose();
    _idBuaController.dispose();
    _profitMarginController.dispose();
    _otherExpensesController.dispose();
    super.dispose();
  }

  double _parseNumber(String value) {
    return double.tryParse(value.trim()) ?? 0;
  }

  void _calculateAndContinue() {
    final project = BuildingsProjectInput(
      projectName: _projectNameController.text.trim().isEmpty
          ? 'Untitled Project'
          : _projectNameController.text.trim(),
      category: _selectedCategory,
      projectType: _selectedProjectType,
      projectSystem: _selectedProjectSystem,
      builtUpArea: _parseNumber(_buaController.text),
      idBuiltUpArea: _parseNumber(_idBuaController.text),
      profitMargin: _parseNumber(_profitMarginController.text),
      otherExpenses: _parseNumber(_otherExpensesController.text),
      currency: _selectedCurrency,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BuildingsResultPage(project: project),
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
                'Project Information',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the main building pricing inputs.',
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
                decoration: const InputDecoration(
                  labelText: 'Project Category',
                ),
                items: const [
                  DropdownMenuItem(value: 'A', child: Text('A')),
                  DropdownMenuItem(value: 'B', child: Text('B')),
                  DropdownMenuItem(value: 'C', child: Text('C')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? 'C';
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedProjectType,
                decoration: const InputDecoration(
                  labelText: 'Project Type',
                ),
                items: const [
                  DropdownMenuItem(value: 'All Project Type', child: Text('All Project Type')),
                  DropdownMenuItem(value: 'Administrative', child: Text('Administrative')),
                  DropdownMenuItem(value: 'Factory', child: Text('Factory')),
                  DropdownMenuItem(value: 'Mixed Use', child: Text('Mixed Use')),
                  DropdownMenuItem(value: 'Residential', child: Text('Residential')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedProjectType = value ?? 'Mixed Use';
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedProjectSystem,
                decoration: const InputDecoration(
                  labelText: 'Project System',
                ),
                items: const [
                  DropdownMenuItem(value: 'CAD', child: Text('CAD')),
                  DropdownMenuItem(value: 'BIM', child: Text('BIM')),
                  DropdownMenuItem(value: 'BOTH', child: Text('BOTH')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedProjectSystem = value ?? 'BIM';
                  });
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _buaController,
                label: 'Built Up Area',
                hint: 'Enter built up area',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _idBuaController,
                label: 'ID Built Up Area',
                hint: 'Enter interior design built up area',
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
                decoration: const InputDecoration(
                  labelText: 'Currency',
                ),
                items: const [
                  DropdownMenuItem(value: 'EGP', child: Text('EGP')),
                  DropdownMenuItem(value: 'SAR', child: Text('SAR')),
                  DropdownMenuItem(value: 'AED', child: Text('AED')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value ?? 'EGP';
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _calculateAndContinue,
                  child: const Text('Calculate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
