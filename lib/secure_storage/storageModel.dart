import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class storageModel{
  static final storageModel _instance = storageModel._internal();
  final _storage = const FlutterSecureStorage();

  factory storageModel(){
    return _instance;
  }

  storageModel._internal(){
    //init
  }

  IOSOptions _getIOSOptions() => IOSOptions(
    accountName: 'account_name',
  );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
    // sharedPreferencesName: 'Test2',
    // preferencesKeyPrefix: 'Test'
  );

  Future<void> save(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions()
    );
  }
  Future<String?> read(String key) async{
    return await _storage.read(key: key);
  }
  Future<Map> readAll() async{
    return await _storage.readAll();
  }

  Future<void> delete(String key) async{
    await _storage.delete(key: key);
  }
}