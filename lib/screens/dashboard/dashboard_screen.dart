import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/dashboard_widgets/sidebar.dart';
import '../../widgets/dashboard_widgets/top_bar.dart';
import '../../widgets/dashboard_widgets/stat_card.dart';
import '../../widgets/dashboard_widgets/project_card.dart';
import '../../widgets/dashboard_widgets/quick_action_card.dart';
import '../login/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool? _isSidebarExpanded;
  String _searchQuery = '';
  int _notificationCount = 3;

  final List<Map<String, String>> _projects = [
    {
      'image': 'https://picsum.photos/seed/1/400/250',
      'title': 'Interactive Product Demo',
      'updated': 'Updated 2 hours ago'
    },
    {
      'image': 'https://picsum.photos/seed/2/400/250',
      'title': 'Furniture Visualizer',
      'updated': 'Updated yesterday'
    },
    {
      'image': 'https://picsum.photos/seed/3/400/250',
      'title': 'Engine Exploded View',
      'updated': 'Updated 3 days ago'
    },
    {
      'image': 'https://picsum.photos/seed/4/400/250',
      'title': 'Solar System AR',
      'updated': 'Updated 5 days ago'
    },
  ];

  List<Map<String, String>> get _filteredProjects {
    if (_searchQuery.isEmpty) return _projects;
    return _projects
        .where((project) => project['title']!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _showNewProjectDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    String projectType = 'AR Scene';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.card,
              title: const Text('Create New Project', style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Project Name', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter project name...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFF222222),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Template Type', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: projectType,
                          dropdownColor: AppColors.card,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(value: 'AR Scene', child: Text('AR Scene')),
                            DropdownMenuItem(value: 'Image Target', child: Text('Image Target')),
                            DropdownMenuItem(value: '3D Model', child: Text('3D Model')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setDialogState(() {
                                projectType = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      setState(() {
                        _projects.insert(0, {
                          'image': 'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/400/250',
                          'title': name,
                          'updated': 'Updated just now'
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Project "$name" created successfully!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                  child: const Text('Create', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    bool cloudSync = true;
    bool devMode = false;
    bool analytics = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.card,
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      title: const Text('Cloud Sync', style: TextStyle(color: Colors.white, fontSize: 14)),
                      subtitle: const Text('Automatically sync projects to cloud', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      value: cloudSync,
                      activeThumbColor: AppColors.accent,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) {
                        setDialogState(() {
                          cloudSync = val;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Developer Mode', style: TextStyle(color: Colors.white, fontSize: 14)),
                      subtitle: const Text('Enable advanced AR debugging tools', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      value: devMode,
                      activeThumbColor: AppColors.accent,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) {
                        setDialogState(() {
                          devMode = val;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Usage Analytics', style: TextStyle(color: Colors.white, fontSize: 14)),
                      subtitle: const Text('Help us improve QPX AR Studio', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      value: analytics,
                      activeThumbColor: AppColors.accent,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) {
                        setDialogState(() {
                          analytics = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    List<Map<String, String>> notifications = [
      {'title': 'Cloud Sync Success', 'body': 'Project "Furniture Visualizer" synced to cloud.', 'time': '5m ago'},
      {'title': 'SDK Update Available', 'body': 'QPX AR SDK v2.1.0 is now available.', 'time': '1h ago'},
      {'title': 'Welcome to QPX', 'body': 'Start creating your AR experiences.', 'time': '1d ago'},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.card,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notifications', style: TextStyle(color: Colors.white)),
                  if (notifications.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        setDialogState(() {
                          notifications.clear();
                        });
                        setState(() {
                          _notificationCount = 0;
                        });
                      },
                      child: const Text('Clear All', style: TextStyle(color: AppColors.accent, fontSize: 12)),
                    ),
                ],
              ),
              content: SingleChildScrollView(
                child: notifications.isEmpty
                    ? const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text('No new notifications', style: TextStyle(color: Colors.grey)),
                        ),
                      )
                    : SizedBox(
                        width: 320,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: notifications.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                      Text(item['time']!, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(item['body']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  const Divider(color: Color(0xFF27272A)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
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
                Text('Varun', style: TextStyle(color: Colors.white, fontSize: isSmallHeight ? 15 : 18, fontWeight: FontWeight.bold)),
                Text('varun@qpxarstudio.com', style: TextStyle(color: Colors.grey, fontSize: isSmallHeight ? 10 : 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
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

  Widget _buildRecentProjectsGrid() {
    final filtered = _filteredProjects;

    if (filtered.isEmpty) {
      return Container(
        height: 150,
        alignment: Alignment.center,
        child: const Text(
          'No projects match your search',
          style: TextStyle(color: AppColors.textGrey, fontSize: 14),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = MediaQuery.of(context).size.width;
        final int crossAxisCount = screenWidth > 600 ? 3 : 2;
        final double childAspectRatio = screenWidth > 900 ? 0.95 : 1.0;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
          children: filtered.map((project) {
            return ProjectCard(
              image: project['image']!,
              title: project['title']!,
              updated: project['updated']!,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildQuickActionsList(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "New Project" button relocated to the very top of Quick Actions panel
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _showNewProjectDialog(context),
            icon: Icon(Icons.add, color: Colors.white, size: isMobile ? 14 : 18),
            label: Text(
              'New Project', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isMobile ? 11 : 13),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              padding: EdgeInsets.symmetric(vertical: isMobile ? 10 : 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const QuickActionCard(icon: Icons.view_in_ar, title: 'Create AR Scene', subtitle: 'Start a new AR experience', iconColor: AppColors.accent),
        const SizedBox(height: 10),
        const QuickActionCard(icon: Icons.image, title: 'Add Image Target', subtitle: 'Upload or create target', iconColor: Colors.blueAccent),
        const SizedBox(height: 10),
        const QuickActionCard(icon: Icons.view_in_ar_outlined, title: 'Import 3D Model', subtitle: 'Import GLB, GLTF, USDZ', iconColor: AppColors.green),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobileWidth = MediaQuery.of(context).size.width <= 750;
    final bool isTabletWidth = MediaQuery.of(context).size.width > 750 && MediaQuery.of(context).size.width <= 1100;
    
    // Set default value based on screen width on first build
    _isSidebarExpanded ??= MediaQuery.of(context).size.width > 900;

    final double statCardWidth = isMobileWidth ? 180 : (isTabletWidth ? 220 : 280);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(
            isCompact: !_isSidebarExpanded!,
            onToggleExpanded: () {
              setState(() {
                _isSidebarExpanded = !_isSidebarExpanded!;
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).padding.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    onSearchChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                    notificationCount: _notificationCount,
                    onNotificationsTap: () => _showNotificationsDialog(context),
                    onSettingsTap: () => _showSettingsDialog(context),
                    onProfileTap: () => _showProfileDialog(context),
                  ),
                  const SizedBox(height: 24),
                  
                  // Stat cards rendered horizontally in horizontal scroll view on narrow viewports
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: statCardWidth,
                          child: const StatCard(icon: Icons.folder, label: 'Total Projects', value: '24', change: '12%', iconColor: AppColors.accent),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: statCardWidth,
                          child: const StatCard(icon: Icons.view_in_ar, label: 'AR Scenes', value: '58', change: '18%', iconColor: Colors.blueAccent),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: statCardWidth,
                          child: const StatCard(icon: Icons.qr_code_scanner, label: 'Image Targets', value: '36', change: '8%', iconColor: AppColors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Main panels displayed side-by-side on all screens
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isMobileWidth ? 2 : 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Recent Projects', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text('View all', style: TextStyle(color: AppColors.accent, fontSize: 14)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildRecentProjectsGrid(),
                          ],
                        ),
                      ),
                      SizedBox(width: isMobileWidth ? 12 : 24),
                      Expanded(
                        flex: isMobileWidth ? 1 : 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Quick Actions', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            _buildQuickActionsList(isMobileWidth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}