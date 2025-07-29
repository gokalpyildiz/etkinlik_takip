// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:etkinlik_takip/data/cache/core/manager/cache_manager.dart';
import 'package:etkinlik_takip/data/cache/hive/constants/hive_box_names.dart';
import 'package:etkinlik_takip/data/models/event_models/event_list_model.dart';
import 'package:etkinlik_takip/data/models/event_models/event_model.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final class HiveCacheManager extends CacheManager {
  HiveCacheManager();

  @override
  Future<void> init() async {
    await _setHive();
  }

  @override
  Future<void> remove() async => Hive.deleteFromDisk();

  Future<void> _setHive() async {
    await _setDir();
    final encryptionKey = await createEncryption();
    await _setAdapters();
    await setBoxes(encryptionKey);
  }

  Future<void> _setDir() async {
    try {
      const keyPath = 'hiveVersion';
      final dbDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter('${dbDir.path}/$keyPath');
    } catch (e) {
      //todo crash service implement
    }
  }

  Future<void> _setAdapters() async {
    try {
      Hive
        ..registerAdapter(TokenModelAdapter())
        ..registerAdapter(EventModelAdapter())
        ..registerAdapter(EventListModelAdapter());
    } catch (e) {
      //TODO crash service implement
    }
  }

  Future<void> setBoxes(Uint8List encryptionKey) async {
    try {
      await Hive.openBox<TokenModel>(HiveBoxNames.token.value, encryptionCipher: HiveAesCipher(encryptionKey));
      await Hive.openBox<EventListModel>(HiveBoxNames.eventList.value);
      await Hive.openBox<String>(HiveBoxNames.string.value);
    } catch (e) {
      //TODO crash service implement
    }
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
}
