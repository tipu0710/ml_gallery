import 'package:flutter/material.dart';
import 'package:ml_gallery/service/providers/photo_model_providers.dart';
import 'package:ml_gallery/ui/splash_screen/splash_screen.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PhotoModelProviders>(
      create: (_) => PhotoModelProviders(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Gallery',
      theme: ThemeData(
        primarySwatch: kPrimarySwatch,
        scaffoldBackgroundColor: scaffoldColor,
      ),
      home: const SplashScreen(),
    );
  }
}
