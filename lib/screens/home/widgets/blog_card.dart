import 'dart:math';

import 'package:blog_app/data/models/post.dart';
import 'package:blog_app/data/models/user.dart';
import 'package:blog_app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BlogCard extends ConsumerStatefulWidget {
  final Post post;

  const BlogCard({super.key, required this.post});

  @override
  ConsumerState<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends ConsumerState<BlogCard> {
  late List<Color> gradientColors;

  @override
  void initState() {
    super.initState();
    gradientColors = _generateGradient();
  }

  static List<Color> _generateGradient() {
    final random = Random();
    final baseIndex = random.nextInt(Colors.primaries.length);
    final secondaryIndex = (baseIndex + 5) % Colors.primaries.length;
    return [
      Colors.primaries[baseIndex],
      Colors.primaries[secondaryIndex],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authorData = ref.watch(
      userByIdProvider(widget.post.author),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;
        bool isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 800;

        return InkWell(
          onTap: () {
            context.go(
              '/posts/${widget.post.id}',
            );
          },
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Placeholder
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: AnimatedBlogTitle(title: widget.post.title),
                        ),
                        // Content Section
                        Expanded(
                          child: Center(
                            child: _buildContentSection(authorData, widget.post,
                                padding: 20, titleSize: 22),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        // Image Placeholder
                        Container(
                          height: isTablet ? 200 : 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: AnimatedBlogTitle(title: widget.post.title),
                        ),
                        // Content Section
                        Padding(
                          padding: EdgeInsets.all(isTablet ? 18 : 14),
                          child: _buildContentSection(
                            authorData,
                            widget.post,
                            padding: isTablet ? 18 : 14,
                            titleSize: isTablet ? 20 : 18,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  // Reusable Content Section for Mobile & Desktop
  Widget _buildContentSection(AsyncValue<User?> authorData, Post post,
      {double padding = 16, double titleSize = 20}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            post.title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),

          // Description
          Text(
            post.content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 24),

          // Author & Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              authorData.when(
                data: (author) {
                  return Text(
                    "By ${author?.username ?? 'Unknown'}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  );
                },
                loading: () => Text('Loading'),
                error: (e, st) => Text("Error"),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(post.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedBlogTitle extends StatefulWidget {
  final String title;

  const AnimatedBlogTitle({super.key, required this.title});

  @override
  State<AnimatedBlogTitle> createState() => _AnimatedBlogTitleState();
}

class _AnimatedBlogTitleState extends State<AnimatedBlogTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800), // Adjust speed
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FittedBox(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
