import 'package:chat_hive/core/theme/theme_provider.dart';
import 'package:chat_hive/firebase_options.dart';
import 'package:chat_hive/presentation/screens/setting_section/settings.dart';
import 'package:chat_hive/service/auth_gate.dart';
import 'package:chat_hive/presentation/screens/home/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,

      routes: {
        '/homescreen': (context) => HomeScreen(),
        '/settingsscreen': (context) => SettingsScreen(),
      },
    );
  }
}
