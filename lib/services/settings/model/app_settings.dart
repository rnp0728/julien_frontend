import 'dart:ui' show Locale;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:julien/services/initialization/model/app_theme.dart';

/// {@template app_settings}
/// Application settings
/// {@endtemplate}
class AppSettings extends Equatable with Diagnosticable {
  /// {@macro app_settings}
  const AppSettings({
    this.appName,
    this.appTheme,
    this.locale,
    this.textScale,
  });

  /// The name of the application
  final String? appName;

  /// The theme of the app,
  final AppTheme? appTheme;

  /// The locale of the app.
  final Locale? locale;

  /// The text scale of the app.
  final double? textScale;

  /// Copy the [AppSettings] with new values.
  AppSettings copyWith({
    String? appName,
    AppTheme? appTheme,
    Locale? locale,
    double? textScale,
  }) =>
      AppSettings(
        appName: appName ?? this.appName,
        appTheme: appTheme ?? this.appTheme,
        locale: locale ?? this.locale,
        textScale: textScale ?? this.textScale,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(StringProperty('appName', appName));
    properties.add(DiagnosticsProperty<AppTheme>('appTheme', appTheme));
    properties.add(DiagnosticsProperty<Locale>('locale', locale));
    properties.add(DoubleProperty('textScale', textScale));
    super.debugFillProperties(properties);
  }

  @override
  List<Object?> get props => [
        appName,
        appTheme,
        locale,
        textScale,
      ];
}
