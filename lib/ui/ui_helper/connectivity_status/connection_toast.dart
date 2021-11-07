import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';

enum ConnectionStatus { offline, backOnline }

class ConnectionToast extends StatelessWidget {
  final ConnectionStatus connectionStatus;
  const ConnectionToast({Key? key, required this.connectionStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: SafeArea(
        child: DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.black87,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        connectionStatus == ConnectionStatus.offline
                            ?Icons.wifi_tethering_error_rounded_outlined 
                            : CupertinoIcons.wifi,
                        color: Colors.white,
                      ),
                      MlText(
                        text: connectionStatus == ConnectionStatus.offline
                            ? "Offline"
                            : "Back online",
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
