import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryRing extends StatelessWidget {
  final String label;
  final String imageUrl;
  final List<String> articleIds;
  final Set<String> viewedArticleIds;
  final VoidCallback? onTap;

  const StoryRing({
    super.key,
    required this.label,
    required this.imageUrl,
    required this.articleIds,
    required this.viewedArticleIds,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          SizedBox(
            width: 68,
            height: 68,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(68, 68),
                  painter: _SegmentedRingPainter(
                    articleIds: articleIds,
                    viewedArticleIds: viewedArticleIds,
                  ),
                ),
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: const Color(0xFFF0EDEF),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: const Color(0xFFF0EDEF),
                        child: const Icon(
                          Icons.article_outlined,
                          color: Color(0xFF45474C),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              color: Color(0xFF45474C),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SegmentedRingPainter extends CustomPainter {
  final List<String> articleIds;
  final Set<String> viewedArticleIds;

  static const _gapDegrees = 3.5;
  static const _strokeWidth = 2.5;
  static const _viewedColor = Color(0xFFC5C6CD);
  static const _dimColor = Color(0xFFE2E8F0);
  static const _gradientColors = [
    Color(0xFFFF6B35),
    Color(0xFFE1306C),
    Color(0xFFC13584),
    Color(0xFF833AB4),
  ];

  const _SegmentedRingPainter({
    required this.articleIds,
    required this.viewedArticleIds,
  });

  int? get _activeIndex {
    for (var i = 0; i < articleIds.length; i++) {
      if (!viewedArticleIds.contains(articleIds[i])) {
        return i;
      }
    }
    return null;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final segmentCount = articleIds.isEmpty ? 1 : articleIds.length;
    final activeIndex = _activeIndex;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - _strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final gapRadians = _gapDegrees * math.pi / 180;
    final segmentRadians =
        (2 * math.pi - segmentCount * gapRadians) / segmentCount;

    for (var i = 0; i < segmentCount; i++) {
      final startAngle = -math.pi / 2 + i * (segmentRadians + gapRadians);
      final viewed = viewedArticleIds.contains(articleIds[i]);
      final isActive = activeIndex == i;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round;

      if (isActive) {
        paint.shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + segmentRadians,
          colors: _gradientColors,
        ).createShader(rect);
      } else if (viewed) {
        paint.color = _viewedColor;
      } else {
        paint.color = _dimColor;
      }

      canvas.drawArc(rect, startAngle, segmentRadians, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SegmentedRingPainter oldDelegate) {
    return oldDelegate.articleIds != articleIds ||
        oldDelegate.viewedArticleIds != viewedArticleIds;
  }
}
