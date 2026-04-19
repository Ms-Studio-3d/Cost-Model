import '../../../buildings/domain/models/buildings_project.dart';
import '../../../master_plan/domain/models/master_plan_project.dart';

class CombinedProject {
  const CombinedProject({
    required this.buildingsProject,
    required this.masterPlanProject,
  });

  final BuildingsProject buildingsProject;
  final MasterPlanProject masterPlanProject;

  CombinedProject copyWith({
    BuildingsProject? buildingsProject,
    MasterPlanProject? masterPlanProject,
  }) {
    return CombinedProject(
      buildingsProject: buildingsProject ?? this.buildingsProject,
      masterPlanProject: masterPlanProject ?? this.masterPlanProject,
    );
  }
}
