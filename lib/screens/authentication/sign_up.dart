import 'dart:developer';

import 'package:blog_app/components/widgets/buttons.dart';
import 'package:blog_app/components/widgets/text_field.dart';
import 'package:blog_app/data/providers/auth_provider.dart';
import 'package:blog_app/data/providers/user_provider.dart';
import 'package:blog_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpDialog extends ConsumerStatefulWidget {
  const SignUpDialog({super.key});

  @override
  ConsumerState<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends ConsumerState<SignUpDialog> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth > 600 && screenWidth < 1024;
    final dialogWidth = isMobile || isTablet ? screenWidth : screenWidth * 0.4;

    return Container(
      width: dialogWidth,
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32, vertical: isMobile ? 24 : 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            (isMobile ? 16.0 : 24.0).height,
            AppTextField(hintText: "Username", controller: usernameController),
            16.height,
            AppTextField(
              hintText: 'Email',
              controller: emailController,
            ),
            16.height,
            AppTextField(
              hintText: 'Password',
              controller: passwordController,
            ),
            (isMobile ? 24.0 : 32.0).height,
            SizedBox(
              width: double.infinity,
              child: AppDefaultButton.large(
                isLoading: isLoading,
                text: "Sign Up",
                onPressed: () {
                  // Implement sign up logic
                  isLoading ? null : _signUp();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signUp() async {
    setState(() {
      isLoading = true;
    });
    final result = await ref.read(authRepositoryProvider).signup(
          email: emailController.text,
          username: usernameController.text,
          password: passwordController.text,
        );
    if (result.$1) {
      setState(() {
        isLoading = false;
      });
      ref.invalidate(userProvider);
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      log(result.$2 ?? "An error occurred");
    }
  }
}
