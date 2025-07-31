import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:etkinlik_takip/data/services/core_services/connectivity_service/IConnectivityService.dart';

class ConnectivityMockService implements IConnectivityService {
  final StreamController<List<ConnectivityResult>> _controller = StreamController.broadcast();

  bool _connected = true;

  @override
  Future<bool> get isConnected async => _connected;

  @override
  Stream<List<ConnectivityResult>> get connectivityStream => _controller.stream;

  void simulateConnectionChange(List<ConnectivityResult> results) {
    _controller.add(results);
    _connected = results.any((r) => r != ConnectivityResult.none);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
