import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../widgets/dashboard_widgets/sidebar.dart';
import '../../widgets/project page/stat_card.dart';
import '../dashboard/dashboard_screen.dart';

// Matches the AspectRatio(16/10) used inside ProjectCard's image.
const double _kCardImageAspectRatio = 16 / 10;

// Height needed for everything below the image in ProjectCard:
// padding (12+12) + title (up to 2 lines) + gap + subtitle + gap + icon row + buffer.
const double _kCardTextBlockHeight = 130;

double _cardMainAxisExtent({
  required double gridWidth,
  required int crossAxisCount,
  required double crossAxisSpacing,
}) {
  final totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
  final cellWidth = (gridWidth - totalSpacing) / crossAxisCount;
  final imageHeight = cellWidth / _kCardImageAspectRatio;
  return imageHeight + _kCardTextBlockHeight;
}

class ProjectPageScreen extends StatefulWidget {
  const ProjectPageScreen({super.key});

  @override
  State<ProjectPageScreen> createState() => _ProjectPageScreenState();
}

class _ProjectPageScreenState extends State<ProjectPageScreen> {
  bool _isSidebarExpanded = true;
  int _selectedNav = 1;
  String _searchQuery = "";
  String _sortBy = "Recent";

  Set<ProjectStatus> _selectedStatuses = {};
  Set<String> _selectedCategories = {};

  final List<ProjectModel> _projects = [
    const ProjectModel(title: "Solar System AR", category: "Educational", imageUrl: "https://picsum.photos/seed/1/400/250", status: ProjectStatus.published, views: 245, collaborators: 12),
    const ProjectModel(title: "Human Heart 3D", category: "Medical", imageUrl: "https://picsum.photos/seed/2/400/250", status: ProjectStatus.inProgress, views: 128, collaborators: 8),
    const ProjectModel(title: "Architecture Visualizer", category: "Design", imageUrl: "https://picsum.photos/seed/3/400/250", status: ProjectStatus.draft, views: 78, collaborators: 5),
    const ProjectModel(title: "Dinosaur World AR", category: "Entertainment", imageUrl: "https://picsum.photos/seed/4/400/250", status: ProjectStatus.published, views: 532, collaborators: 23),
    const ProjectModel(title: "Engine AR Demo", category: "Industrial", imageUrl: "https://picsum.photos/seed/5/400/250", status: ProjectStatus.inProgress, views: 96, collaborators: 6),
    const ProjectModel(title: "Earth AR", category: "Educational", imageUrl: "https://picsum.photos/seed/6/400/250", status: ProjectStatus.draft, views: 61, collaborators: 4),
    const ProjectModel(title: "Product Viewer AR", category: "E-commerce", imageUrl: "https://picsum.photos/seed/7/400/250", status: ProjectStatus.published, views: 210, collaborators: 15),
    const ProjectModel(title: "Car Showroom AR", category: "Automotive", imageUrl: "https://picsum.photos/seed/8/400/250", status: ProjectStatus.inProgress, views: 174, collaborators: 10),
  ];

  List<String> get _allCategories =>
      _projects.map((p) => p.category).toSet().toList()..sort();

  List<ProjectModel> get _filteredProjects {
    return _projects.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(_searchQuery);
      final matchesStatus = _selectedStatuses.isEmpty || _selectedStatuses.contains(p.status);
      final matchesCategory = _selectedCategories.isEmpty || _selectedCategories.contains(p.category);
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  void _applySort() {
    switch (_sortBy) {
      case 'Name':
        _projects.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Most Viewed':
        _projects.sort((a, b) => b.views.compareTo(a.views));
        break;
      case 'Most Collaborators':
        _projects.sort((a, b) => b.collaborators.compareTo(a.collaborators));
        break;
      case 'Recent':
      default:
        break;
    }
  }

  int get _activeFilterCount => _selectedStatuses.length + _selectedCategories.length;

  Future<void> _openFilterDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => _FilterDialog(
        allCategories: _allCategories,
        initialStatuses: _selectedStatuses,
        initialCategories: _selectedCategories,
      ),
    );
    if (result != null) {
      setState(() {
        _selectedStatuses = result['statuses'] as Set<ProjectStatus>;
        _selectedCategories = result['categories'] as Set<String>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 760;
        return isMobile ? _buildMobile(context) : _buildDesktop(context);
      },
    );
  }

