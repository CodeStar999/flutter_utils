import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import 'network_type.dart';

@internal
class NetworkStatusManager {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  List<NetworkType> _networkList = [];

  List<NetworkType> get networkType => _networkList;

  final StreamController<List<NetworkType>> _streamController =
      StreamController.broadcast();

  Stream<List<NetworkType>> get stream => _streamController.stream;

  Future<void> listenNetwork() async {
    try {
      final List<ConnectivityResult> result =
          await _connectivity.checkConnectivity();
      _networkList = result.map((e) => _mapToNetworkType(e)).toList();
    } on Exception catch (_) {}
    _subscription = _connectivity.onConnectivityChanged
        .skip(1)
        .listen(_networkStatusChanged);
  }

  void cancel() {
    _subscription?.cancel();
  }

  void _networkStatusChanged(List<ConnectivityResult> result) {
    final list = result.map((e) => _mapToNetworkType(e)).toList();
    _networkList = list;
    _streamController.add(list);
  }

  NetworkType _mapToNetworkType(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return NetworkType.bluetooth;
      case ConnectivityResult.wifi:
        return NetworkType.wifi;
      case ConnectivityResult.ethernet:
        return NetworkType.ethernet;
      case ConnectivityResult.mobile:
        return NetworkType.mobile;
      case ConnectivityResult.none:
        return NetworkType.none;
      case ConnectivityResult.vpn:
        return NetworkType.vpn;
      case ConnectivityResult.other:
        return NetworkType.other;
    }
  }
}
