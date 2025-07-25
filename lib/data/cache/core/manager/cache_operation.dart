abstract class CacheOperation<T> {
  Future<void> add({required String key, required T item});
  Future<void> insert({required T item});
  Future<void> update({required T item, required int index});
  Future<void> remove(String key);
  Future<void> removeAt(int index);

  Future<void> clear();
  Future<T?> get(String key);
  Future<List<T>?> getAll();
}
