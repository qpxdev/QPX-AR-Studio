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

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Row(
            children: [
              Icon(Icons.workspace_premium, color: Colors.amber, size: 24),
              SizedBox(width: 8),
              Text('Upgrade to Professional', style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Unlock everything you need to create immersive AR experiences:', style: TextStyle(color: Colors.white70, fontSize: 13)),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.green, size: 16),
                  SizedBox(width: 8),
                  Text('Unlimited AR projects', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.green, size: 16),
                  SizedBox(width: 8),
                  Text('50 GB Cloud Storage (currently 12 GB)', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.green, size: 16),
                  SizedBox(width: 8),
                  Text('Premium GLTF/USDZ templates', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Maybe Later', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Successfully upgraded to Professional Plan! 🎉')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700),
              child: const Text('Upgrade Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

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
              onPressed: () => _showUpgradeDialog(context),
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
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 16,
        left: isCompact ? 8 : 16,
        right: isCompact ? 8 : 16,
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
                    if (!isCompact && !isSmallHeight) 
                      _upgradeCard(context)
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Tooltip(
                          message: 'Upgrade Plan',
                          child: InkWell(
                            onTap: () => _showUpgradeDialog(context),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.amber.shade700, width: 1),
                              ),
                              child: const Icon(Icons.workspace_premium, color: Colors.amber, size: 22),
                            ),
                          ),
                        ),
                      ),
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
