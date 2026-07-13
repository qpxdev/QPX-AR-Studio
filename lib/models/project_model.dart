import 'package:flutter/material.dart';

enum ProjectStatus { published, inProgress, draft }

class ProjectModel {
  final String title;
  final String category;
  final String imageUrl;
  final ProjectStatus status;
  final int views;
  final int collaborators;

  const ProjectModel({
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.status,
    required this.views,
    required this.collaborators,
  });

  String get statusLabel {
    switch (status) {
      case ProjectStatus.published:
        return "Published";
      case ProjectStatus.inProgress:
        return "In Progress";
      case ProjectStatus.draft:
        return "Draft";
    }
  }

  Color get statusColor {
    switch (status) {
      case ProjectStatus.published:
        return const Color(0xFF22C55E);
      case ProjectStatus.inProgress:
        return const Color(0xFF3B82F6);
      case ProjectStatus.draft:
        return const Color(0xFFA855F7);
    }
  }

  static List<ProjectModel> dummyList() {
    return const [
      ProjectModel(
        title: 'AR Furniture Showcase',
        category: 'Interior Design',
        imageUrl: 'https://example.com/images/furniture.png',
        status: ProjectStatus.published,
        views: 1240,
        collaborators: 5,
      ),
      ProjectModel(
        title: 'Virtual Art Gallery',
        category: 'Art',
        imageUrl: 'https://example.com/images/gallery.png',
        status: ProjectStatus.inProgress,
        views: 870,
        collaborators: 3,
      ),
      ProjectModel(
        title: 'Prototype AR Game',
        category: 'Gaming',
        imageUrl: 'https://example.com/images/game.png',
        status: ProjectStatus.draft,
        views: 430,
        collaborators: 2,
      ),
    ];
  }
}