import '../models/master_plan_project.dart';

class MasterPlanCurvePoint {
  const MasterPlanCurvePoint({
    required this.feddan,
    required this.rate,
  });

  final double feddan;
  final double rate;
}

class MasterPlanEngine {
  const MasterPlanEngine._();

  static const double sqmPerFeddan = 4200;

  static const double landscapeShare = 0.25;
  static const double urbanShare = 0.30;
  static const double roadsShare = 0.10;
  static const double infrastructureWetShare = 0.15;
  static const double infrastructureDryShare = 0.20;

  static const double landscapeCostPerHour = 260;
  static const double urbanCostPerHour = 300;
  static const double roadsCostPerHour = 240;
  static const double infrastructureWetCostPerHour = 280;
  static const double infrastructureDryCostPerHour = 280;

  static const Map<MasterPlanPhase, double> phaseProfile = {
    MasterPlanPhase.concept: 0.20,
    MasterPlanPhase.schematic: 0.25,
    MasterPlanPhase.permits: 0.00,
    MasterPlanPhase.detailedDesign: 0.25,
    MasterPlanPhase.tenderIfc: 0.30,
  };

  static const List<MasterPlanCurvePoint> _categoryA = [
    MasterPlanCurvePoint(feddan: 10, rate: 180),
    MasterPlanCurvePoint(feddan: 30, rate: 140),
    MasterPlanCurvePoint(feddan: 60, rate: 120),
    MasterPlanCurvePoint(feddan: 100, rate: 105),
    MasterPlanCurvePoint(feddan: 200, rate: 90),
  ];

  static const List<MasterPlanCurvePoint> _categoryB = [
    MasterPlanCurvePoint(feddan: 10, rate: 150),
    MasterPlanCurvePoint(feddan: 30, rate: 120),
    MasterPlanCurvePoint(feddan: 60, rate: 100),
    MasterPlanCurvePoint(feddan: 100, rate: 88),
    MasterPlanCurvePoint(feddan: 200, rate: 76),
  ];

  static const List<MasterPlanCurvePoint> _categoryC = [
    MasterPlanCurvePoint(feddan: 10, rate: 130),
    MasterPlanCurvePoint(feddan: 30, rate: 105),
    MasterPlanCurvePoint(feddan: 60, rate: 88),
    MasterPlanCurvePoint(feddan: 100, rate: 78),
    MasterPlanCurvePoint(feddan: 200, rate: 68),
  ];

  static double landAreaToFeddan(double landArea) {
    if (landArea <= 0) return 0;
    return landArea / sqmPerFeddan;
  }

