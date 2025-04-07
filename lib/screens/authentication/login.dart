import 'dart:developer';

import 'package:blog_app/components/widgets/buttons.dart';
import 'package:blog_app/components/widgets/text_field.dart';
import 'package:blog_app/data/providers/auth_provider.dart';
import 'package:blog_app/data/providers/user_provider.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({super.key});

  @override
  ConsumerState<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  final emailController = TextEditingController();
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
              'Login',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            (isMobile ? 16.0 : 24.0).height,
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
                text: "Login",
                isLoading: isLoading,
                onPressed: () {
                  isLoading ? null : _login();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    setState(() {
      isLoading = true;
    });
    final result = await ref.read(authRepositoryProvider).login(
          email: emailController.text,
          password: passwordController.text,
        );
    if (result.$1) {
      setState(() {
        isLoading = false;
      });
      ref.invalidate(userProvider);
      if (mounted) {
        showAppSnackBar(context, message: "Login successful");
        Navigator.pop(context);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        showAppSnackBar(context,
            message: result.$2 ?? "An error occurred",
            type: SnackBarType.error);
      }
      log(result.$2 ?? "An error occurred");
    }
  }
}
