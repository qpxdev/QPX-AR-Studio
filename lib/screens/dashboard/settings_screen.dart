import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(backgroundColor: AppColors.panel, title: const Text('Settings')),
      body: const Center(child: Text('Settings coming soon', style: TextStyle(color: Colors.white))),
    );
  }
}