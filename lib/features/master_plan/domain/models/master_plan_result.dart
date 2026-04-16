class MasterPlanResult {
  const MasterPlanResult({
    required this.ratePerFeddan,
    required this.landAreaFeddan,
    required this.totalHours,
    required this.landscapeHours,
    required this.urbanHours,
    required this.roadsHours,
    required this.infraWetHours,
    required this.infraDryHours,
    required this.totalCost,
    required this.totalPrice,
  });

  final double ratePerFeddan;
  final double landAreaFeddan;
  final double totalHours;
  final double landscapeHours;
  final double urbanHours;
  final double roadsHours;
  final double infraWetHours;
  final double infraDryHours;
  final double totalCost;
  final double totalPrice;
}