  // ---------------- MOBILE LAYOUT ----------------
  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      drawer: Drawer(
        backgroundColor: const Color(0xFF141414),
        child: SafeArea(
          child: Sidebar(
            selectedIndex: _selectedNav,
            isCompact: false,
            onToggleExpanded: () {},
            onSelect: (i) {
              if (i == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              } else {
                setState(() => _selectedNav = i);
                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Projects",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
              Positioned(
                right: 6,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Color(0xFFE56A15), shape: BoxShape.circle),
                  child: const Text("3", style: TextStyle(fontSize: 8, color: Colors.white)),
                ),
              ),
            ],
          ),
          const CircleAvatar(radius: 15, backgroundColor: Colors.orange),
          const SizedBox(width: 12),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE56A15),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, bodyConstraints) {
            // Available width inside the scroll padding (16 left + 16 right)
            final gridWidth = bodyConstraints.maxWidth - 32;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Manage all your AR projects in one place.",
                      style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                  const SizedBox(height: 18),

                  // Stat cards — 2 per row, compact
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: const [
                      StatCard(label: "Total Projects", value: "12", subtitle: "All Projects", icon: Icons.folder_outlined, iconColor: Color(0xFFE56A15)),
                      StatCard(label: "Published", value: "5", subtitle: "Live Projects", icon: Icons.check_circle_outline, iconColor: Color(0xFF22C55E)),
                      StatCard(label: "In Progress", value: "4", subtitle: "Active Work", icon: Icons.autorenew_rounded, iconColor: Color(0xFF3B82F6)),
                      StatCard(label: "Drafts", value: "3", subtitle: "Unpublished", icon: Icons.description_outlined, iconColor: Color(0xFFA855F7)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF2A2A2A)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[500], size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            decoration: InputDecoration(
                              hintText: "Search projects...",
                              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Filter + Sort row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _openFilterDialog,
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(Icons.filter_list, size: 16, color: Colors.white),
                              if (_activeFilterCount > 0)
                                Positioned(
                                  right: -6,
                                  top: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(color: Color(0xFFE56A15), shape: BoxShape.circle),
                                    child: Text("$_activeFilterCount", style: const TextStyle(fontSize: 8, color: Colors.white)),
                                  ),
                                ),
                            ],
                          ),
                          label: const Text("Filter", style: TextStyle(color: Colors.white, fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _activeFilterCount > 0 ? const Color(0xFFE56A15) : const Color(0xFF2A2A2A)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: PopupMenuButton<String>(
                          color: const Color(0xFF1C1C1C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          onSelected: (value) => setState(() {
                            _sortBy = value;
                            _applySort();
                          }),
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'Recent', child: Text("Recent", style: TextStyle(color: Colors.white))),
                            PopupMenuItem(value: 'Name', child: Text("Name (A–Z)", style: TextStyle(color: Colors.white))),
                            PopupMenuItem(value: 'Most Viewed', child: Text("Most Viewed", style: TextStyle(color: Colors.white))),
                            PopupMenuItem(value: 'Most Collaborators', child: Text("Most Collaborators", style: TextStyle(color: Colors.white))),
                          ],
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF2A2A2A)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(_sortBy,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                                ),
                                const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_activeFilterCount > 0) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        ..._selectedStatuses.map((s) => _filterChip(_statusLabel(s), () => setState(() => _selectedStatuses.remove(s)))),
                        ..._selectedCategories.map((c) => _filterChip(c, () => setState(() => _selectedCategories.remove(c)))),
                      ],
                    ),
                  ],

                  const SizedBox(height: 18),

                  // Project grid — always 3 columns on mobile
                  _filteredProjects.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: Text("No projects match your filters.",
                                style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredProjects.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: _cardMainAxisExtent(
                              gridWidth: gridWidth,
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                            ),
                          ),
                          itemBuilder: (context, index) => ProjectCard(project: _filteredProjects[index]),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------- DESKTOP LAYOUT ----------------
  Widget _buildDesktop(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Row(
        children: [
          Sidebar(
            selectedIndex: _selectedNav,
            isCompact: !_isSidebarExpanded,
            onToggleExpanded: () {
              setState(() {
                _isSidebarExpanded = !_isSidebarExpanded;
              });
            },
            onSelect: (i) {
              if (i == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              } else {
                setState(() => _selectedNav = i);
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Projects", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("Manage all your AR projects in one place.", style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                          ],
                        ),
                      ),
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
                      PopupMenuButton<String>(
                        offset: const Offset(0, 45),
                        color: const Color(0xFF1C1C1C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: (value) {
                          if (value == 'logout') {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged out")));
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
                        onPressed: () {},
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
                  ),
                  const SizedBox(height: 28),

                  const Row(
                    children: [
                      Expanded(child: StatCard(label: "Total Projects", value: "12", subtitle: "All Projects", icon: Icons.folder_outlined, iconColor: Color(0xFFE56A15))),
                      SizedBox(width: 16),
                      Expanded(child: StatCard(label: "Published", value: "5", subtitle: "Live Projects", icon: Icons.check_circle_outline, iconColor: Color(0xFF22C55E))),
                      SizedBox(width: 16),
                      Expanded(child: StatCard(label: "In Progress", value: "4", subtitle: "Active Work", icon: Icons.autorenew_rounded, iconColor: Color(0xFF3B82F6))),
                      SizedBox(width: 16),
                      Expanded(child: StatCard(label: "Drafts", value: "3", subtitle: "Unpublished", icon: Icons.description_outlined, iconColor: Color(0xFFA855F7))),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C1C),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF2A2A2A)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey[500], size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "Search projects...",
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: _openFilterDialog,
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.filter_list, size: 18, color: Colors.white),
                            if (_activeFilterCount > 0)
                              Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(color: Color(0xFFE56A15), shape: BoxShape.circle),
                                  child: Text("$_activeFilterCount", style: const TextStyle(fontSize: 9, color: Colors.white)),
                                ),
                              ),
                          ],
                        ),
                        label: const Text("Filter", style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: _activeFilterCount > 0 ? const Color(0xFFE56A15) : const Color(0xFF2A2A2A)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        ),
                      ),
                      const SizedBox(width: 12),
                      PopupMenuButton<String>(
                        offset: const Offset(0, 45),
                        color: const Color(0xFF1C1C1C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: (value) => setState(() {
                          _sortBy = value;
                          _applySort();
                        }),
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'Recent', child: Text("Recent", style: TextStyle(color: Colors.white))),
                          PopupMenuItem(value: 'Name', child: Text("Name (A–Z)", style: TextStyle(color: Colors.white))),
                          PopupMenuItem(value: 'Most Viewed', child: Text("Most Viewed", style: TextStyle(color: Colors.white))),
                          PopupMenuItem(value: 'Most Collaborators', child: Text("Most Collaborators", style: TextStyle(color: Colors.white))),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF2A2A2A)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Text("Sort by: ", style: TextStyle(color: Colors.grey)),
                              Text(_sortBy, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_activeFilterCount > 0) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._selectedStatuses.map((s) => _filterChip(_statusLabel(s), () => setState(() => _selectedStatuses.remove(s)))),
                        ..._selectedCategories.map((c) => _filterChip(c, () => setState(() => _selectedCategories.remove(c)))),
                        GestureDetector(
                          onTap: () => setState(() {
                            _selectedStatuses = {};
                            _selectedCategories = {};
                          }),
                          child: const Text("Clear all", style: TextStyle(color: Color(0xFFE56A15), fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 24),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int crossAxisCount;
                      if (width < 900) {
                        crossAxisCount = 3;
                      } else if (width < 1200) {
                        crossAxisCount = 3;
                      } else {
                        crossAxisCount = 4;
                      }

                      const spacing = 16.0;
                      final mainAxisExtent = _cardMainAxisExtent(
                        gridWidth: width,
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: spacing,
                      );

                      return _filteredProjects.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 60),
                              child: Center(
                                child: Text("No projects match your filters.", style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _filteredProjects.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                mainAxisExtent: mainAxisExtent,
                              ),
                              itemBuilder: (context, index) => ProjectCard(project: _filteredProjects[index]),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.published:
        return "Published";
      case ProjectStatus.inProgress:
        return "In Progress";
      case ProjectStatus.draft:
        return "Draft";
    }
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

  Widget _filterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE56A15).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE56A15).withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFE56A15), fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          GestureDetector(onTap: onRemove, child: const Icon(Icons.close_rounded, size: 14, color: Color(0xFFE56A15))),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  Color _statusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.published:
        return const Color(0xFF22C55E);
      case ProjectStatus.inProgress:
        return const Color(0xFF3B82F6);
      case ProjectStatus.draft:
        return const Color(0xFFA855F7);
    }
  }

  String _statusLabel(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.published:
        return "Published";
      case ProjectStatus.inProgress:
        return "In Progress";
      case ProjectStatus.draft:
        return "Draft";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(project.status);
    final statusText = _statusLabel(project.status);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(
              project.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.category.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFE56A15),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(38),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: statusColor.withAlpha(76)),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye_outlined, color: Colors.grey[500], size: 12),
                          const SizedBox(width: 4),
                          Text(
                            project.views.toString(),
                            style: TextStyle(color: Colors.grey[500], fontSize: 10),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.people_outline, color: Colors.grey[500], size: 12),
                          const SizedBox(width: 4),
                          Text(
                            project.collaborators.toString(),
                            style: TextStyle(color: Colors.grey[500], fontSize: 10),
                          ),
                        ],
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

