import 'dart:convert';

class Pair<T, V> {
  final T key;
  final V value;

  const Pair({
    required this.key,
    required this.value,
  });

  Pair copyWith({
    T? key,
    V? value,
  }) {
    return Pair(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'val': value,
    };
  }

  factory Pair.fromMap(Map<T, V> map) {
    return Pair(
      key: map['key'] as T,
      value: map['val'] as V,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pair.fromJson(String source) =>
      Pair.fromMap(json.decode(source) as Map<T, V>);

  @override
  String toString() => 'Pair(key: $key, val: $value)';

  @override
  bool operator ==(covariant Pair other) {
    if (identical(this, other)) return true;

    return other.key == key && other.value == value;
  }

  @override
  int get hashCode => key.hashCode ^ value.hashCode;
}
