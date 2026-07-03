import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/theme.dart';
import 'state/game_state.dart';
import 'screens/splash_title_screen.dart';

void main() {
  runApp(const ProviderScope(child: TypeDateApp()));
}

class TypeDateApp extends ConsumerWidget {
  const TypeDateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'TYPE DATE — 데모',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const SplashTitleScreen(),
    );
  }
}
