import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String updated;

  const ProjectCard({super.key, required this.image, required this.title, required this.updated});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                    const Icon(Icons.more_vert, color: Colors.white, size: 18),
                  ],
                ),
                const SizedBox(height: 4),
                Text(updated, style: const TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                  child: const Text('AR Scene', style: TextStyle(color: AppColors.accent, fontSize: 11)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}