  static double calculateRate({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    final feddan = landAreaToFeddan(landArea);
    final points = switch (category) {
      MasterPlanCategory.a => _categoryA,
      MasterPlanCategory.b => _categoryB,
      MasterPlanCategory.c => _categoryC,
    };

    if (feddan <= 0) return 0;

    if (feddan <= points.first.feddan) {
      return points.first.rate;
    }

    if (feddan >= points.last.feddan) {
      return points.last.rate;
    }

    for (int i = 0; i < points.length - 1; i++) {
      final start = points[i];
      final end = points[i + 1];

      if (feddan >= start.feddan && feddan <= end.feddan) {
        final span = end.feddan - start.feddan;
        final progress = (feddan - start.feddan) / span;
        return start.rate + ((end.rate - start.rate) * progress);
      }
    }

    return points.last.rate;
  }

  static double calculatePlannedHours({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    final feddan = landAreaToFeddan(landArea);
    final rate = calculateRate(
      category: category,
      landArea: landArea,
    );

    return feddan * rate;
  }

  static double calculateLandscapeHours({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculatePlannedHours(category: category, landArea: landArea) *
        landscapeShare;
  }

  static double calculateUrbanHours({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculatePlannedHours(category: category, landArea: landArea) *
        urbanShare;
  }

  static double calculateRoadsHours({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculatePlannedHours(category: category, landArea: landArea) *
        roadsShare;
  }

  static double calculateInfrastructureWetHours({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculatePlannedHours(category: category, landArea: landArea) *
        infrastructureWetShare;
  }

  static double calculateInfrastructureDryHours({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculatePlannedHours(category: category, landArea: landArea) *
        infrastructureDryShare;
  }

  static Map<MasterPlanPhase, double> _applyPhaseDistribution({
    required double totalHours,
    required Map<MasterPlanPhase, MasterPlanScopeMode> scope,
    required double validationFactor,
  }) {
    final result = <MasterPlanPhase, double>{};

    for (final phase in MasterPlanPhase.values) {
      final share = phaseProfile[phase] ?? 0;
      final rawHours = totalHours * share;
      final mode = scope[phase] ?? MasterPlanScopeMode.off;

      switch (mode) {
        case MasterPlanScopeMode.full:
          result[phase] = rawHours;
          break;
        case MasterPlanScopeMode.validation:
          result[phase] = rawHours * validationFactor;
          break;
        case MasterPlanScopeMode.off:
          result[phase] = 0;
          break;
      }
    }

    return result;
  }

  static Map<MasterPlanPhase, double> distributeLandscapeByPhase({
    required MasterPlanCategory category,
    required double landArea,
    required Map<MasterPlanPhase, MasterPlanScopeMode> scope,
    required double validationFactor,
  }) {
    return _applyPhaseDistribution(
      totalHours: calculateLandscapeHours(category: category, landArea: landArea),
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<MasterPlanPhase, double> distributeUrbanByPhase({
    required MasterPlanCategory category,
    required double landArea,
    required Map<MasterPlanPhase, MasterPlanScopeMode> scope,
    required double validationFactor,
  }) {
    return _applyPhaseDistribution(
      totalHours: calculateUrbanHours(category: category, landArea: landArea),
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<MasterPlanPhase, double> distributeRoadsByPhase({
    required MasterPlanCategory category,
    required double landArea,
    required Map<MasterPlanPhase, MasterPlanScopeMode> scope,
    required double validationFactor,
  }) {
    return _applyPhaseDistribution(
      totalHours: calculateRoadsHours(category: category, landArea: landArea),
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<MasterPlanPhase, double> distributeInfrastructureWetByPhase({
    required MasterPlanCategory category,
    required double landArea,
    required Map<MasterPlanPhase, MasterPlanScopeMode> scope,
    required double validationFactor,
  }) {
    return _applyPhaseDistribution(
      totalHours: calculateInfrastructureWetHours(
        category: category,
        landArea: landArea,
      ),
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<MasterPlanPhase, double> distributeInfrastructureDryByPhase({
    required MasterPlanCategory category,
    required double landArea,
    required Map<MasterPlanPhase, MasterPlanScopeMode> scope,
    required double validationFactor,
  }) {
    return _applyPhaseDistribution(
      totalHours: calculateInfrastructureDryHours(
        category: category,
        landArea: landArea,
      ),
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static double sumPhaseHours(Map<MasterPlanPhase, double> phaseHours) {
    return phaseHours.values.fold(0, (sum, value) => sum + value);
  }

  static double calculateLandscapeCost({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculateLandscapeHours(category: category, landArea: landArea) *
        landscapeCostPerHour;
  }

  static double calculateUrbanCost({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculateUrbanHours(category: category, landArea: landArea) *
        urbanCostPerHour;
  }

  static double calculateRoadsCost({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculateRoadsHours(category: category, landArea: landArea) *
        roadsCostPerHour;
  }

  static double calculateInfrastructureWetCost({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculateInfrastructureWetHours(category: category, landArea: landArea) *
        infrastructureWetCostPerHour;
  }

  static double calculateInfrastructureDryCost({
    required MasterPlanCategory category,
    required double landArea,
  }) {
    return calculateInfrastructureDryHours(category: category, landArea: landArea) *
        infrastructureDryCostPerHour;
  }

  static double calculateTotalCost({
    required MasterPlanCategory category,
    required double landArea,
    required double otherExpenses,
  }) {
    return calculateLandscapeCost(category: category, landArea: landArea) +
        calculateUrbanCost(category: category, landArea: landArea) +
        calculateRoadsCost(category: category, landArea: landArea) +
        calculateInfrastructureWetCost(category: category, landArea: landArea) +
        calculateInfrastructureDryCost(category: category, landArea: landArea) +
        otherExpenses;
  }

  static double calculateFinalPrice({
    required MasterPlanCategory category,
    required double landArea,
    required double otherExpenses,
    required double profitMargin,
  }) {
    final totalCost = calculateTotalCost(
      category: category,
      landArea: landArea,
      otherExpenses: otherExpenses,
    );

    return totalCost * (1 + (profitMargin / 100));
  }
}
