import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julien/services/settings/data/app_settings_repository.dart';
import 'package:julien/services/settings/model/app_settings.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';
/// {@template app_settings_bloc}
/// A [Bloc] that handles [AppSettings].
/// {@endtemplate}
final class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  /// {@macro app_settings_bloc}
  AppSettingsBloc({
    required AppSettingsRepository appSettingsRepository,
    required AppSettingsState initialState,
  })  : _appSettingsRepository = appSettingsRepository,
        super(initialState) {
    on<AppSettingsEvent>(
      (event, emit) => switch (event) {
        final _UpdateAppSettingsEvent e => _updateAppSettings(e, emit),
      },
    );
  }

  final AppSettingsRepository _appSettingsRepository;

  Future<void> _updateAppSettings(
    _UpdateAppSettingsEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    try {
      emit(_LoadingAppSettingsState(appSettings: state.appSettings));
      await _appSettingsRepository.setAppSettings(event.appSettings);
      emit(_IdleAppSettingsState(appSettings: event.appSettings));
    } catch (error) {
      emit(
          _ErrorAppSettingsState(appSettings: event.appSettings, error: error));
    }
  }
}
