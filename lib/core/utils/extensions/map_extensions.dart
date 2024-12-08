extension MapExtensions on Map<String, dynamic>? {
  Map<String, dynamic> copyWith({required String key, required dynamic value}) {
    if (this != null) {
      Map<String, dynamic> updatedMap = Map.fromEntries(this!.entries);
      updatedMap[key] = value;
      return updatedMap;
    }
    return this ?? <String, dynamic>{};
  }

  Map<String, dynamic> updateWith({required Map<String, dynamic> data}) {
    Map<String, dynamic> newMap = Map.fromEntries(this?.entries ?? {});
    newMap.addAll(Map.from(data));
    return newMap;
  }
}

extension MergeMapsExtension<K, V> on Iterable<Map<K, V>> {
  Map<K, V> mergeMaps() {
    return fold<Map<K, V>>({}, (acc, map) {
      acc.addAll(map);
      return acc;
    });
  }
}
