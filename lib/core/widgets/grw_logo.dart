import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GrwLogo extends StatelessWidget {
  final double height;
  final Color? color;

  const GrwLogo({super.key, this.height = 48, this.color});

  static const assetPath = 'assets/images/grw_logo.svg';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoColor = color ?? (isDark ? Colors.white : Colors.black);

    return SvgPicture.asset(
      assetPath,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(logoColor, BlendMode.srcIn),
    );
  }
}
