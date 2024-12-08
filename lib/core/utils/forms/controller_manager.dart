import 'package:flutter/material.dart';
import 'package:julien/core/utils/models/pair.dart';

class ControllerManager {
  final Map<String, TextEditingController> _controllers = {};

  void init(List<String> keys) {
    for (var key in keys) {
      _controllers[key] = TextEditingController();
    }
  }

  void initWithData(List<Pair> data) {
    for (var kv in data) {
      _controllers[kv.key] = TextEditingController(text: kv.value?.toString());
    }
  }

  TextEditingController? get(String key) {
    return _controllers[key];
  }

  String? getText(String key) {
    return _controllers[key]?.text;
  }

  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    _controllers.clear();
  }
}
