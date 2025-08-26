import 'package:flutter/material.dart';
import 'core/flavor_manager.dart';
import 'features/demo/env_demo_page.dart';

void main() {
  // Initialize flavor configuration
  FlavorManager.initializeFlavor();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Envied Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EnvDemoPage(),
    );
  }
}
