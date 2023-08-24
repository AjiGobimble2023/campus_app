import 'package:campus_app/core.dart';
import 'package:campus_app/feature/topicDiscus/model/topic_discus.dart';
import 'package:flutter/material.dart';

class DiscussionTopicPage extends StatelessWidget {
  final DiscussionTopicModel topic;

  const DiscussionTopicPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'DISCUSSION',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: AppFontWeight.semibold,
                    color: AppColors.blue500,
                  ),
                ),
                Text(
                  'TOPICS',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: AppFontWeight.semibold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(topic.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'by  ${topic.author['full_name']}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.grey500
              ),
            ),
            const SizedBox(height: 16),
            Text(
              topic.content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}