
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
  });
  final String hintText;
  final TextEditingController? controller;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: isMobile ? 0.5 : 1.0, color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
        ),
      ),
    );
  }
}
