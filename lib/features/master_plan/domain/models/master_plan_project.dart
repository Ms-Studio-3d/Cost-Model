enum MasterPlanCategory { a, b, c }

enum MasterPlanCurrency { egp, sar, aed, usd }

enum MasterPlanScopeMode { full, validation, off }

enum MasterPlanDiscipline {
  landscape,
  urban,
  roads,
  infrastructureWet,
  infrastructureDry,
}

enum MasterPlanPhase {
  concept,
  schematic,
  permits,
  detailedDesign,
  tenderIfc,
}

class MasterPlanProject {
  const MasterPlanProject({
    this.category = MasterPlanCategory.b,
    this.landArea = 0,
    this.landscapeValidationFactor = 0.5,
    this.urbanValidationFactor = 0.5,
    this.roadsValidationFactor = 0.5,
    this.infrastructureValidationFactor = 0.5,
    this.profitMargin = 30,
    this.otherExpenses = 0,
    this.currency = MasterPlanCurrency.egp,
    this.scopeMatrix = _defaultScopeMatrix,
  });

  final MasterPlanCategory category;
  final double landArea;
  final double landscapeValidationFactor;
  final double urbanValidationFactor;
  final double roadsValidationFactor;
  final double infrastructureValidationFactor;
  final double profitMargin;
  final double otherExpenses;
  final MasterPlanCurrency currency;
  final Map<MasterPlanDiscipline, Map<MasterPlanPhase, MasterPlanScopeMode>>
      scopeMatrix;

  static const Map<MasterPlanDiscipline,
      Map<MasterPlanPhase, MasterPlanScopeMode>> _defaultScopeMatrix = {
    MasterPlanDiscipline.landscape: {
      MasterPlanPhase.concept: MasterPlanScopeMode.full,
      MasterPlanPhase.schematic: MasterPlanScopeMode.full,
      MasterPlanPhase.permits: MasterPlanScopeMode.off,
      MasterPlanPhase.detailedDesign: MasterPlanScopeMode.full,
      MasterPlanPhase.tenderIfc: MasterPlanScopeMode.full,
    },
    MasterPlanDiscipline.urban: {
      MasterPlanPhase.concept: MasterPlanScopeMode.full,
      MasterPlanPhase.schematic: MasterPlanScopeMode.full,
      MasterPlanPhase.permits: MasterPlanScopeMode.off,
      MasterPlanPhase.detailedDesign: MasterPlanScopeMode.full,
      MasterPlanPhase.tenderIfc: MasterPlanScopeMode.full,
    },
    MasterPlanDiscipline.roads: {
      MasterPlanPhase.concept: MasterPlanScopeMode.full,
      MasterPlanPhase.schematic: MasterPlanScopeMode.full,
      MasterPlanPhase.permits: MasterPlanScopeMode.off,
      MasterPlanPhase.detailedDesign: MasterPlanScopeMode.full,
      MasterPlanPhase.tenderIfc: MasterPlanScopeMode.full,
    },
    MasterPlanDiscipline.infrastructureWet: {
      MasterPlanPhase.concept: MasterPlanScopeMode.full,
      MasterPlanPhase.schematic: MasterPlanScopeMode.full,
      MasterPlanPhase.permits: MasterPlanScopeMode.off,
      MasterPlanPhase.detailedDesign: MasterPlanScopeMode.full,
      MasterPlanPhase.tenderIfc: MasterPlanScopeMode.full,
    },
    MasterPlanDiscipline.infrastructureDry: {
      MasterPlanPhase.concept: MasterPlanScopeMode.full,
      MasterPlanPhase.schematic: MasterPlanScopeMode.full,
      MasterPlanPhase.permits: MasterPlanScopeMode.off,
      MasterPlanPhase.detailedDesign: MasterPlanScopeMode.full,
      MasterPlanPhase.tenderIfc: MasterPlanScopeMode.full,
    },
  };

  MasterPlanProject copyWith({
    MasterPlanCategory? category,
    double? landArea,
    double? landscapeValidationFactor,
    double? urbanValidationFactor,
    double? roadsValidationFactor,
    double? infrastructureValidationFactor,
    double? profitMargin,
    double? otherExpenses,
    MasterPlanCurrency? currency,
    Map<MasterPlanDiscipline, Map<MasterPlanPhase, MasterPlanScopeMode>>?
        scopeMatrix,
  }) {
    return MasterPlanProject(
      category: category ?? this.category,
      landArea: landArea ?? this.landArea,
      landscapeValidationFactor:
          landscapeValidationFactor ?? this.landscapeValidationFactor,
      urbanValidationFactor:
          urbanValidationFactor ?? this.urbanValidationFactor,
      roadsValidationFactor:
          roadsValidationFactor ?? this.roadsValidationFactor,
      infrastructureValidationFactor:
          infrastructureValidationFactor ?? this.infrastructureValidationFactor,
      profitMargin: profitMargin ?? this.profitMargin,
      otherExpenses: otherExpenses ?? this.otherExpenses,
      currency: currency ?? this.currency,
      scopeMatrix: scopeMatrix ?? this.scopeMatrix,
    );
  }
}
