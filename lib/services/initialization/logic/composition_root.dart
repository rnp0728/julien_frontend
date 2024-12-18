import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:julien/core/constant/config.dart';
import 'package:julien/core/di/dependency_injection.dart';
import 'package:julien/core/rest_client/rest_client.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/core/utils/refined_logger.dart';
import 'package:julien/services/authentication/bloc/authentication_bloc.dart';
import 'package:julien/services/authentication/data/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:julien/core/utils/error_tracking_manager.dart';
import 'package:julien/services/settings/bloc/app_settings_bloc.dart';
import 'package:julien/services/settings/data/app_settings_datasource.dart';
import 'package:julien/services/settings/data/app_settings_repository.dart';
import 'package:julien/services/initialization/model/dependencies_container.dart';

/// {@template composition_root}
/// A place where all dependencies are initialized.
/// {@endtemplate}
///
/// {@template composition_process}
/// Composition of dependencies is a process of creating and configuring
/// instances of classes that are required for the application to work.
///
/// It is a good practice to keep all dependencies in one place to make it
/// easier to manage them and to ensure that they are initialized only once.
/// {@endtemplate}
final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await DependenciesFactory(config, logger).create();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }
}

/// {@template factory}
/// Factory that creates an instance of [T].
/// {@endtemplate}
abstract class Factory<T> {
  /// Creates an instance of [T].
  T create();
}

/// {@template async_factory}
/// Factory that creates an instance of [T] asynchronously.
/// {@endtemplate}
abstract class AsyncFactory<T> {
  /// Creates an instance of [T].
  Future<T> create();
}

/// {@template dependencies_factory}
/// Factory that creates an instance of [DependenciesContainer].
/// {@endtemplate}
class DependenciesFactory extends AsyncFactory<DependenciesContainer> {
  /// {@macro dependencies_factory}
  DependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<DependenciesContainer> create() async {
    final sharedPreferences = SharedPreferencesAsync();

    final errorTrackingManager =
        await ErrorTrackingManagerFactory(config, logger).create();
    final settingsBloc = await SettingsBlocFactory(sharedPreferences).create();
    final restClient = getIt<RestClientDio>();

    final authBloc =
        await AutheticationBlocFactory(sharedPreferences, restClient).create();

    /// Initialize the Persistent Manager
    await PersistentManager.initialize();
    return DependenciesContainer(
      appSettingsBloc: settingsBloc,
      errorTrackingManager: errorTrackingManager,
      restClient: restClient,
      authBloc: authBloc,
    );
  }
}

/// {@template error_tracking_manager_factory}
/// Factory that creates an instance of [ErrorTrackingManager].
/// {@endtemplate}
class ErrorTrackingManagerFactory extends AsyncFactory<ErrorTrackingManager> {
  /// {@macro error_tracking_manager_factory}
  ErrorTrackingManagerFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<ErrorTrackingManager> create() async {
    final errorTrackingManager = SentryTrackingManager(
      logger,
      sentryDsn: config.sentryDsn,
      environment: config.environment.value,
    );

    if (config.enableSentry && kReleaseMode) {
      await errorTrackingManager.enableReporting();
    }

    return errorTrackingManager;
  }
}

/// {@template settings_bloc_factory}
/// Factory that creates an instance of [AppSettingsBloc].
/// {@endtemplate}
class SettingsBlocFactory extends AsyncFactory<AppSettingsBloc> {
  /// {@macro settings_bloc_factory}
  SettingsBlocFactory(this.sharedPreferences);

  /// Shared preferences instance
  final SharedPreferencesAsync sharedPreferences;

  @override
  Future<AppSettingsBloc> create() async {
    final appSettingsRepository = AppSettingsRepositoryImpl(
      datasource:
          AppSettingsDatasourceImpl(sharedPreferences: sharedPreferences),
    );

    final appSettings = await appSettingsRepository.getAppSettings();
    final initialState = AppSettingsState.idle(appSettings: appSettings);

    return AppSettingsBloc(
      appSettingsRepository: appSettingsRepository,
      initialState: initialState,
    );
  }
}

/// {@template settings_bloc_factory}
/// Factory that creates an instance of [AuthenticationBloc].
/// {@endtemplate}
class AutheticationBlocFactory extends AsyncFactory<AuthenticationBloc> {
  /// {@macro auth_bloc_factory}
  AutheticationBlocFactory(this.sharedPreferences, this.restClientHttp);

  /// Shared preferences instance
  final SharedPreferencesAsync sharedPreferences;

  /// Rest client instance
  final RestClientDio restClientHttp;

  @override
  Future<AuthenticationBloc> create() async {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepositoryImpl(client: restClientHttp);
    return AuthenticationBloc(
      authenticationRepository: authenticationRepository,
    );
  }
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
