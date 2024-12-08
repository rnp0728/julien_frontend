import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:julien/app/widget/builders/custom_grid_viewer.dart';

extension NumWidgetExtensions on num {
  Widget spacer() {
    return Gap(double.parse(toString()));
  }
}

extension WidgetExtension on Widget {
  Widget padding(EdgeInsetsGeometry padding) => Padding(
        padding: padding,
        child: this,
      );

  Widget expanded({int? flex, bool condition = true}) {
    if (!condition) {
      return this;
    }
    return Expanded(
      child: this,
    );
  }

  Widget flexible([bool? ifTrue]) {
    return ifTrue ?? true ? Flexible(child: this) : this;
  }

  Widget centered() {
    return Center(child: this);
  }
}

extension DurationExtension on int {
  Duration get milliseconds {
    return Duration(milliseconds: this);
  }

  Duration get seconds {
    return Duration(seconds: this);
  }

  Duration get minutes {
    return Duration(minutes: this);
  }
}

enum WrapperType {
  row,
  column,
  wrap,
  stack,
}

enum ViewWrapperType { listView, gridView, customView }

extension ListExtensions<E> on List<Widget> {
  Widget wrapper({
    Key? key,
    required WrapperType wrapperType,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
    Axis direction = Axis.horizontal,
    WrapAlignment wrapAlignment = WrapAlignment.start,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
    WrapCrossAlignment wrapCrossAxisAlignment = WrapCrossAlignment.start,
    Clip wrapClipBehavior = Clip.none,
    bool expanded = false,
  }) {
    switch (wrapperType) {
      case WrapperType.row:
        return row(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          separator: separator,
          textBaseline: textBaseline,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          expanded: expanded,
        );
      case WrapperType.column:
        return column(
          key: key,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          separator: separator,
          textBaseline: textBaseline,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
        );
      case WrapperType.wrap:
        return wrap(
          key: key,
          crossAxisAlignment: wrapCrossAxisAlignment,
          alignment: wrapAlignment,
          runAlignment: runAlignment,
          clipBehavior: clipBehavior,
          direction: direction,
          runSpacing: runSpacing,
          spacing: spacing,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
        );
      case WrapperType.stack:
        return stack(
          key: key,
          alignment: alignment,
          clipBehavior: clipBehavior,
          fit: fit,
          textDirection: textDirection,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget viewWrapper({
    Key? key,
    required ViewWrapperType viewWrapperType,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool primary = true,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
    SliverGridDelegate gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 1.0,
    ),
    GridData gridData = const GridData(
      itemsPerRow: 3,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      makeFirstExpanded: false,
      makeLastExpanded: false,
    ),
  }) {
    switch (viewWrapperType) {
      case ViewWrapperType.listView:
        return listView(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          padding: padding,
          shrinkWrap: shrinkWrap,
        );
      case ViewWrapperType.gridView:
        return gridView(
          key: key,
          gridDelegate: gridDelegate,
          padding: padding,
          physics: physics,
          shrinkWrap: shrinkWrap,
        );
      case ViewWrapperType.customView:
        return customGrid(
          key: key,
          gridData: gridData,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget column({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
  }) =>
      Column(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: separator != null && isNotEmpty
            ? (expand((child) => [child, separator]).toList()..removeLast())
            : this,
      );

  Widget row({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Widget? separator,
    bool expanded = false,
  }) =>
      Row(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: separator != null && isNotEmpty
            ? (expand((child) => [
                  child.expanded(
                    condition: expanded,
                  ),
                  separator
                ]).toList()
              ..removeLast())
            : this,
      );

  Widget stack({
    Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      Stack(
        key: key,
        alignment: alignment,
        textDirection: textDirection,
        fit: fit,
        clipBehavior: clipBehavior,
        children: this,
      );

  Widget wrap({
    Key? key,
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
  }) =>
      Wrap(
        key: key,
        direction: direction,
        alignment: alignment,
        spacing: spacing,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        clipBehavior: clipBehavior,
        children: this,
      );

  Widget listView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool primary = true,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    bool shrinkWrap = false,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
  }) =>
      ListView(
        key: key,
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        padding: padding,
        itemExtent: itemExtent,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        children: this,
      );

  Widget gridView({
    Key? key,
    SliverGridDelegate gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 1.0,
    ),
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? cacheExtent,
  }) =>
      GridView.builder(
        key: key,
        gridDelegate: gridDelegate,
        padding: padding,
        physics: physics,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        itemCount: length,
        itemBuilder: (context, index) {
          return this[index];
        },
      );

  Widget customGrid({
    Key? key,
    required GridData gridData,
  }) {
    return CustomGridViewer(
      key: key,
      gridData: gridData,
      children: this,
    );
  }
}

extension ListExt<E> on List<Widget> {
  List<Widget> separator(dynamic value, [bool doExpand = false]) {
    return isEmpty
        ? this
        : (expand(
            (child) => [
              child,
              value is Widget ? value : Gap(double.parse(value.toString())),
            ],
          ).toList()
          ..removeLast());
  }
}
