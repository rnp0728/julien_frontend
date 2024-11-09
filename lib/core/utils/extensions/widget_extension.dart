import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension NumWidgetExtensions on num {
  Widget spacer() {
    return Gap(double.parse(toString()));
  }
}
