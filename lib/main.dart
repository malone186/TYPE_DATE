import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/theme.dart';
import 'screens/splash_title_screen.dart';

void main() {
  runApp(const ProviderScope(child: TypeDateApp()));
}

class TypeDateApp extends StatelessWidget {
  const TypeDateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TYPE DATE — 데모',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: buildLightTheme(),
      home: const SplashTitleScreen(),
    );
  }
}
