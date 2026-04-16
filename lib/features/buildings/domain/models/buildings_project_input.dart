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
}
