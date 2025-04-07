import 'package:blog_app/components/responsive_layout.dart';
import 'package:blog_app/data/providers/post_provider.dart';
import 'package:blog_app/screens/home/desktop_layout.dart';
import 'package:blog_app/screens/home/mobile_layout.dart';
import 'package:blog_app/screens/home/tab_layout.dart';
import 'package:blog_app/screens/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postData = ref.watch(postsProvider);
    return postData.when(
      data: (posts) {
        return ResponsiveLayout(
          mobileBody: HomeMobileLayout(
            posts: posts,
          ),
          tabletBody: HomeTabletLayout(
            posts: posts,
          ),
          desktopBody: HomeDesktopLayout(
            posts: posts,
          ),
        );
      },
      error: (e, st) {
        return ErrorScreen(
          message: e as String,
          onRetry: () {
            ref.invalidate(postsProvider);
          },
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}
