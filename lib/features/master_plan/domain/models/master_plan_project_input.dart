class MasterPlanProjectInput {
  const MasterPlanProjectInput({
    required this.projectName,
    required this.category,
    required this.landArea,
    required this.profitMargin,
    required this.otherExpenses,
    required this.currency,
  });

  final String projectName;
  final String category;
  final double landArea;
  final double profitMargin;
  final double otherExpenses;
  final String currency;
}
