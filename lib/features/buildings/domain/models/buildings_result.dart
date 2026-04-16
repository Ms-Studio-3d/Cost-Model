class BuildingsResult {
  const BuildingsResult({
    required this.ratePerSqm,
    required this.totalPlannedHours,
    required this.productionHours,
    required this.supportiveHours,
    required this.architectureHours,
    required this.structureHours,
    required this.electricalHours,
    required this.plumbingHours,
    required this.hvacHours,
    required this.qsHours,
    required this.idHours,
    required this.totalCost,
    required this.totalPrice,
  });

  final double ratePerSqm;
  final double totalPlannedHours;
  final double productionHours;
  final double supportiveHours;
  final double architectureHours;
  final double structureHours;
  final double electricalHours;
  final double plumbingHours;
  final double hvacHours;
  final double qsHours;
  final double idHours;
  final double totalCost;
  final double totalPrice;
}
