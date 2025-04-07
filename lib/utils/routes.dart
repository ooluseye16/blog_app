import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/posts/create_post.dart';
import 'package:blog_app/screens/posts/my_posts.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => CreateNewPostScreen(),
    ),
    GoRoute(
      path: '/my-posts',
      builder: (context, state) => MyPostsScreen(),
    ),
    // GoRoute(
    //   path: '/post/:id',
    //   builder: (context, state) {
    //     final postId = state.pathParameters['id'];
    //     return PostDetailsScreen(postId: postId!);
    //   },
    // ),
  ],
);
