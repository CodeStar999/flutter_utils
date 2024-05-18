import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'base_controller.dart';
import 'network_status_manager.dart';
import 'network_type.dart';

mixin NetworkMixin on BaseController {
  List<NetworkType> get networkType => _statusManager.networkType;

  final NetworkStatusManager _statusManager = NetworkStatusManager();
  StreamSubscription<List<NetworkType>>? _subscription;

  @mustCallSuper
  @override
  void onPageInit() {
    super.onPageInit();
    _statusManager.listenNetwork();
    _subscription = _statusManager.stream.listen((event) {
      networkStatusChanged(event);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void networkStatusChanged(List<NetworkType> networkType) {}

  @protected
  Future<bool> checkConnection(String host) async {
    try {
      final result = await InternetAddress.lookup(host);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
