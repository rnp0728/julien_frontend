import 'package:flutter/material.dart';
import 'package:julien/core/utils/layout/layout.dart';
import 'package:julien/services/initialization/logic/composition_root.dart';
import 'package:julien/services/initialization/widget/dependencies_scope.dart';
import 'package:julien/services/initialization/widget/material_context.dart';
import 'package:julien/services/settings/widget/settings_scope.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// {@template app}
/// [App] is an entry point to the application.
///
/// If a scope doesn't depend on any inherited widget returned by
/// [MaterialApp] or [WidgetsApp], like [Directionality] or [Theme],
/// and it should be available in the whole application, it can be
/// placed here.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  /// The result from the [CompositionRoot].
  final CompositionResult result;

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
    bundle: SentryAssetBundle(),
    child: DependenciesScope(
      dependencies: result.dependencies,
      child: const SettingsScope(
        child: WindowSizeScope(child: MaterialContext()),
      ),
    ),
  );
}