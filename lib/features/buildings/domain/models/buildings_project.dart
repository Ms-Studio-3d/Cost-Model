enum ProjectCategory { a, b, c }

enum BuildingProjectType {
  allProjectTypes,
  administrative,
  factory,
  mixedUse,
  residential,
}

enum ProjectSystem { cad, bim, both }

enum Currency { egp, sar, aed, usd }

enum ScopeMode { full, validation, off }

enum BuildingDiscipline {
  architecture,
  structure,
  electrical,
  plumbing,
  hvac,
  qs,
  id,
}

enum BuildingPhase {
  concept,
  schematic,
  permits,
  detailedDesign,
  tenderIfc,
}

class BuildingsProject {
  const BuildingsProject({
    this.projectCategory = ProjectCategory.c,
    this.projectType = BuildingProjectType.mixedUse,
    this.projectSystem = ProjectSystem.bim,
    this.builtUpArea = 0,
    this.idBuiltUpArea = 0,
    this.profitMargin = 30,
    this.otherExpenses = 0,
    this.currency = Currency.egp,
    this.scopeMatrix = _defaultScopeMatrix,
  });

  final ProjectCategory projectCategory;
  final BuildingProjectType projectType;
  final ProjectSystem projectSystem;
  final double builtUpArea;
  final double idBuiltUpArea;
  final double profitMargin;
  final double otherExpenses;
  final Currency currency;
  final Map<BuildingDiscipline, Map<BuildingPhase, ScopeMode>> scopeMatrix;

  static const Map<BuildingDiscipline, Map<BuildingPhase, ScopeMode>>
      _defaultScopeMatrix = {
    BuildingDiscipline.architecture: {
      BuildingPhase.concept: ScopeMode.full,
      BuildingPhase.schematic: ScopeMode.full,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
    BuildingDiscipline.structure: {
      BuildingPhase.concept: ScopeMode.full,
      BuildingPhase.schematic: ScopeMode.full,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
    BuildingDiscipline.electrical: {
      BuildingPhase.concept: ScopeMode.full,
      BuildingPhase.schematic: ScopeMode.full,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
    BuildingDiscipline.plumbing: {
      BuildingPhase.concept: ScopeMode.full,
      BuildingPhase.schematic: ScopeMode.full,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
    BuildingDiscipline.hvac: {
      BuildingPhase.concept: ScopeMode.full,
      BuildingPhase.schematic: ScopeMode.full,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
    BuildingDiscipline.qs: {
      BuildingPhase.concept: ScopeMode.off,
      BuildingPhase.schematic: ScopeMode.off,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
    BuildingDiscipline.id: {
      BuildingPhase.concept: ScopeMode.full,
      BuildingPhase.schematic: ScopeMode.full,
      BuildingPhase.permits: ScopeMode.off,
      BuildingPhase.detailedDesign: ScopeMode.full,
      BuildingPhase.tenderIfc: ScopeMode.full,
    },
  };

  BuildingsProject copyWith({
    ProjectCategory? projectCategory,
    BuildingProjectType? projectType,
    ProjectSystem? projectSystem,
    double? builtUpArea,
    double? idBuiltUpArea,
    double? profitMargin,
    double? otherExpenses,
    Currency? currency,
    Map<BuildingDiscipline, Map<BuildingPhase, ScopeMode>>? scopeMatrix,
  }) {
    return BuildingsProject(
      projectCategory: projectCategory ?? this.projectCategory,
      projectType: projectType ?? this.projectType,
      projectSystem: projectSystem ?? this.projectSystem,
      builtUpArea: builtUpArea ?? this.builtUpArea,
      idBuiltUpArea: idBuiltUpArea ?? this.idBuiltUpArea,
      profitMargin: profitMargin ?? this.profitMargin,
      otherExpenses: otherExpenses ?? this.otherExpenses,
      currency: currency ?? this.currency,
      scopeMatrix: scopeMatrix ?? this.scopeMatrix,
    );
  }
}
