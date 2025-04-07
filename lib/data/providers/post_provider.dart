import 'package:blog_app/data/models/post.dart';
import 'package:blog_app/data/services/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
PostService postRepository(Ref ref) {
  return PostService(ref);
}

@Riverpod(keepAlive: true)
Future<List<Post>> posts(Ref ref)  {
  final postService = ref.read(postRepositoryProvider);
  return  postService.getPosts();
}

@Riverpod(keepAlive: true)
Future<List<Post>> usersPosts(Ref ref) {
  final postService = ref.read(postRepositoryProvider);
  return postService.getUsersPosts();
}

@Riverpod(keepAlive: true)
Future<Post> postById(Ref ref, String id) {
  final postService = ref.read(postRepositoryProvider);
  return postService.getPostById(id);
}