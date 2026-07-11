import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class UpgradePlanScreen extends StatelessWidget {
  const UpgradePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(backgroundColor: AppColors.panel, title: const Text('Upgrade Plan')),
      body: const Center(
        child: Text('Pricing plans coming soon', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}