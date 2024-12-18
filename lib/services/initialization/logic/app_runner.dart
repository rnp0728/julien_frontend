import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:julien/core/constant/config.dart';
import 'package:julien/core/di/dependency_injection.dart';
import 'package:julien/core/utils/app_bloc_observer.dart';
import 'package:julien/core/utils/refined_logger.dart';
import 'package:julien/services/initialization/logic/composition_root.dart';
import 'package:julien/services/initialization/widget/app.dart';
import 'package:julien/services/initialization/widget/initialization_failed_app.dart';

/// {@template app_runner}
/// A class which is responsible for initialization and running the app.
/// {@endtemplate}
final class AppRunner {
  /// {@macro app_runner}
  const AppRunner();

  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve splash screen
    binding.deferFirstFrame();

    // Override logging
    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    // Setup bloc observer and transformer
    Bloc.observer = AppBlocObserver(logger);
    // Bloc.transformer = bloc_concurrency.sequential();
    const config = Config();
    usePathUrlStrategy();

    Future<void> initializeAndRun() async {
      try {
        await AppInjector.initializeDependencies();
        final result = await CompositionRoot(config, logger).compose();
        // Attach this widget to the root of the tree.
        runApp(App(result: result));
      } catch (e, stackTrace) {
        logger.error('Initialization failed', error: e, stackTrace: stackTrace);
        runApp(
          InitializationFailedApp(
            error: e,
            stackTrace: stackTrace,
            onRetryInitialization: initializeAndRun,
          ),
        );
      } finally {
        // Allow rendering
        binding.allowFirstFrame();
      }
    }

    // Run the app
    await initializeAndRun();
  }
}
