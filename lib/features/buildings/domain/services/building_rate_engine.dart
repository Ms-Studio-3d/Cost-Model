import '../models/buildings_project.dart';

class CurvePoint {
  const CurvePoint({
    required this.area,
    required this.rate,
  });

  final double area;
  final double rate;
}

class BuildingRateEngine {
  const BuildingRateEngine._();

  static const double productionShare = 0.85;
  static const double supportiveShare = 0.15;

  static const double architectureShare = 0.29;
  static const double structureShare = 0.22;
  static const double electricalShare = 0.23;
  static const double plumbingShare = 0.12;
  static const double hvacShare = 0.14;
  static const double qsShareFromArchAndStructure = 0.10;

  static const double projectManagementCadShare = 0.30;
  static const double qualityControlCadShare = 0.20;
  static const double bimCadCadShare = 0.15;
  static const double documentControlCadShare = 0.35;

  static const double projectManagementBimShare = 0.25;
  static const double qualityControlBimShare = 0.18;
  static const double bimCadBimShare = 0.32;
  static const double documentControlBimShare = 0.25;

  static const Map<BuildingPhase, double> architecturePhaseProfile = {
    BuildingPhase.concept: 0.15,
    BuildingPhase.schematic: 0.20,
    BuildingPhase.permits: 0.00,
    BuildingPhase.detailedDesign: 0.30,
    BuildingPhase.tenderIfc: 0.35,
  };

  static const Map<BuildingPhase, double> structurePhaseProfile = {
    BuildingPhase.concept: 0.01,
    BuildingPhase.schematic: 0.24,
    BuildingPhase.permits: 0.00,
    BuildingPhase.detailedDesign: 0.35,
    BuildingPhase.tenderIfc: 0.40,
  };

  static const Map<BuildingPhase, double> mepPhaseProfile = {
    BuildingPhase.concept: 0.01,
    BuildingPhase.schematic: 0.24,
    BuildingPhase.permits: 0.00,
    BuildingPhase.detailedDesign: 0.35,
    BuildingPhase.tenderIfc: 0.40,
  };

  static const Map<BuildingPhase, double> qsPhaseProfile = {
    BuildingPhase.concept: 0.00,
    BuildingPhase.schematic: 0.00,
    BuildingPhase.permits: 0.00,
    BuildingPhase.detailedDesign: 0.50,
    BuildingPhase.tenderIfc: 0.50,
  };

  static const Map<BuildingPhase, double> idPhaseProfile = {
    BuildingPhase.concept: 0.20,
    BuildingPhase.schematic: 0.25,
    BuildingPhase.permits: 0.00,
    BuildingPhase.detailedDesign: 0.25,
    BuildingPhase.tenderIfc: 0.30,
  };

  static const List<CurvePoint> _categoryA = [
    CurvePoint(area: 5000, rate: 1.20),
    CurvePoint(area: 15000, rate: 1.00),
    CurvePoint(area: 25000, rate: 0.90),
    CurvePoint(area: 50000, rate: 0.80),
    CurvePoint(area: 100000, rate: 0.70),
    CurvePoint(area: 200000, rate: 0.62),
    CurvePoint(area: 300000, rate: 0.56),
  ];

  static const List<CurvePoint> _categoryB = [
    CurvePoint(area: 5000, rate: 1.00),
    CurvePoint(area: 15000, rate: 0.82),
    CurvePoint(area: 25000, rate: 0.74),
    CurvePoint(area: 50000, rate: 0.66),
    CurvePoint(area: 100000, rate: 0.58),
    CurvePoint(area: 200000, rate: 0.52),
    CurvePoint(area: 300000, rate: 0.48),
  ];

  static const List<CurvePoint> _categoryC = [
    CurvePoint(area: 5000, rate: 0.80),
    CurvePoint(area: 15000, rate: 0.60),
    CurvePoint(area: 25000, rate: 0.54),
    CurvePoint(area: 50000, rate: 0.48),
    CurvePoint(area: 100000, rate: 0.42),
    CurvePoint(area: 200000, rate: 0.36),
    CurvePoint(area: 300000, rate: 0.32),
  ];

  static double calculate({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final points = switch (category) {
      ProjectCategory.a => _categoryA,
      ProjectCategory.b => _categoryB,
      ProjectCategory.c => _categoryC,
    };

    if (builtUpArea <= 0) return 0;

    if (builtUpArea <= points.first.area) {
      return points.first.rate;
    }

    if (builtUpArea >= points.last.area) {
      return points.last.rate;
    }

    for (int i = 0; i < points.length - 1; i++) {
      final start = points[i];
      final end = points[i + 1];

      if (builtUpArea >= start.area && builtUpArea <= end.area) {
        final span = end.area - start.area;
        final progress = (builtUpArea - start.area) / span;
        return start.rate + ((end.rate - start.rate) * progress);
      }
    }

    return points.last.rate;
  }

  static double calculatePlannedHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final rate = calculate(
      category: category,
      builtUpArea: builtUpArea,
    );

    return builtUpArea * rate;
  }

