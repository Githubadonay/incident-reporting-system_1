import 'package:flutter/material.dart';
import 'core/routes.dart';
import 'core/theme.dart';

void main() {
  runApp(const SIRSApp());
}

class SIRSApp extends StatelessWidget {
  const SIRSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIRS',
      theme: appTheme,
      initialRoute: '/',
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}


