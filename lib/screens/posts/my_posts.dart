import 'package:blog_app/data/providers/post_provider.dart';
import 'package:blog_app/screens/home/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPostsScreen extends ConsumerWidget {
  const MyPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPostsData = ref.watch(usersPostsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Posts'),
      ),
      body: userPostsData.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return BlogCard(post: post);
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}