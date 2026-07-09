import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const QPXApp());
}

class QPXApp extends StatelessWidget {
  const QPXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QPX AR Studio',
      theme: ThemeData.dark(),
      home: const LoginScreen(),
    );
  }
}
