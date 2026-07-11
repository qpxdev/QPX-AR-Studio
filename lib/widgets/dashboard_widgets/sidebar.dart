import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class Sidebar extends StatelessWidget {
  final bool isCompact;
  final VoidCallback onToggleExpanded;

  const Sidebar({
    super.key,
    required this.isCompact,
    required this.onToggleExpanded,
  });

  Widget _navItem(BuildContext context, {required IconData icon, required String label, required bool selected, required bool isCompact}) {
    return Material(
      color: selected ? AppColors.accent.withValues(alpha: 0.15) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: isCompact
          ? InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Icon(icon, color: selected ? AppColors.accent : AppColors.textGrey, size: 20),
              ),
            )
          : ListTile(
              onTap: () {},
              leading: Icon(icon, color: selected ? AppColors.accent : AppColors.textGrey, size: 20),
              title: Text(
                label, 
                style: TextStyle(
                  color: selected ? AppColors.accent : AppColors.textGrey,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              dense: true,
            ),
    );
  }

  Widget _upgradeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [Text('👑 '), Text('Upgrade Plan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]),
          const SizedBox(height: 8),
          const Text('Unlock premium features and cloud storage.', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upgrade plan coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent, 
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'Upgrade Now',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallHeight = MediaQuery.of(context).size.height <= 500;

    return Container(
      width: isCompact ? 70 : 240,
      color: AppColors.panel,
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 16,
        vertical: 16,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: isCompact ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white, size: 22),
                          onPressed: onToggleExpanded,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        if (!isCompact) ...[
                          const SizedBox(width: 12),
                          Image.asset('lib/assets/images/logo.jpeg', width: 28, height: 28),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('QPX', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              Text('AR STUDIO', style: TextStyle(color: AppColors.accent, fontSize: 9, letterSpacing: 1)),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 32),
                    _navItem(context, icon: Icons.dashboard, label: 'Dashboard', selected: true, isCompact: isCompact),
                    const SizedBox(height: 8),
                    _navItem(context, icon: Icons.folder, label: 'Projects', selected: false, isCompact: isCompact),
                    const Spacer(),
                    if (!isCompact && !isSmallHeight) _upgradeCard(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
