import 'package:flutter/material.dart';
import 'widgets/left_panel.dart';
import 'widgets/signup_form.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF090909),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5722),
          brightness: Brightness.dark,
        ),
      ),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090909),
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool desktop = constraints.maxWidth >= 950;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: desktop
                    ? 1500
                    : constraints.maxWidth * 0.95,
                height: desktop
                    ? 760
                    : constraints.maxHeight * 0.95,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: const Color(0xFFFF5722),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5722).withValues(alpha: 0.20),
                      blurRadius: 35,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: desktop
                      ? const Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: LeftPanel(),
                            ),
                            Expanded(
                              flex: 4,
                              child: SignupForm(),
                            ),
                          ],
                        )
                      : const Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: LeftPanel(),
                            ),
                            Expanded(
                              flex: 6,
                              child: SignupForm(),
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}