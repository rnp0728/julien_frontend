import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julien/services/authentication/bloc/authentication_bloc.dart';
import 'package:julien/services/initialization/model/app_theme.dart';
import 'package:julien/services/initialization/widget/dependencies_scope.dart';
import 'package:julien/services/routing/app_router.dart';
import 'package:julien/services/settings/widget/settings_scope.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatefulWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});
  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey();
  static final router = AppRouter.router();

  @override
  State<MaterialContext> createState() => _MaterialContextState();
}

class _MaterialContextState extends State<MaterialContext> {
  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.settingsOf(context);
    final mediaQueryData = MediaQuery.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              DependenciesScope.of(context).authBloc..add(AppStartedEvent()),
        ),
        BlocProvider(
          create: (context) => DependenciesScope.of(context).appSettingsBloc,
        ),
      ],
      child: MaterialApp.router(
        title: settings.appName ?? '',
        debugShowCheckedModeBanner: false,
        theme:
            settings.appTheme?.lightTheme ?? AppTheme.defaultTheme.lightTheme,
        darkTheme:
            settings.appTheme?.darkTheme ?? AppTheme.defaultTheme.darkTheme,
        themeMode: settings.appTheme?.themeMode ?? ThemeMode.system,
        locale: settings.locale,
        builder: (context, child) => MediaQuery(
          key: MaterialContext._globalKey,
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(
              mediaQueryData.textScaler
                  .scale(settings.textScale ?? 1)
                  .clamp(0.5, 2),
            ),
          ),
          child: child!,
        ),
        routerConfig: MaterialContext.router,
      ),
    );
  }
}
