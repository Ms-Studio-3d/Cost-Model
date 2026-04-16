import 'package:flutter/material.dart';
import 'package:cost_model/features/buildings/domain/models/buildings_project_input.dart';
import 'package:cost_model/features/combined/presentation/pages/combined_result_page.dart';
import 'package:cost_model/features/master_plan/domain/models/master_plan_project_input.dart';
import 'package:cost_model/shared/widgets/app_text_field.dart';

class CombinedSetupPage extends StatefulWidget {
  const CombinedSetupPage({super.key});

  @override
  State<CombinedSetupPage> createState() => _CombinedSetupPageState();
}

class _CombinedSetupPageState extends State<CombinedSetupPage> {
  final _projectNameController = TextEditingController();
  final _buaController = TextEditingController();
  final _idBuaController = TextEditingController();
  final _landAreaController = TextEditingController();
  final _profitMarginController = TextEditingController(text: '30');
  final _otherExpensesController = TextEditingController(text: '0');

  String _buildingCategory = 'C';
  String _buildingType = 'Mixed Use';
  String _buildingSystem = 'BIM';
  String _masterPlanCategory = 'B';
  String _currency = 'EGP';

  @override
  void dispose() {
    _projectNameController.dispose();
    _buaController.dispose();
    _idBuaController.dispose();
    _landAreaController.dispose();
    _profitMarginController.dispose();
    _otherExpensesController.dispose();
    super.dispose();
  }

  double _parseNumber(String value) {
    return double.tryParse(value.trim()) ?? 0;
  }

  void _calculate() {
    final name = _projectNameController.text.trim().isEmpty
        ? 'Untitled Combined Project'
        : _projectNameController.text.trim();

    final buildingsInput = BuildingsProjectInput(
      projectName: name,
      category: _buildingCategory,
      projectType: _buildingType,
      projectSystem: _buildingSystem,
      builtUpArea: _parseNumber(_buaController.text),
      idBuiltUpArea: _parseNumber(_idBuaController.text),
      profitMargin: _parseNumber(_profitMarginController.text),
      otherExpenses: 0,
      currency: _currency,
    );

    final masterPlanInput = MasterPlanProjectInput(
      projectName: name,
      category: _masterPlanCategory,
      landArea: _parseNumber(_landAreaController.text),
      profitMargin: _parseNumber(_profitMarginController.text),
      otherExpenses: 0,
      currency: _currency,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CombinedResultPage(
          buildingsInput: buildingsInput,
          masterPlanInput: masterPlanInput,
          otherExpenses: _parseNumber(_otherExpensesController.text),
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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Combined Project',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter both buildings and master plan inputs.',
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
              initialValue: _buildingCategory,
              decoration: const InputDecoration(
                labelText: 'Buildings Category',
              ),
              items: const [
                DropdownMenuItem(value: 'A', child: Text('A')),
                DropdownMenuItem(value: 'B', child: Text('B')),
                DropdownMenuItem(value: 'C', child: Text('C')),
              ],
              onChanged: (value) {
                setState(() => _buildingCategory = value ?? 'C');
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _buildingType,
              decoration: const InputDecoration(labelText: 'Buildings Type'),
              items: const [
                DropdownMenuItem(
                  value: 'All Project Type',
                  child: Text('All Project Type'),
                ),
                DropdownMenuItem(
                  value: 'Administrative',
                  child: Text('Administrative'),
                ),
                DropdownMenuItem(value: 'Factory', child: Text('Factory')),
                DropdownMenuItem(value: 'Mixed Use', child: Text('Mixed Use')),
                DropdownMenuItem(
                  value: 'Residential',
                  child: Text('Residential'),
                ),
              ],
              onChanged: (value) {
                setState(() => _buildingType = value ?? 'Mixed Use');
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _buildingSystem,
              decoration: const InputDecoration(labelText: 'Buildings System'),
              items: const [
                DropdownMenuItem(value: 'CAD', child: Text('CAD')),
                DropdownMenuItem(value: 'BIM', child: Text('BIM')),
                DropdownMenuItem(value: 'BOTH', child: Text('BOTH')),
              ],
              onChanged: (value) {
                setState(() => _buildingSystem = value ?? 'BIM');
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _buaController,
              label: 'Built Up Area',
              hint: 'Enter BUA',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _idBuaController,
              label: 'ID Built Up Area',
              hint: 'Enter ID BUA',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _masterPlanCategory,
              decoration: const InputDecoration(
                labelText: 'Master Plan Category',
              ),
              items: const [
                DropdownMenuItem(value: 'A', child: Text('A')),
                DropdownMenuItem(value: 'B', child: Text('B')),
                DropdownMenuItem(value: 'C', child: Text('C')),
              ],
              onChanged: (value) {
                setState(() => _masterPlanCategory = value ?? 'B');
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
              initialValue: _currency,
              decoration: const InputDecoration(labelText: 'Currency'),
              items: const [
                DropdownMenuItem(value: 'EGP', child: Text('EGP')),
                DropdownMenuItem(value: 'SAR', child: Text('SAR')),
                DropdownMenuItem(value: 'AED', child: Text('AED')),
              ],
              onChanged: (value) {
                setState(() => _currency = value ?? 'EGP');
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate Combined'),
            ),
          ],
        ),
      ),
    );
  }
}