  static double calculateProductionHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final plannedHours = calculatePlannedHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return plannedHours * productionShare;
  }

  static double calculateSupportiveHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final plannedHours = calculatePlannedHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return plannedHours * supportiveShare;
  }

  static double calculateArchitectureHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final productionHours = calculateProductionHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return productionHours * architectureShare;
  }

  static double calculateStructureHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final productionHours = calculateProductionHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return productionHours * structureShare;
  }

  static double calculateElectricalHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final productionHours = calculateProductionHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return productionHours * electricalShare;
  }

  static double calculatePlumbingHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final productionHours = calculateProductionHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return productionHours * plumbingShare;
  }

  static double calculateHvacHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final productionHours = calculateProductionHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return productionHours * hvacShare;
  }

  static double calculateQsHours({
    required ProjectCategory category,
    required double builtUpArea,
  }) {
    final architectureHours = calculateArchitectureHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    final structureHours = calculateStructureHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return (architectureHours + structureHours) * qsShareFromArchAndStructure;
  }

  static double calculateIdHours({
    required double idBuiltUpArea,
  }) {
    if (idBuiltUpArea <= 0) return 0;

    return idBuiltUpArea * 0.35;
  }

  static double calculateProjectManagementHours({
    required ProjectCategory category,
    required double builtUpArea,
    required ProjectSystem projectSystem,
  }) {
    final supportiveHours = calculateSupportiveHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    final share = projectSystem == ProjectSystem.cad
        ? projectManagementCadShare
        : projectManagementBimShare;

    return supportiveHours * share;
  }

  static double calculateQualityControlHours({
    required ProjectCategory category,
    required double builtUpArea,
    required ProjectSystem projectSystem,
  }) {
    final supportiveHours = calculateSupportiveHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    final share = projectSystem == ProjectSystem.cad
        ? qualityControlCadShare
        : qualityControlBimShare;

    return supportiveHours * share;
  }

  static double calculateBimCadHours({
    required ProjectCategory category,
    required double builtUpArea,
    required ProjectSystem projectSystem,
  }) {
    final supportiveHours = calculateSupportiveHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    final share =
        projectSystem == ProjectSystem.cad ? bimCadCadShare : bimCadBimShare;

    return supportiveHours * share;
  }

  static double calculateDocumentControlHours({
    required ProjectCategory category,
    required double builtUpArea,
    required ProjectSystem projectSystem,
  }) {
    final supportiveHours = calculateSupportiveHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    final share = projectSystem == ProjectSystem.cad
        ? documentControlCadShare
        : documentControlBimShare;

    return supportiveHours * share;
  }

  static Map<BuildingPhase, double> distributeArchitectureByPhase({
    required ProjectCategory category,
    required double builtUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final totalHours = calculateArchitectureHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: architecturePhaseProfile,
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<BuildingPhase, double> distributeStructureByPhase({
    required ProjectCategory category,
    required double builtUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final totalHours = calculateStructureHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: structurePhaseProfile,
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<BuildingPhase, double> distributeElectricalByPhase({
    required ProjectCategory category,
    required double builtUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final totalHours = calculateElectricalHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: mepPhaseProfile,
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<BuildingPhase, double> distributePlumbingByPhase({
    required ProjectCategory category,
    required double builtUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final totalHours = calculatePlumbingHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: mepPhaseProfile,
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<BuildingPhase, double> distributeHvacByPhase({
    required ProjectCategory category,
    required double builtUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final totalHours = calculateHvacHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: mepPhaseProfile,
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<BuildingPhase, double> distributeQsByPhase({
    required ProjectCategory category,
    required double builtUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
  }) {
    final totalHours = calculateQsHours(
      category: category,
      builtUpArea: builtUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: qsPhaseProfile,
      scope: scope,
      validationFactor: 1,
    );
  }

  static Map<BuildingPhase, double> distributeIdByPhase({
    required double idBuiltUpArea,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final totalHours = calculateIdHours(
      idBuiltUpArea: idBuiltUpArea,
    );

    return _applyPhaseDistribution(
      totalHours: totalHours,
      profile: idPhaseProfile,
      scope: scope,
      validationFactor: validationFactor,
    );
  }

  static Map<BuildingPhase, double> _applyPhaseDistribution({
    required double totalHours,
    required Map<BuildingPhase, double> profile,
    required Map<BuildingPhase, ScopeMode> scope,
    required double validationFactor,
  }) {
    final result = <BuildingPhase, double>{};

    for (final phase in BuildingPhase.values) {
      final phaseShare = profile[phase] ?? 0;
      final scopeMode = scope[phase] ?? ScopeMode.off;
      final rawHours = totalHours * phaseShare;

      switch (scopeMode) {
        case ScopeMode.full:
          result[phase] = rawHours;
          break;
        case ScopeMode.validation:
          result[phase] = rawHours * validationFactor;
          break;
        case ScopeMode.off:
          result[phase] = 0;
          break;
      }
    }

    return result;
  }

  static double sumPhaseHours(Map<BuildingPhase, double> phaseHours) {
    return phaseHours.values.fold(0, (sum, value) => sum + value);
  }
}
