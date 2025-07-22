import 'dart:convert';
import 'dart:typed_data';

import 'package:etkinlik_takip/data/cache/core/manager/cache_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class HiveCacheOperation<T> extends CacheOperation<T> {
  /// Initialize hive box
  HiveCacheOperation(String boxName) {
    _box = Hive.box<T>(boxName);
  }

  late final Box<T> _box;
  @override
  Future<void> add({required String key, required T item}) async {
    await _box.put(key, item);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<T?> get(String key) async {
    try {
      return _box.get(key);
    } catch (e) {
      await _box.delete(key);
      return null;
    }
  }

  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  Future<Uint8List> createEncryption() async {
    const secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
    String? encryptionKeyString;
    try {
      encryptionKeyString = await secureStorage.read(key: 'key');
    } catch (e) {
      debugPrint('Error: $e');
    }
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    final key = await secureStorage.read(key: 'key');
    return base64Url.decode(key!);
  }

  @override
  Future<List<T>?> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<void> insert({required T item}) async {
    await _box.add(item);
  }

  @override
  Future<void> removeAt(int index) async {
    await _box.deleteAt(index);
  }

  @override
  Future<void> update({required T item, required int index}) async {
    await _box.putAt(index, item);
  }
}
