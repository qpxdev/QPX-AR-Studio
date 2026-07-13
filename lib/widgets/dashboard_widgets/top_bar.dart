import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../screens/login/login_screen.dart';

class TopBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final int notificationCount;
  final VoidCallback onNotificationsTap;
  final VoidCallback onSettingsTap;

  const TopBar({
    super.key,
    required this.onSearchChanged,
    required this.notificationCount,
    required this.onNotificationsTap,
    required this.onSettingsTap,
  });

  PopupMenuItem<String> _menuItem(String value, IconData icon, String label, {Color? color}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color ?? Colors.grey[300]),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(color: color ?? Colors.white, fontSize: 13)),
        ],
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    final bool isSmallHeight = MediaQuery.of(context).size.height <= 500;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text('My Profile', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: isSmallHeight ? 24 : 36,
                  backgroundColor: AppColors.panel,
                  child: Icon(Icons.person, color: AppColors.accent, size: isSmallHeight ? 26 : 40),
                ),
                SizedBox(height: isSmallHeight ? 6 : 12),
                Text('Varun K', style: TextStyle(color: Colors.white, fontSize: isSmallHeight ? 15 : 18, fontWeight: FontWeight.bold)),
                Text('varun@qpxarstudio.com', style: TextStyle(color: Colors.grey, fontSize: isSmallHeight ? 10 : 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withAlpha(38),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.shade700, width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('👑 '),
                      Text('Professional Plan', style: TextStyle(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: isSmallHeight ? 10 : 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cloud Storage', style: TextStyle(color: Colors.white70, fontSize: isSmallHeight ? 10 : 12)),
                    Text('12.4 GB / 50 GB', style: TextStyle(color: Colors.grey, fontSize: isSmallHeight ? 9 : 11)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 12.4 / 50.0,
                    backgroundColor: Color(0xFF222222),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Logged out")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Log Out', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        );
      },
    );
  }

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
            const SizedBox(width: 8),

            PopupMenuButton<String>(
              offset: const Offset(0, 45),
              color: const Color(0xFF1C1C1C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onSelected: (value) {
                if (value == 'logout') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged out")),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else if (value == 'profile') {
                  _showProfileDialog(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${value[0].toUpperCase()}${value.substring(1)} coming soon")),
                  );
                }
              },
              itemBuilder: (context) => [
                _menuItem('profile', Icons.person_outline, "My Profile"),
                _menuItem('settings', Icons.settings_outlined, "Settings"),
                _menuItem('billing', Icons.credit_card_outlined, "Billing"),
                const PopupMenuDivider(),
                _menuItem('logout', Icons.logout_rounded, "Log Out", color: Colors.redAccent),
              ],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(radius: 18, backgroundColor: Colors.orange),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Varun K", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text("Developer", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                    ],
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}