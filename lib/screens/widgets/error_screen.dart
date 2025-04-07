import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    this.title = "Oops!",
    this.message = "Something went wrong. Please try again later.",
    this.actionText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 600;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWide ? 500 : double.infinity),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onRetry != null)
                      ElevatedButton.icon(
                        icon: Icon(Icons.refresh),
                        label: Text(actionText ?? "Retry"),
                        onPressed: onRetry,
                      ),
                    SizedBox(width: 12),
                    TextButton(
                      onPressed: () => context.go('/'),
                      child: Text("Go Home"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
