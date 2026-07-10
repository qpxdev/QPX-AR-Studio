import 'package:flutter/material.dart';

import '../../widgets/login widgets/left_panel.dart';
import '../../widgets/login widgets/right_panel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isDesktop = constraints.maxWidth > 900;
            final bool isMobilePortrait = constraints.maxWidth <= 600;
            final bool isMobileLandscape = constraints.maxHeight <= 450;
            final bool isMobile = isMobilePortrait || isMobileLandscape;

            final double cardHeight = isDesktop
                ? 700
                : isMobile
                    ? constraints.maxHeight
                    : constraints.maxHeight * 0.95;

            final double cardWidth = isDesktop
                ? 1200
                : isMobile
                    ? constraints.maxWidth
                    : constraints.maxWidth * 0.95;

            final double borderRadius = isMobile ? 0 : 30;

            return Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(borderRadius),
                border: isMobile
                    ? null
                    : Border.all(
                        color: const Color(0xFFFF5722),
                        width: 1.5,
                      ),
                boxShadow: isMobile
                    ? null
                    : [
                        BoxShadow(
                          color: const Color(0xFFFF5722).withAlpha(64),
                          blurRadius: 35,
                          spreadRadius: 2,
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!isMobilePortrait)
                      const Expanded(
                        flex: 5,
                        child: LeftPanel(),
                      ),
                    Expanded(
                      flex: isMobilePortrait ? 1 : 4,
                      child: const RightPanel(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
