import 'package:flutter/material.dart';
import '../../models/project_model.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProjectModel> projects = ProjectModel.dummyList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Projects",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  int crossAxisCount = 4;
                  if (width < 600) {
                    crossAxisCount = 1;
                  } else if (width < 900) {
                    crossAxisCount = 2;
                  } else if (width < 1200) {
                    crossAxisCount = 3;
                  } else {
                    crossAxisCount = 4;
                  }

                  return GridView.builder(
                    itemCount: projects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 260,
                    ),
                    itemBuilder: (context, index) {
                      return ProjectCard(project: projects[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
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