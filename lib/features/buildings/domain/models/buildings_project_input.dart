class BuildingsProjectInput {
  const BuildingsProjectInput({
    required this.projectName,
    required this.category,
    required this.projectType,
    required this.projectSystem,
    required this.builtUpArea,
    required this.idBuiltUpArea,
    required this.profitMargin,
    required this.otherExpenses,
    required this.currency,
  });

  final String projectName;
  final String category;
  final String projectType;
  final String projectSystem;
  final double builtUpArea;
  final double idBuiltUpArea;
  final double profitMargin;
  final double otherExpenses;
  final String currency;

  double get assumedRatePerSqm {
    switch (category) {
      case 'A':
        return 1.10;
      case 'B':
        return 0.82;
      case 'C':
      default:
        return 0.58;
    }
  }

  double get plannedHours => builtUpArea * assumedRatePerSqm;

  double get estimatedCost => plannedHours * 325;

  double get estimatedPrice =>
      estimatedCost + (estimatedCost * (profitMargin / 100)) + otherExpenses;
}
