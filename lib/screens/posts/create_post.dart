import 'dart:developer';

import 'package:blog_app/components/widgets/buttons.dart';
import 'package:blog_app/data/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateNewPostScreen extends ConsumerStatefulWidget {
  const CreateNewPostScreen({super.key});

  @override
  ConsumerState<CreateNewPostScreen> createState() =>
      _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends ConsumerState<CreateNewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  //final String _selectedCategory = "Technology";
  // File? _selectedImage;
  bool _isLoading = false;

  // final List<String> _categories = [
  //   "Technology",
  //   "Lifestyle",
  //   "Travel",
  //   "Education",
  //   "Health",
  //   "Business"
  // ];

  // // Image Picker Function
  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() => _selectedImage = File(pickedFile.path));
  //   }
  // }

  // Publish Post
  void _publishPost() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final result = await ref
        .read(postRepositoryProvider)
        .createPost(_titleController.text, _contentController.text);

    if (result.$1) {
      setState(() => _isLoading = false);
      ref.invalidate(postsProvider);
      if (mounted) {
        context.pop();
      }
    } else {
      setState(() => _isLoading = false);
      log(result.$2 ?? "An error occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 900;
        bool isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;

        return Scaffold(
          appBar: AppBar(title: Text("Create a New Blog Post")),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? 200
                  : isTablet
                      ? 80
                      : 16,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog Title
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Blog Title",
                      labelStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Title is required" : null,
                  ),
                  SizedBox(height: 20),

                  // Rich Content Input
                  TextFormField(
                    controller: _contentController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Write your blog content here...",
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Content cannot be empty" : null,
                  ),
                  SizedBox(height: 20),

                  // // Image Upload
                  // GestureDetector(
                  //   onTap: _pickImage,
                  //   child: Container(
                  //     height: 180,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(10),
                  //       image: _selectedImage != null
                  //           ? DecorationImage(
                  //               image: FileImage(_selectedImage!),
                  //               fit: BoxFit.cover,
                  //             )
                  //           : null,
                  //     ),
                  //     child: _selectedImage == null
                  //         ? Center(
                  //             child: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 Icon(Icons.image, size: 50, color: Colors.grey),
                  //                 SizedBox(height: 5),
                  //                 Text("Tap to add an image"),
                  //               ],
                  //             ),
                  //           )
                  //         : null,
                  //   ),
                  // ),
                  // SizedBox(height: 30),

                  // Publish & Save Draft Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppDefaultButton.small(
                        onPressed: _publishPost,
                        isLoading: _isLoading,
                        text: "Publish",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
