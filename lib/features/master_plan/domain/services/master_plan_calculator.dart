import 'package:cost_model/features/master_plan/domain/models/master_plan_project_input.dart';
import 'package:cost_model/features/master_plan/domain/models/master_plan_result.dart';

class MasterPlanCalculator {
  const MasterPlanCalculator._();

  static MasterPlanResult calculate(MasterPlanProjectInput input) {
    final landAreaFeddan = input.landArea / 4200.0;
    final rate = _interpolatedRate(
      category: input.category,
      feddan: landAreaFeddan,
    );

    final totalHours = landAreaFeddan * rate * 100;
    final landscapeHours = totalHours * 0.25;
    final urbanHours = totalHours * 0.30;
    final roadsHours = totalHours * 0.10;
    final infraWetHours = totalHours * 0.15;
    final infraDryHours = totalHours * 0.20;

    final totalCost = totalHours * 304;
    final totalPrice =
        totalCost + (totalCost * (input.profitMargin / 100)) + input.otherExpenses;

    return MasterPlanResult(
      ratePerFeddan: rate,
      landAreaFeddan: landAreaFeddan,
      totalHours: totalHours,
      landscapeHours: landscapeHours,
      urbanHours: urbanHours,
      roadsHours: roadsHours,
      infraWetHours: infraWetHours,
      infraDryHours: infraDryHours,
      totalCost: totalCost,
      totalPrice: totalPrice,
    );
  }

  static double _interpolatedRate({
    required String category,
    required double feddan,
  }) {
    final x = <double>[5, 10, 25, 50, 100, 200];
    final y = switch (category) {
      'A' => <double>[10.5, 9.5, 8.5, 7.4, 6.8, 6.2],
      'B' => <double>[9.0, 8.2, 7.4, 6.7, 6.1, 5.6],
      _ => <double>[8.0, 7.2, 6.5, 5.8, 5.2, 4.8],
    };

    if (feddan <= x.first) return y.first;
    if (feddan >= x.last) return y.last;

    for (int i = 0; i < x.length - 1; i++) {
      final x1 = x[i];
      final x2 = x[i + 1];
      if (feddan >= x1 && feddan <= x2) {
        final y1 = y[i];
        final y2 = y[i + 1];
        final ratio = (feddan - x1) / (x2 - x1);
        return y1 + ((y2 - y1) * ratio);
      }
    }

    return y.last;
  }
}
