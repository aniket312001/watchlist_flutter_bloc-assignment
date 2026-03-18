import 'package:flutter/material.dart';

enum CommonButtonType { filled, outline, text }

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final CommonButtonType type;
  final Color? color;
  final Color? textColor;

  final double borderRadius;
  final EdgeInsets padding;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.prefixIcon,
    this.suffixIcon,
    this.type = CommonButtonType.filled,
    this.color,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? Theme.of(context).primaryColor;

    switch (type) {
      case CommonButtonType.filled:
        return _buildFilled(primaryColor);
      case CommonButtonType.outline:
        return _buildOutline(primaryColor);
      case CommonButtonType.text:
        return _buildText(primaryColor);
    }
  }

  Widget _content(Color color, {bool isFilled = true}) {
    final Color finalTextColor = textColor ?? (isFilled ? Colors.white : color);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          IconTheme(
            data: IconThemeData(color: finalTextColor),
            child: prefixIcon!,
          ),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: TextStyle(color: finalTextColor, fontWeight: FontWeight.w600),
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: 6),
          IconTheme(
            data: IconThemeData(color: finalTextColor),
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }

  Widget _buildFilled(Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: padding,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _content(color),
    );
  }

  Widget _buildOutline(Color color) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _content(color, isFilled: false),
    );
  }

  Widget _buildText(Color color) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(padding: padding),
      child: _content(color, isFilled: false),
    );
  }
}
