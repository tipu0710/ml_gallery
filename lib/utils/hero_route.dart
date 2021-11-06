import 'package:flutter/material.dart';

class HeroRoute extends PageRoute<void> {
  HeroRoute({
    required this.builder,
    this.duration,
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;

  final Duration? duration;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration ?? const Duration(milliseconds: 700);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: result,
    );
  }
}
