import 'package:cost_model/features/buildings/domain/models/buildings_project_input.dart';
import 'package:cost_model/features/buildings/domain/models/buildings_result.dart';

class BuildingsCalculator {
  const BuildingsCalculator._();

  static BuildingsResult calculate(BuildingsProjectInput input) {
    final rate = _interpolatedRate(
      category: input.category,
      area: input.builtUpArea,
    );

    final totalPlannedHours = input.builtUpArea * rate;
    final productionHours = totalPlannedHours * 0.85;
    final supportiveHours = totalPlannedHours * 0.15;

    final architectureHours = productionHours * 0.29;
    final structureHours = productionHours * 0.22;
    final electricalHours = productionHours * 0.23;
    final plumbingHours = productionHours * 0.12;
    final hvacHours = productionHours * 0.14;
    final qsHours = (architectureHours + structureHours) * 0.10;
    final idHours = input.idBuiltUpArea * _idRate(input.category);

    final totalHoursWithId = totalPlannedHours + qsHours + idHours;

    final weightedHourCost = _hourCostForSystem(input.projectSystem);
    final totalCost = totalHoursWithId * weightedHourCost;
    final totalPrice =
        totalCost + (totalCost * (input.profitMargin / 100)) + input.otherExpenses;

    return BuildingsResult(
      ratePerSqm: rate,
      totalPlannedHours: totalHoursWithId,
      productionHours: productionHours,
      supportiveHours: supportiveHours,
      architectureHours: architectureHours,
      structureHours: structureHours,
      electricalHours: electricalHours,
      plumbingHours: plumbingHours,
      hvacHours: hvacHours,
      qsHours: qsHours,
      idHours: idHours,
      totalCost: totalCost,
      totalPrice: totalPrice,
    );
  }

  static double _hourCostForSystem(String system) {
    switch (system) {
      case 'CAD':
        return 300;
      case 'BOTH':
        return 340;
      case 'BIM':
      default:
        return 325;
    }
  }

  static double _idRate(String category) {
    switch (category) {
      case 'A':
        return 0.22;
      case 'B':
        return 0.18;
      case 'C':
      default:
        return 0.15;
    }
  }

  static double _interpolatedRate({
    required String category,
    required double area,
  }) {
    final x = <double>[5000, 15000, 25000, 50000, 100000, 200000, 300000];

    final y = switch (category) {
      'A' => <double>[1.40, 1.20, 1.05, 0.95, 0.85, 0.78, 0.72],
      'B' => <double>[1.05, 0.92, 0.84, 0.76, 0.70, 0.64, 0.60],
      _ => <double>[0.72, 0.60, 0.54, 0.48, 0.43, 0.39, 0.36],
    };

    if (area <= x.first) return y.first;
    if (area >= x.last) return y.last;

    for (int i = 0; i < x.length - 1; i++) {
      final x1 = x[i];
      final x2 = x[i + 1];
      if (area >= x1 && area <= x2) {
        final y1 = y[i];
        final y2 = y[i + 1];
        final ratio = (area - x1) / (x2 - x1);
        return y1 + ((y2 - y1) * ratio);
      }
    }

    return y.last;
  }
}
