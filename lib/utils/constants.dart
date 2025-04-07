import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context, {
  required String message,
  SnackBarType type = SnackBarType.success,
  Duration duration = const Duration(seconds: 3),
  SnackBarAction? action,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;
  bool isOverlayActive = true;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      right: 10,
      child: Material(
        // adding transparent to apply custom border
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: type == SnackBarType.success
                  ? Colors.green
                  : Colors.redAccent,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  type == SnackBarType.success
                      ? Icons.check_circle
                      : Icons.error,
                  color: Colors.white,
                  size: 16),
              const SizedBox(width: 10),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 15),
                onPressed: () {
                  if (isOverlayActive) {
                    overlayEntry.remove();
                    isOverlayActive = false;
                  }
                },
              )
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(duration, () {
    if (isOverlayActive) {
      overlayEntry.remove();
      isOverlayActive = false;
    }
  });
}

enum SnackBarType { success, error }
