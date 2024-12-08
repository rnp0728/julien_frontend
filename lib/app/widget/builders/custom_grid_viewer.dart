// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:julien/core/utils/extensions/widget_extension.dart';

class GridData {
  final int itemsPerRow;
  final int crossAxisSpacing;
  final int mainAxisSpacing;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool makeLastExpanded;
  final bool makeFirstExpanded;
  final bool expandedChilds;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  final Axis scrollDirection;
  const GridData({
    required this.itemsPerRow,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.padding,
    this.physics,
    this.makeFirstExpanded = false,
    this.makeLastExpanded = false,
    this.expandedChilds = true,
    this.scrollDirection = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  GridData copyWith({
    int? itemsPerRow,
    int? crossAxisSpacing,
    int? mainAxisSpacing,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    bool? makeLastExpanded,
    bool? makeFirstExpanded,
    bool? expandedChilds,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
    Axis? scrollDirection,
  }) {
    return GridData(
      itemsPerRow: itemsPerRow ?? this.itemsPerRow,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      physics: physics ?? this.physics,
      padding: padding ?? this.padding,
      makeLastExpanded: makeLastExpanded ?? this.makeLastExpanded,
      makeFirstExpanded: makeFirstExpanded ?? this.makeFirstExpanded,
      expandedChilds: expandedChilds ?? this.expandedChilds,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      scrollDirection: scrollDirection ?? this.scrollDirection,
    );
  }
}

class CustomGridViewer extends StatefulWidget {
  final GridData gridData;
  final List<Widget> children;

  const CustomGridViewer({
    super.key,
    required this.gridData,
    required this.children,
  });

  @override
  State<CustomGridViewer> createState() => _CustomGridViewerState();
}

class _CustomGridViewerState extends State<CustomGridViewer> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int index = 0;
        index < widget.children.length;
        index += widget.gridData.itemsPerRow) {
      List<Widget> perRowChildren = [];
      bool shouldExpandFirstItem =
          widget.gridData.makeFirstExpanded && index == 0;
      if (shouldExpandFirstItem) {
        perRowChildren.add(widget.children[index]);
        // setting the index back to - itemsPerRow so that next iteration starts from 1 so there will be no skipping of any items
        index = index - widget.gridData.itemsPerRow + 1;
      } else {
        for (int j = 0;
            j < widget.gridData.itemsPerRow &&
                index + j < widget.children.length;
            j++) {
          perRowChildren.add(widget.children[index + j]);
        }
      }
      bool shouldExpandLastItem = widget.gridData.makeLastExpanded &&
          index + widget.gridData.itemsPerRow >= widget.children.length;

      if (shouldExpandFirstItem || shouldExpandLastItem) {
        rows.add(perRowChildren.row(expanded: true, separator: 10.spacer()));
      } else {
        if (!widget.gridData.makeLastExpanded &&
            !widget.gridData.makeFirstExpanded) {
          bool isLastRow =
              index + widget.gridData.itemsPerRow >= widget.children.length;
          if (isLastRow &&
              perRowChildren.length < widget.gridData.itemsPerRow) {
            int dummyItemCount =
                widget.gridData.itemsPerRow - perRowChildren.length;
            for (int k = 0; k < dummyItemCount; k++) {
              perRowChildren.add(Container());
            }
          }
        }
        rows.add(
          perRowChildren.row(
            separator: widget.gridData.crossAxisSpacing.spacer(),
            crossAxisAlignment: widget.gridData.crossAxisAlignment,
            mainAxisAlignment: widget.gridData.mainAxisAlignment,
            expanded: widget.gridData.expandedChilds,
          ),
        );
      }
    }

    return SingleChildScrollView(
      physics: widget.gridData.physics ?? const AlwaysScrollableScrollPhysics(),
      padding: widget.gridData.padding,
      scrollDirection: widget.gridData.scrollDirection,
      child: rows.column(
        separator: widget.gridData.mainAxisSpacing.spacer(),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
