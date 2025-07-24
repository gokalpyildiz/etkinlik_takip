import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IConnectivityService {
  Future<bool> get isConnected;
  Stream<List<ConnectivityResult>> get connectivityStream;

  void dispose();
}
