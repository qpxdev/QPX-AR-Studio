import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class TopBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final int notificationCount;
  final VoidCallback onNotificationsTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onProfileTap;

  const TopBar({
    super.key,
    required this.onSearchChanged,
    required this.notificationCount,
    required this.onNotificationsTap,
    required this.onSettingsTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Welcome back, ', style: TextStyle(color: AppColors.textGrey)),
              TextSpan(text: 'Varun! 👋', style: TextStyle(color: AppColors.accent)),
            ])),
          ],
        ),
        Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width <= 900 ? 150 : 280,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: onSearchChanged,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: AppColors.textGrey, size: 18),
                hintText: 'Search projects, assets...',
                hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width <= 900 ? 8 : 20),

          if (MediaQuery.of(context).size.width > 600) ...[
            IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.white, size: 20),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.card,
                    title: const Text('Help & Support', style: TextStyle(color: Colors.white)),
                    content: const Text('Need help? Contact support@qpxarstudio.com', style: TextStyle(color: AppColors.textGrey)),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
                  ),
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
              onPressed: onSettingsTap,
            ),
          ],

          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none, color: Colors.white),
                if (notificationCount > 0)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        notificationCount.toString(), 
                        style: const TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: onNotificationsTap,
          ),

          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.card,
              child: Icon(Icons.person, color: AppColors.textGrey, size: 20),
            ),
          ),
        ],
      ),
      ],
    );
  }
}