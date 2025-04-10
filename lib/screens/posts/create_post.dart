import 'dart:developer';

import 'package:blog_app/components/widgets/buttons.dart';
import 'package:blog_app/data/providers/post_provider.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
  XFile? _selectedImage;
  bool _isLoading = false;

  // Image Picker Function
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = pickedFile);
    }
  }

  // Publish Post
  void _publishPost() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null) {
      showAppSnackBar(context, message: "Please select an image");
      return;
    }

    setState(() => _isLoading = true);

    final result = await ref.read(postRepositoryProvider).createPost(
        _titleController.text, _contentController.text,
        image: _selectedImage);

    if (result.$1) {
      setState(() => _isLoading = false);
      ref.invalidate(postsProvider);
      ref.invalidate(usersPostsProvider);
      if (mounted) {
        showAppSnackBar(context, message: "Post created successfully");
        context.go("/");
      }
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        showAppSnackBar(context,
            message: result.$2 ?? "An error occurred",
            type: SnackBarType.error);
      }
      log(result.$2 ?? "An error occurred");
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
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.go("/"),
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text("Create a New Blog Post")),
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

                  // Image Upload
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: isDesktop
                          ? 300
                          : isTablet
                              ? 200
                              : 200,
                      width: isDesktop
                          ? 600
                          : isTablet
                              ? 400
                              : double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _selectedImage == null
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                  SizedBox(height: 5),
                                  Text("Tap to add an image"),
                                ],
                              ),
                            )
                          : Image.network(
                              _selectedImage!.path,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Publish Button
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
