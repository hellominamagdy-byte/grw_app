import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _background = Color(0xFF021A3B);
  static const _glowBlue = Color(0xFF0059C7);
  static const _dotActive = Color(0xFF1A64D4);
  static const _dotInactive = Color(0xFF4A6E94);

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: FadeTransition(
        opacity: _fadeIn,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: 726,
              height: 744,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _glowBlue.withValues(alpha: 0.03),
                ),
              ),
            ),
            Positioned(
              width: 562,
              height: 576,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _glowBlue.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              width: 352,
              height: 360,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _glowBlue.withValues(alpha: 0.29),
                  boxShadow: [
                    BoxShadow(
                      color: _glowBlue.withValues(alpha: 0.35),
                      blurRadius: 80,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  SizedBox(
                    width: 291,
                    height: 313,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 48,
                        color: Colors.white.withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    'فلوسك شغّالة',
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(active: true),
                      const SizedBox(width: 8),
                      _dot(active: false),
                      const SizedBox(width: 8),
                      _dot(active: false),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot({required bool active}) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: active ? 24 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: active ? _dotActive : _dotInactive,
          borderRadius: BorderRadius.circular(4),
        ),
      );
}
