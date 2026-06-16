import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _bgColor = Color(0xFF061535);
  static const _circleColor = Color(0xFF0D2657);
  static const _dotActive = Color(0xFF2D6EF5);
  static const _dotInactive = Color(0xFF2A4080);

  VideoPlayerController? _videoController;
  bool _videoReady = false;
  int _dotIndex = 0;

  @override
  void initState() {
    super.initState();
    _initVideo();
    _startNavTimer();
    _startDotAnimation();
  }

  Future<void> _initVideo() async {
    final controller = VideoPlayerController.asset(
      'assets/videos/logo_animation.mp4',
    );
    _videoController = controller;
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      if (mounted) setState(() => _videoReady = true);
    } catch (_) {
      // video failed — fallback circle shown
    }
  }

  void _startNavTimer() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.go('/login');
    });
  }

  void _startDotAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _dotIndex = 1);
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() => _dotIndex = 2);
      });
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final circleSize = size.width * 0.82;

    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Radial glow behind circle
          Positioned(
            top: size.height * 0.10,
            left: size.width / 2 - circleSize * 0.55,
            child: Container(
              width: circleSize * 1.1,
              height: circleSize * 1.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1A3F8F).withValues(alpha: 0.55),
                    _bgColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Video circle (centered) ───────────────────
              ClipOval(
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  color: _circleColor,
                  child: _videoReady && _videoController != null
                      ? FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoController!.value.size.width,
                            height: _videoController!.value.size.height,
                            child: VideoPlayer(_videoController!),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              const SizedBox(height: 48),

              // ── Arabic text ───────────────────────────────
              Text(
                'فلوسك شغّالة',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.cairo(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(height: 24),

              // ── Animated dots ─────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  final isActive = i == _dotIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isActive ? 28 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isActive ? _dotActive : _dotInactive,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
