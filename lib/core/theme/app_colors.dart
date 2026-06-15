import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Light Mode ──────────────────────────────────────
  static const Color bg        = Color(0xFFF0F5FD);
  static const Color surface   = Color(0xFFFFFFFF);
  static const Color border    = Color(0xFFCBE2EF);

  static const Color blue      = Color(0xFF1A64D4);
  static const Color blueDk    = Color(0xFF0E4BAF);
  static const Color blueLt    = Color(0xFF3D85F0);
  static const Color blueSub   = Color(0xFFEBF2FF);

  static const Color txt       = Color(0xFF0A1628);
  static const Color txtS      = Color(0xFF4A6280);
  static const Color txtH      = Color(0xFF8AACC8);

  static const Color gain      = Color(0xFF16A34A);
  static const Color gainBg    = Color(0xFFDCFCE7);
  static const Color loss      = Color(0xFFDC2626);
  static const Color lossBg    = Color(0xFFFEE2E2);

  // ── Dark Mode ───────────────────────────────────────
  static const Color bgDark      = Color(0xFF0D1420);
  static const Color surfaceDark = Color(0xFF162032);
  static const Color borderDark  = Color(0x14FFFFFF); // rgba(255,255,255,0.08)

  static const Color txtDark     = Color(0xFFE8F0FA);
  static const Color txtSDark    = Color(0xFF6B8CAE);
  static const Color txtHDark    = Color(0xFF3D5A7A);

  // ── Gradients ───────────────────────────────────────
  static const LinearGradient portfolioGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, blueDk],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0D1F4A), Color(0xFF0A1628)],
  );
}
