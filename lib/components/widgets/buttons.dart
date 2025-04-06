import 'package:flutter/material.dart';

abstract class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
}

class AppDefaultButton extends AppButton {
  const AppDefaultButton({
    super.key,
    required super.text,
    super.onPressed,
    super.size,
    this.isLoading = false,
  });

  const AppDefaultButton.small({
    super.key,
    required super.text,
    super.onPressed,
    this.isLoading = false,
  }) : super(size: ButtonSize.small);

  const AppDefaultButton.large({
    super.key,
    required super.text,
    super.onPressed,
    this.isLoading = false,
  }) : super(size: ButtonSize.large);

  final bool isLoading;

  @override
  State<AppDefaultButton> createState() => _AppDefaultButtonState();
}

class AppOutlinedButton extends AppButton {
  const AppOutlinedButton({
    super.key,
    required super.text,
    super.onPressed,
    super.size,
  });

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

abstract class _AppButtonState<T extends AppButton> extends State<T> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(isMobile),
            vertical: _getVerticalPadding(isMobile),
          ),
          decoration: _buildDecoration(),
          child: _buildChild(isMobile, isTablet),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration();

  Widget _buildChild(bool isMobile, bool isTablet);

  double _getHorizontalPadding(bool isMobile) {
    switch (widget.size) {
      case ButtonSize.small:
        return isMobile ? 12 : 24;
      case ButtonSize.medium:
        return isMobile ? 16 : 32;
      case ButtonSize.large:
        return isMobile ? 20 : 40;
    }
  }

  double _getVerticalPadding(bool isMobile) {
    switch (widget.size) {
      case ButtonSize.small:
        return isMobile ? 2 : 4;
      case ButtonSize.medium:
        return isMobile ? 4 : 8;
      case ButtonSize.large:
        return isMobile ? 8 : 12;
    }
  }

  double _getFontSize(bool isMobile, bool isTablet) {
    switch (widget.size) {
      case ButtonSize.small:
        return isMobile ? 12 : 14;
      case ButtonSize.medium:
        return isMobile ? 14 : 16;
      case ButtonSize.large:
        return isMobile
            ? 14
            : isTablet
                ? 16
                : 18;
    }
  }
}

class _AppDefaultButtonState extends _AppButtonState<AppDefaultButton> {
  @override
  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: isHovered ? Colors.blue[700] : Colors.blue,
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget _buildChild(bool isMobile, bool isTablet) {
    return widget.size != ButtonSize.large
        ? Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: _getFontSize(isMobile, isTablet),
              fontWeight: FontWeight.w500,
            ),
          )
        : Center(
            child: widget.isLoading
                ? CircularProgressIndicator.adaptive()
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _getFontSize(isMobile, isTablet),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          );
  }
}

class _AppOutlinedButtonState extends _AppButtonState<AppOutlinedButton> {
  @override
  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      border: Border.all(color: isHovered ? Colors.blue[700]! : Colors.blue),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget _buildChild(bool isMobile, bool isTablet) {
    return Text(
      widget.text,
      style: TextStyle(
        color: isHovered ? Colors.blue[700] : Colors.blue,
        fontSize: _getFontSize(isMobile, isTablet),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

enum ButtonSize {
  small,
  medium,
  large,
}
