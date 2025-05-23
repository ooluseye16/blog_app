import 'package:blog_app/components/widgets/buttons.dart';
import 'package:blog_app/data/models/post.dart';
import 'package:blog_app/data/providers/user_provider.dart';
import 'package:blog_app/screens/authentication/login.dart';
import 'package:blog_app/screens/authentication/sign_up.dart';
import 'package:blog_app/screens/home/widgets/blog_card.dart';
import 'package:blog_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeTabletLayout extends StatefulWidget {
  const HomeTabletLayout({super.key, required this.posts});

  final List<Post> posts;

  @override
  State<HomeTabletLayout> createState() => _HomeTabletLayoutState();
}

class _HomeTabletLayoutState extends State<HomeTabletLayout> {
  final scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        _showScrollToTop = scrollController.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(80), // Slightly smaller height for tablet
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 12), // Reduced padding
          child: Row(
            children: [
              Text(
                'Blog App',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20, // Slightly smaller font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Consumer(
                builder: (context, ref, child) {
                  final userData = ref.watch(userProvider);
                  return userData.when(data: (user) {
                    if (user != null) {
                      return Row(
                        children: [
                          AppDefaultButton(
                              text: "My posts",
                              onPressed: () {
                                   context.go("/my-posts");
                                // Implement my posts logic
                              }),
                          16.width,
                          AppOutlinedButton(
                              text: "Create new post",
                              onPressed: () {
                                   context.go("/create");
                                // Implement create post logic
                              }),
                          16.width,
                          CircleAvatar(
                            radius: 20,
                            child: Text(
                                //first two letters of the username
                                user.username.substring(0, 2).toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          AppDefaultButton(
                              text: "Sign up",
                              onPressed: () {
                                showAdaptiveDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return Dialog(
                                        child: SignUpDialog(),
                                      );
                                    });
                              }),
                          SizedBox(width: 8),
                          AppOutlinedButton(
                              text: "Login",
                              onPressed: () {
                                showAdaptiveDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return Dialog(
                                        child: LoginDialog(),
                                      );
                                    });
                              }),
                        ],
                      );
                    }
                  }, error: (e, st) {
                    return SizedBox();
                  }, loading: () {
                    return SizedBox();
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
            controller: scrollController,
            itemCount: widget.posts.length,
            itemBuilder: (context, index) {
              final post = widget.posts[index];
              return BlogCard(post: post);
            }),
      ),
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton.small(
              onPressed: _scrollToTop,
              shape: CircleBorder(),
              child: const Icon(Icons.keyboard_double_arrow_up),
            )
          : null,
    );
  }
}
