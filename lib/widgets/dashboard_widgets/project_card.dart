import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String updated;

  const ProjectCard({super.key, required this.image, required this.title, required this.updated});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallCard = screenWidth <= 900;

    return Container(
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 7,
            child: Image.network(image, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(isSmallCard ? 6 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title, 
                              style: TextStyle(
                                color: Colors.white, 
                                fontWeight: FontWeight.w600, 
                                fontSize: isSmallCard ? 11 : 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.more_vert, color: Colors.white, size: isSmallCard ? 14 : 18),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        updated, 
                        style: TextStyle(color: Colors.white70, fontSize: isSmallCard ? 9 : 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15), 
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'AR Scene', 
                      style: TextStyle(
                        color: AppColors.accent, 
                        fontSize: isSmallCard ? 8 : 10, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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