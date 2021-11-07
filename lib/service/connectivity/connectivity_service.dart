import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/ui_helper/connectivity_status/connection_anim.dart';
import 'package:ml_gallery/ui/ui_helper/connectivity_status/connection_toast.dart';
import 'package:overlay_support/overlay_support.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult _connectivityResult;

  ConnectivityService._() {
    _start();
  }

  factory ConnectivityService.start() {
    return ConnectivityService._();
  }

  void _start() async {
    _connectivityResult = await _connectivity.checkConnectivity();
    if (_connectivityResult == ConnectivityResult.none) {
      _showMessage(ConnectionStatus.offline);
    }
    _connectivity.onConnectivityChanged.listen((event) {
      if (_connectivityResult == ConnectivityResult.none &&
          (event == ConnectivityResult.wifi ||
              event == ConnectivityResult.mobile)) {
        _showMessage(ConnectionStatus.backOnline);
        _connectivityResult = event;
      } else if ((_connectivityResult == ConnectivityResult.wifi ||
              _connectivityResult == ConnectivityResult.mobile) &&
          event == ConnectivityResult.none) {
        _showMessage(ConnectionStatus.offline);
        _connectivityResult = event;
      }
    });
  }

  _showMessage(ConnectionStatus connectionStatus) {
    showOverlay((context, t) {
      return ConnectionAnimTost(
        value: t,
        connectionStatus: connectionStatus,
      );
    }, key: const ValueKey("connection"), curve: Curves.decelerate);
  }
}
