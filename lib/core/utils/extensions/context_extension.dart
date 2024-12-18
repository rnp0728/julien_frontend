import 'package:flutter/material.dart';

/// List of extensions for [BuildContext]
extension ContextExtension on BuildContext {
  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T? inhMaybeOf<T extends InheritedWidget>({bool listen = true}) => listen
      ? dependOnInheritedWidgetOfExactType<T>()
      : getInheritedWidgetOfExactType<T>();

  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T inhOf<T extends InheritedWidget>({bool listen = true}) =>
      inhMaybeOf<T>(listen: listen) ??
      (throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $T of the exact type',
        'out_of_scope',
      ));

  /// Maybe inherit specific aspect from [InheritedModel].
  T? maybeInheritFrom<A extends Object, T extends InheritedModel<A>>({
    A? aspect,
  }) =>
      InheritedModel.inheritFrom<T>(this, aspect: aspect);

  /// Inherit specific aspect from [InheritedModel].
  T inheritFrom<A extends Object, T extends InheritedModel<A>>({A? aspect}) =>
      maybeInheritFrom(aspect: aspect) ??
      (throw ArgumentError(
        'Out of scope, not found inherited model '
            'a $T of the exact type',
        'out_of_scope',
      ));

  /// Height
  double get height => MediaQuery.of(this).size.height;

  /// Width
  double get width => MediaQuery.of(this).size.width;

  /// IS LIGHT THEME
  bool get isLightTheme => Theme.of(this).brightness == Brightness.light;

  /// IS DARK THEME
  bool get isDarkTheme => !isLightTheme;

  T byTheme<T>({
    required T light,
    required T dark,
  }) =>
      isLightTheme ? light : dark;

  T responsive<T>(
    T defaultValue, {
    T? sm,
    T? md,
    T? lg,
  }) {
    final w = MediaQuery.of(this).size.width;
    return w > 1024
        ? (lg ?? md ?? sm ?? defaultValue)
        : w > 768
            ? (md ?? sm ?? defaultValue)
            : w > 640
                ? (sm ?? defaultValue)
                : sm ?? defaultValue;
  }
}
