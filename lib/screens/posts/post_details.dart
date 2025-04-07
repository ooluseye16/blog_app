import 'package:blog_app/data/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailsScreen extends ConsumerWidget {
  const PostDetailsScreen({
    super.key,
    required this.postId,
  });
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postData = ref.watch(postByIdProvider(postId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: postData.when(
        data: (post) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    post.content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
