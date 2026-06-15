import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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

    // Navigate to login after 3 seconds
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
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.splashGradient,
            ),
          ),

          // Content
          FadeTransition(
            opacity: _fadeIn,
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // GRW Logo Circle
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue.withValues(alpha:0.15),
                      border: Border.all(
                        color: AppColors.blueLt.withValues(alpha:0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blue.withValues(alpha:0.3),
                          blurRadius: 60,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Grw',
                        style: AppTextStyles.h1Dark.copyWith(
                          fontSize: 52,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: AppColors.blueLt.withValues(alpha:0.8),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Tagline
                  Text(
                    'فلوسك شغّالة',
                    style: AppTextStyles.h2Dark.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  const Spacer(flex: 3),

                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dot(active: true),
                      const SizedBox(width: 6),
                      _dot(active: false),
                      const SizedBox(width: 6),
                      _dot(active: false),
                    ],
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot({required bool active}) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: active ? 24 : 8,
    height: 8,
    decoration: BoxDecoration(
      color: active ? AppColors.blue : AppColors.txtHDark,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
