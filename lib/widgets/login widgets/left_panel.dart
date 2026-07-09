import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        "lib/assets/images/mockup.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }
}