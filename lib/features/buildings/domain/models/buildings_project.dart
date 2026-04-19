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
  });

  final ProjectCategory projectCategory;
  final BuildingProjectType projectType;
  final ProjectSystem projectSystem;
  final double builtUpArea;
  final double idBuiltUpArea;
  final double profitMargin;
  final double otherExpenses;
  final Currency currency;

  BuildingsProject copyWith({
    ProjectCategory? projectCategory,
    BuildingProjectType? projectType,
    ProjectSystem? projectSystem,
    double? builtUpArea,
    double? idBuiltUpArea,
    double? profitMargin,
    double? otherExpenses,
    Currency? currency,
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
    );
  }
}