// --- Filter Dialog ---
class _FilterDialog extends StatefulWidget {
  final List<String> allCategories;
  final Set<ProjectStatus> initialStatuses;
  final Set<String> initialCategories;

  const _FilterDialog({
    required this.allCategories,
    required this.initialStatuses,
    required this.initialCategories,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late Set<ProjectStatus> _statuses;
  late Set<String> _categories;

  @override
  void initState() {
    super.initState();
    _statuses = Set.from(widget.initialStatuses);
    _categories = Set.from(widget.initialCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1C1C1C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 380,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filter Projects", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              const Text("Status", style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ProjectStatus.values.map((status) {
                  final selected = _statuses.contains(status);
                  return _selectableChip(_statusLabel(status), selected, () => setState(() {
                    selected ? _statuses.remove(status) : _statuses.add(status);
                  }));
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text("Category", style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.allCategories.map((cat) {
                  final selected = _categories.contains(cat);
                  return _selectableChip(cat, selected, () => setState(() {
                    selected ? _categories.remove(cat) : _categories.add(cat);
                  }));
                }).toList(),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() {
                        _statuses = {};
                        _categories = {};
                      }),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF2A2A2A)), padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text("Reset", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, {'statuses': _statuses, 'categories': _categories}),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE56A15),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Apply Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.published:
        return "Published";
      case ProjectStatus.inProgress:
        return "In Progress";
      case ProjectStatus.draft:
        return "Draft";
    }
  }

  Widget _selectableChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE56A15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? const Color(0xFFE56A15) : const Color(0xFF3A3A3A)),
        ),
        child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.grey[400], fontSize: 12, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      ),
    );
  }
}