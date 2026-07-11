import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String change;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.change,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width <= 900;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 18),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 6 : 12),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: isSmallScreen ? 18 : 24),
          ),
          SizedBox(width: isSmallScreen ? 6 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label, 
                  style: TextStyle(color: AppColors.textGrey, fontSize: isSmallScreen ? 10 : 13),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value, 
                  style: TextStyle(color: Colors.white, fontSize: isSmallScreen ? 16 : 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}