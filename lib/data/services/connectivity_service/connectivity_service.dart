import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:etkinlik_takip/data/services/connectivity_service/IConnectivityService.dart';

class ConnectivityService extends IConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>> _controller = StreamController.broadcast();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityService._internal() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty) {
        _controller.add(results);
      }
    });
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    final hasConnection = result.any((result) => result != ConnectivityResult.none);
    return hasConnection;
  }

  @override
  Stream<List<ConnectivityResult>> get connectivityStream => _controller.stream;

  @override
  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}
