import 'dart:async';
import 'package:julien/core/utils/refined_logger.dart';
import 'services/initialization/logic/app_runner.dart';

Future<void>? main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );
