import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityFunction {
  static final ConnectivityFunction _instance = ConnectivityFunction._internal();

  factory ConnectivityFunction() => _instance;

  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>> _controller = StreamController.broadcast();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityFunction._internal() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        _controller.add(results);
      }
    });
  }

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    final hasConnection = result.any((result) => result != ConnectivityResult.none);
    return hasConnection;
  }

  Stream<List<ConnectivityResult>> get connectivityStream => _controller.stream;

  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}
