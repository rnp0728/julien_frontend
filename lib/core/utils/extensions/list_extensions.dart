extension ListExtension<T> on List<T>? {
  int len() {
    return this?.length ?? 0;
  }

  bool isNullOrEmpty() {
    return (this == null || (this?.isEmpty ?? true));
  }

  bool isNotNullOrNotEmpty() {
    return (this != null && this!.isNotEmpty);
  }

  Iterable<(int, T)> enumerate() sync* {
    if (this.isNotNullOrNotEmpty()) {
      for (int i = 0; i < this!.length; i++) {
        yield (i, this![i]);
      }
    }
  }

  List<R> indexedMap<R>(R Function(int index, T item) f) {
    if (this.isNotNullOrNotEmpty()) {
      List<R> result = [];
      for (int i = 0; i < this!.length; i++) {
        result.add(f(i, this![i]));
      }
      return result;
    } else {
      return [];
    }
  }

  List<T> filter(bool Function(T item) condition, {bool negate = false}) {
    if (this.isNotNullOrNotEmpty()) {
      List<T> result = [];
      for (int i = 0; i < this!.length; i++) {
        if (negate ? !condition(this![i]) : condition(this![i])) {
          result.add(this![i]);
        }
      }
      return result;
    } else {
      return [];
    }
  }

  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this ?? []) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

extension ListFutureExtensions<T> on List<Future<T>> {
  Future<List<dynamic>> waitForAll() async {
    return Future.wait(this);
  }
}
