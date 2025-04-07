import 'package:blog_app/components/widgets/buttons.dart';
import 'package:blog_app/data/models/post.dart';
import 'package:blog_app/data/providers/user_provider.dart';
import 'package:blog_app/screens/authentication/login.dart';
import 'package:blog_app/screens/authentication/sign_up.dart';
import 'package:blog_app/screens/home/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeDesktopLayout extends StatefulWidget {
  const HomeDesktopLayout({super.key, required this.posts});
  final List<Post> posts;

  @override
  State<HomeDesktopLayout> createState() => _HomeDesktopLayoutState();
}

class _HomeDesktopLayoutState extends State<HomeDesktopLayout> {
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
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Row(
            children: [
              Text(
                'Blog App',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
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
                          AppOutlinedButton(
                            text: "My Posts",
                            onPressed: () {
                              context.push("/my-posts");
                            },
                          ),
                          SizedBox(width: 16),
                          AppOutlinedButton(
                            text: "Create new post",
                            onPressed: () {
                              context.push("/create");
                            },
                          ),
                          SizedBox(width: 16),
                          CircleAvatar(
                            radius: 20,
                            child: Text(
                              user.username.substring(0, 2).toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                },
                              );
                            },
                          ),
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
                                },
                              );
                            },
                          ),
                        ],
                      );
                    }
                  }, error: (e, st) {
                    return SizedBox();
                  }, loading: () {
                    return SizedBox();
                  });
                },
              ),
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
          },
        ),
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
