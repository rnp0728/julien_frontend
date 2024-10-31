import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'project_environments_event.dart';
part 'project_environments_state.dart';

class ProjectEnvironmentsBloc
    extends Bloc<ProjectEnvironmentsEvent, ProjectEnvironmentsState> {
  ProjectEnvironmentsBloc() : super(ProjectEnvironmentsInitial());
}
