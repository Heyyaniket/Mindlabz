import 'package:flutter/material.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final bool isGoogle;

  const SocialButton({
    super.key,
    required this.icon,
    this.size = 24,
    this.isGoogle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: AppPallete.borderColor),
        color: Colors.transparent,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size,
          color: isGoogle ? Colors.blue : AppPallete.black,
        ),
      ),
    );
  }
}