import 'package:flutter/material.dart';
import '../../widgets/login widgets/left_panel.dart';
import '../../widgets/sign up widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isDesktop = constraints.maxWidth > 900;

              return Container(
                width: isDesktop ? 1200 : constraints.maxWidth * 0.95,
                height: isDesktop ? 700 : constraints.maxHeight * 0.95,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFFF5722),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5722).withValues(alpha: 0.25),
                      blurRadius: 35,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: isDesktop
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
                              flex: 4,
                              child: LeftPanel(),
                            ),
                            Expanded(
                              flex: 5,
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