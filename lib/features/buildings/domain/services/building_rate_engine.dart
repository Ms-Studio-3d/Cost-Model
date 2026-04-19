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
}
