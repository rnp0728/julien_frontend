import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_dashbaord_event.dart';
part 'project_dashbaord_state.dart';

class ProjectDashbaordBloc
    extends Bloc<ProjectDashbaordEvent, ProjectDashbaordState> {
  ProjectDashbaordBloc() : super(ProjectDashbaordInitial());
}
