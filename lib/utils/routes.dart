import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/posts/create_post.dart';
import 'package:blog_app/screens/posts/my_posts.dart';
import 'package:blog_app/screens/posts/post_details.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // Redirect root path to '/posts'
    GoRoute(
      path: '/',
      redirect: (context, state) => '/posts',
    ),

    // Home Screen Route
    GoRoute(
        path: '/posts',
        builder: (context, state) => const HomeScreen(),
        routes: [
          // Post Details Route
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final postId = state.pathParameters['id']!;
              final from = state.uri.queryParameters['from'];
              return PostDetailsScreen(postId: postId, from: from);
            },
          ),
        ]),

    // Create New Post Route
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreateNewPostScreen(),
    ),

    // My Posts Route
    GoRoute(
      path: '/my-posts',
      builder: (context, state) => const MyPostsScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final postId = state.pathParameters['id']!;
            final from = state.uri.queryParameters['from'];
            return PostDetailsScreen(postId: postId, from: from);
          },
        ),
      ],
    ),
  ],
);
