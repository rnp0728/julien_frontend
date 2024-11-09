import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onbaording_event.dart';
part 'onbaording_state.dart';

class OnbaordingBloc extends Bloc<OnbaordingEvent, OnbaordingState> {
  OnbaordingBloc() : super(OnbaordingInitial()) {
    on<OnbaordingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
