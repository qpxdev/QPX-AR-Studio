import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onNewProject;

  const TopBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onNewProject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
            ],
          ),
        ),

        // Notification bell — now functional
        PopupMenuButton<String>(
          offset: const Offset(0, 40),
          color: const Color(0xFF1C1C1C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (context) => [
            _notificationItem("Human Heart 3D", "Comment added by Alex", "2m ago"),
            _notificationItem("Dinosaur World AR", "Project published", "1h ago"),
            _notificationItem("Product Viewer AR", "New collaborator joined", "3h ago"),
          ],
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 24),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Color(0xFFE56A15), shape: BoxShape.circle),
                  child: const Text("3", style: TextStyle(fontSize: 9, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 20),

        // Profile dropdown — now functional
        PopupMenuButton<String>(
          offset: const Offset(0, 45),
          color: const Color(0xFF1C1C1C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onSelected: (value) {
            if (value == 'logout') {
              // Hook up your actual logout/navigation logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out")),
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
                children: [
                  const Text("Varun K", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                  Text("Developer", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
            ],
          ),
        ),

        const SizedBox(width: 24),

        ElevatedButton.icon(
          onPressed: onNewProject ?? () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text("New Project"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE56A15),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

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

  PopupMenuItem<String> _notificationItem(String title, String subtitle, String time) {
    return PopupMenuItem(
      value: title,
      child: SizedBox(
        width: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
            const SizedBox(height: 2),
            Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
          ],
        ),
      ),
    );
  }
}