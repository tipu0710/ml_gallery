import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/ui_helper/connectivity_status/connection_toast.dart';

class ConnectionAnimTost extends StatelessWidget {
  final double value;
  final ConnectionStatus connectionStatus;

  static final Tween<Offset> tweenOffset = Tween<Offset>(begin: const Offset(0, 40), end: const Offset(0, 0));

  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  const ConnectionAnimTost({Key? key, required this.value, required this.connectionStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: tweenOffset.transform(value),
      child: Opacity(
        child: ConnectionToast(connectionStatus: connectionStatus,),
        opacity: tweenOpacity.transform(value),
      ),
    );
  }
}