import 'package:flutter/material.dart';

import '../../domain/models/buildings_project.dart';
import '../../domain/services/building_rate_engine.dart';
import '../widgets/scope_mode_chip.dart';

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

  late final TextEditingController _architectureValidationController;
  late final TextEditingController _structureValidationController;
  late final TextEditingController _idValidationController;
  late final TextEditingController _mepValidationController;

  BuildingsProject _project = const BuildingsProject();

  @override
  void initState() {
    super.initState();
    _buaController = TextEditingController();
    _idBuaController = TextEditingController();
    _profitMarginController = TextEditingController(text: '30');
    _otherExpensesController = TextEditingController(text: '0');

    _architectureValidationController = TextEditingController(text: '0.5');
    _structureValidationController = TextEditingController(text: '0.5');
    _idValidationController = TextEditingController(text: '0.5');
    _mepValidationController = TextEditingController(text: '0.5');
  }

  @override
  void dispose() {
    _buaController.dispose();
    _idBuaController.dispose();
    _profitMarginController.dispose();
    _otherExpensesController.dispose();

    _architectureValidationController.dispose();
    _structureValidationController.dispose();
    _idValidationController.dispose();
    _mepValidationController.dispose();

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
      architectureValidationFactor:
          double.tryParse(_architectureValidationController.text.trim()) ?? 0.5,
      structureValidationFactor:
          double.tryParse(_structureValidationController.text.trim()) ?? 0.5,
      idValidationFactor:
          double.tryParse(_idValidationController.text.trim()) ?? 0.5,
      mepValidationFactor:
          double.tryParse(_mepValidationController.text.trim()) ?? 0.5,
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

  void _updateScope(
    BuildingDiscipline discipline,
    BuildingPhase phase,
    ScopeMode mode,
  ) {
    final updatedScope = <BuildingDiscipline, Map<BuildingPhase, ScopeMode>>{};

    for (final entry in _project.scopeMatrix.entries) {
      updatedScope[entry.key] = Map<BuildingPhase, ScopeMode>.from(entry.value);
    }

    updatedScope[discipline]![phase] = mode;

    setState(() {
      _project = _project.copyWith(scopeMatrix: updatedScope);
    });
  }

  double _currentBuiltUpArea() {
    return double.tryParse(_buaController.text.trim()) ?? _project.builtUpArea;
  }

  double _currentIdBuiltUpArea() {
    return double.tryParse(_idBuaController.text.trim()) ??
        _project.idBuiltUpArea;
  }

  double _currentArchitectureValidation() {
    return double.tryParse(_architectureValidationController.text.trim()) ??
        _project.architectureValidationFactor;
  }

  double _currentStructureValidation() {
    return double.tryParse(_structureValidationController.text.trim()) ??
        _project.structureValidationFactor;
  }

  double _currentIdValidation() {
    return double.tryParse(_idValidationController.text.trim()) ??
        _project.idValidationFactor;
  }

  double _currentMepValidation() {
    return double.tryParse(_mepValidationController.text.trim()) ??
        _project.mepValidationFactor;
  }

  double _currentBuildingRate() {
    return BuildingRateEngine.calculate(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentPlannedHours() {
    return BuildingRateEngine.calculatePlannedHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentProductionHours() {
    return BuildingRateEngine.calculateProductionHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentSupportiveHours() {
    return BuildingRateEngine.calculateSupportiveHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentArchitectureHours() {
    return BuildingRateEngine.calculateArchitectureHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentStructureHours() {
    return BuildingRateEngine.calculateStructureHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentElectricalHours() {
    return BuildingRateEngine.calculateElectricalHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentPlumbingHours() {
    return BuildingRateEngine.calculatePlumbingHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentHvacHours() {
    return BuildingRateEngine.calculateHvacHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentQsHours() {
    return BuildingRateEngine.calculateQsHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
    );
  }

  double _currentIdHours() {
    return BuildingRateEngine.calculateIdHours(
      idBuiltUpArea: _currentIdBuiltUpArea(),
    );
  }

  double _currentProjectManagementHours() {
    return BuildingRateEngine.calculateProjectManagementHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      projectSystem: _project.projectSystem,
    );
  }

  double _currentQualityControlHours() {
    return BuildingRateEngine.calculateQualityControlHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      projectSystem: _project.projectSystem,
    );
  }

  double _currentBimCadHours() {
    return BuildingRateEngine.calculateBimCadHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      projectSystem: _project.projectSystem,
    );
  }

  double _currentDocumentControlHours() {
    return BuildingRateEngine.calculateDocumentControlHours(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      projectSystem: _project.projectSystem,
    );
  }

  Map<BuildingPhase, double> _architecturePhaseHours() {
    return BuildingRateEngine.distributeArchitectureByPhase(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.architecture] ?? {},
      validationFactor: _currentArchitectureValidation(),
    );
  }

  Map<BuildingPhase, double> _structurePhaseHours() {
    return BuildingRateEngine.distributeStructureByPhase(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.structure] ?? {},
      validationFactor: _currentStructureValidation(),
    );
  }

  Map<BuildingPhase, double> _electricalPhaseHours() {
    return BuildingRateEngine.distributeElectricalByPhase(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.electrical] ?? {},
      validationFactor: _currentMepValidation(),
    );
  }

  Map<BuildingPhase, double> _plumbingPhaseHours() {
    return BuildingRateEngine.distributePlumbingByPhase(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.plumbing] ?? {},
      validationFactor: _currentMepValidation(),
    );
  }

  Map<BuildingPhase, double> _hvacPhaseHours() {
    return BuildingRateEngine.distributeHvacByPhase(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.hvac] ?? {},
      validationFactor: _currentMepValidation(),
    );
  }

  Map<BuildingPhase, double> _qsPhaseHours() {
    return BuildingRateEngine.distributeQsByPhase(
      category: _project.projectCategory,
      builtUpArea: _currentBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.qs] ?? {},
    );
  }

  Map<BuildingPhase, double> _idPhaseHours() {
    return BuildingRateEngine.distributeIdByPhase(
      idBuiltUpArea: _currentIdBuiltUpArea(),
      scope: _project.scopeMatrix[BuildingDiscipline.id] ?? {},
      validationFactor: _currentIdValidation(),
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

  String _disciplineLabel(BuildingDiscipline value) {
    switch (value) {
      case BuildingDiscipline.architecture:
        return 'Architecture';
      case BuildingDiscipline.structure:
        return 'Structure';
      case BuildingDiscipline.electrical:
        return 'Electrical';
      case BuildingDiscipline.plumbing:
        return 'Plumbing';
      case BuildingDiscipline.hvac:
        return 'HVAC';
      case BuildingDiscipline.qs:
        return 'QS';
      case BuildingDiscipline.id:
        return 'ID';
    }
  }

  String _phaseLabel(BuildingPhase value) {
    switch (value) {
      case BuildingPhase.concept:
        return 'Concept';
      case BuildingPhase.schematic:
        return 'Schematic';
      case BuildingPhase.permits:
        return 'Permits';
      case BuildingPhase.detailedDesign:
        return 'Detailed Design';
      case BuildingPhase.tenderIfc:
        return 'Tender / IFC';
    }
  }

  String _bimCadLabel() {
    return _project.projectSystem == ProjectSystem.cad ? 'CAD' : 'BIM';
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

  Widget _buildProductionDisciplineCard({
    required ThemeData theme,
    required String title,
    required String subtitle,
    required String value,
  }) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
        trailing: Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseDistributionCard({
    required ThemeData theme,
    required String title,
    required Map<BuildingPhase, double> phaseHours,
  }) {
    final total = BuildingRateEngine.sumPhaseHours(phaseHours);

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
            const SizedBox(height: 12),
            ...BuildingPhase.values.map((phase) {
              final value = phaseHours[phase] ?? 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _phaseLabel(phase),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF374151),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      value.toStringAsFixed(2),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF111827),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Adjusted Total',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ),
                Text(
                  total.toStringAsFixed(2),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScopeCard(
    BuildingDiscipline discipline,
    Map<BuildingPhase, ScopeMode> phases,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _disciplineLabel(discipline),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 14),
            ...BuildingPhase.values.map((phase) {
              final selectedMode = phases[phase] ?? ScopeMode.off;

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _phaseLabel(phase),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ScopeMode.values.map((mode) {
                        return ScopeModeChip(
                          label: scopeModeLabel(mode),
                          selected: selectedMode == mode,
                          onTap: () => _updateScope(discipline, phase, mode),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _scopeSummary() {
    int fullCount = 0;
    int validationCount = 0;
    int offCount = 0;

    for (final discipline in _project.scopeMatrix.values) {
      for (final mode in discipline.values) {
        switch (mode) {
          case ScopeMode.full:
            fullCount++;
          case ScopeMode.validation:
            validationCount++;
          case ScopeMode.off:
            offCount++;
        }
      }
    }

    return 'Full: $fullCount • Validation: $validationCount • Off: $offCount';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRate = _currentBuildingRate();
    final currentPlannedHours = _currentPlannedHours();
    final currentProductionHours = _currentProductionHours();
    final currentSupportiveHours = _currentSupportiveHours();

    final architectureHours = _currentArchitectureHours();
    final structureHours = _currentStructureHours();
    final electricalHours = _currentElectricalHours();
    final plumbingHours = _currentPlumbingHours();
    final hvacHours = _currentHvacHours();
    final qsHours = _currentQsHours();
    final idHours = _currentIdHours();

    final pmHours = _currentProjectManagementHours();
    final qcHours = _currentQualityControlHours();
    final bimCadHours = _currentBimCadHours();
    final dcHours = _currentDocumentControlHours();

    final architecturePhaseHours = _architecturePhaseHours();
    final structurePhaseHours = _structurePhaseHours();
    final electricalPhaseHours = _electricalPhaseHours();
    final plumbingPhaseHours = _plumbingPhaseHours();
    final hvacPhaseHours = _hvacPhaseHours();
    final qsPhaseHours = _qsPhaseHours();
    final idPhaseHours = _idPhaseHours();

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
                'This screen now includes supportive departments based on the selected project system.',
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
                onChanged: (_) => setState(() {}),
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
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Building Rate'),
              _buildMetricCard(
                theme: theme,
                subtitle: 'Calculated from Category + Built Up Area',
                value: currentRate == 0
                    ? 'Enter a valid BUA to calculate rate.'
                    : currentRate.toStringAsFixed(3),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Planned Hours'),
              _buildMetricCard(
                theme: theme,
                subtitle: 'Calculated as Built Up Area × Building Rate',
                value: currentPlannedHours == 0
                    ? 'Enter a valid BUA to calculate planned hours.'
                    : currentPlannedHours.toStringAsFixed(2),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Hours Split'),
              _buildMetricCard(
                theme: theme,
                subtitle: '85% of total planned hours',
                value: currentProductionHours == 0
                    ? 'Enter a valid BUA to calculate production hours.'
                    : currentProductionHours.toStringAsFixed(2),
              ),
              const SizedBox(height: 16),
              _buildMetricCard(
                theme: theme,
                subtitle: '15% of total planned hours',
                value: currentSupportiveHours == 0
                    ? 'Enter a valid BUA to calculate supportive hours.'
                    : currentSupportiveHours.toStringAsFixed(2),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Production Breakdown'),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Architecture',
                subtitle: '29% of production hours',
                value: architectureHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Structure',
                subtitle: '22% of production hours',
                value: structureHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Electrical',
                subtitle: '23% of production hours',
                value: electricalHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Plumbing',
                subtitle: '12% of production hours',
                value: plumbingHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'HVAC',
                subtitle: '14% of production hours',
                value: hvacHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'QS',
                subtitle: '10% of Architecture + Structure hours',
                value: qsHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'ID',
                subtitle: 'Temporary placeholder based on ID BUA',
                value: idHours.toStringAsFixed(2),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Supportive Breakdown'),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Project Management',
                subtitle: 'Supportive department allocation',
                value: pmHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Quality Control',
                subtitle: 'Supportive department allocation',
                value: qcHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: _bimCadLabel(),
                subtitle:
                    'System-based allocation (${_projectSystemLabel(_project.projectSystem)})',
                value: bimCadHours.toStringAsFixed(2),
              ),
              _buildProductionDisciplineCard(
                theme: theme,
                title: 'Document Control',
                subtitle: 'Supportive department allocation',
                value: dcHours.toStringAsFixed(2),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Phase Distribution'),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'Architecture',
                phaseHours: architecturePhaseHours,
              ),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'Structure',
                phaseHours: structurePhaseHours,
              ),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'Electrical',
                phaseHours: electricalPhaseHours,
              ),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'Plumbing',
                phaseHours: plumbingPhaseHours,
              ),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'HVAC',
                phaseHours: hvacPhaseHours,
              ),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'QS',
                phaseHours: qsPhaseHours,
              ),
              _buildPhaseDistributionCard(
                theme: theme,
                title: 'ID',
                phaseHours: idPhaseHours,
              ),
              const SizedBox(height: 24),
              _sectionTitle('Validation Factors'),
              TextFormField(
                controller: _architectureValidationController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'Architecture Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) => _validationFactorValidator(
                  value,
                  'Architecture Validation Factor',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _structureValidationController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'Structure Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) => _validationFactorValidator(
                  value,
                  'Structure Validation Factor',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idValidationController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'ID Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) => _validationFactorValidator(
                  value,
                  'ID Validation Factor',
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mepValidationController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _decoration(
                  'MEP Validation Factor',
                  hint: 'Example: 0.5',
                ),
                validator: (value) => _validationFactorValidator(
                  value,
                  'MEP Validation Factor',
                ),
                onChanged: (_) => setState(() {}),
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
              const SizedBox(height: 24),
              _sectionTitle('Scope Matrix'),
              Text(
                'This replaces the Excel Y / V / N logic with Full / Validation / Off.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _scopeSummary(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 12),
              ..._project.scopeMatrix.entries.map(
                (entry) => _buildScopeCard(entry.key, entry.value),
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
                        Text(
                          'Building Rate: ${_currentBuildingRate().toStringAsFixed(3)}',
                        ),
                        Text(
                          'Planned Hours: ${_currentPlannedHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Production Hours: ${_currentProductionHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Supportive Hours: ${_currentSupportiveHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Architecture: ${_currentArchitectureHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Structure: ${_currentStructureHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Electrical: ${_currentElectricalHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Plumbing: ${_currentPlumbingHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'HVAC: ${_currentHvacHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'QS: ${_currentQsHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'ID: ${_currentIdHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'PM: ${_currentProjectManagementHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'QC: ${_currentQualityControlHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          '${_bimCadLabel()}: ${_currentBimCadHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Document Control: ${_currentDocumentControlHours().toStringAsFixed(2)}',
                        ),
                        Text(
                          'Architecture Validation: ${_currentArchitectureValidation()}',
                        ),
                        Text(
                          'Structure Validation: ${_currentStructureValidation()}',
                        ),
                        Text(
                          'ID Validation: ${_currentIdValidation()}',
                        ),
                        Text(
                          'MEP Validation: ${_currentMepValidation()}',
                        ),
                        Text('Profit Margin: ${_project.profitMargin}%'),
                        Text('Other Expenses: ${_project.otherExpenses}'),
                        Text(
                          'Currency: ${_currencyLabel(_project.currency)}',
                        ),
                        const SizedBox(height: 8),
                        Text('Scope Summary: ${_scopeSummary()}'),
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
