import 'package:flutter/material.dart';

class LeftPanel extends StatelessWidget {
  final double? height;
  final BoxFit fit;

  const LeftPanel({
    super.key,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Image.asset(
        "lib/assets/images/mockup.jpeg",
        fit: fit,
      ),
    );
  }
}