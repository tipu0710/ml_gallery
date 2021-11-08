import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/view/home.dart';
import 'package:ml_gallery/utils/hero_route.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      goTo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Hero(
        tag: "logo",
        child: Center(
          child: RiveAnimation.asset('assets/anim/ml_gallery.riv'),
        ),
      ),
    );
  }

  void goTo() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(
        context,
        HeroRoute(
          builder: (_) => const Home(),
        ),
        (route) => false);
  }
}
