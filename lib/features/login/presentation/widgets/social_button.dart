import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.color,
    required this.text,
    this.iconWidget,
    required this.onPressed,
    this.textColor,
    this.border,
  });

  final Color color;
  final String text;
  final Widget? iconWidget;
  final VoidCallback onPressed;
  final Color? textColor;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor ?? Colors.white,
          side: border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconWidget ?? SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: textColor ?? Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
