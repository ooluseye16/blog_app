import 'package:blog_app/data/providers/post_provider.dart';
import 'package:blog_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostDetailsScreen extends ConsumerWidget {
  const PostDetailsScreen({
    super.key,
    required this.postId,
    this.from,
  });
  final String postId;
  final String? from;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postData = ref.watch(postByIdProvider(postId));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (from == 'my_posts') {
                context.go('/my-posts');
              } else {
                context.go('/posts');
              }
            },
            icon: Icon(Icons.arrow_back)),
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
                  post.image.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height / 2.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                post.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            16.height,
                          ],
                        )
                      : Offstage(),
                  Text(post.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text(post.content,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
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
