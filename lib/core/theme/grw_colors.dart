import 'package:flutter/material.dart';

/// Theme-aware color palette matching the Figma light/dark design system.
class GrwColors {
  const GrwColors({
    required this.background,
    required this.backgroundAlt,
    required this.surface,
    required this.card,
    required this.headerBar,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.sectionLabel,
    required this.border,
    required this.borderLight,
    required this.iconCircleBg,
    required this.navBar,
    required this.navActiveBg,
    required this.chipBorder,
    required this.chipInactiveText,
    required this.searchField,
    required this.avatarBg,
    required this.cardShadow,
    required this.investmentCard,
    required this.activitiesSurface,
    required this.primaryAction,
    required this.balanceGradientStart,
    required this.balanceGradientEnd,
    required this.lossAmount,
    required this.lossIconBg,
    required this.gainBadgeBg,
    required this.gainBadgeText,
    required this.navInactive,
  });

  final Color background;
  final Color backgroundAlt;
  final Color surface;
  final Color card;
  final Color headerBar;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color sectionLabel;
  final Color border;
  final Color borderLight;
  final Color iconCircleBg;
  final Color navBar;
  final Color navActiveBg;
  final Color chipBorder;
  final Color chipInactiveText;
  final Color searchField;
  final Color avatarBg;
  final Color cardShadow;
  final Color investmentCard;
  final Color activitiesSurface;
  final Color primaryAction;
  final Color balanceGradientStart;
  final Color balanceGradientEnd;
  final Color lossAmount;
  final Color lossIconBg;
  final Color gainBadgeBg;
  final Color gainBadgeText;
  final Color navInactive;

  static const primary = Color(0xFF0059C7);
  static const primaryDark = Color(0xFF004398);
  static const gain = Color(0xFF1B8A44);
  static const loss = Color(0xFFBA1A1A);

  static const light = GrwColors(
    background: Color(0xFFF8F9FB),
    backgroundAlt: Color(0xFFF8FAFF),
    surface: Colors.white,
    card: Colors.white,
    headerBar: Color(0xFFFBF8FA),
    textPrimary: Color(0xFF1B1B1D),
    textSecondary: Color(0xFF45474C),
    textHint: Color(0xFF8AACC8),
    sectionLabel: Color(0xFF8AACC8),
    border: Color(0x1AC5C6CD),
    borderLight: Color(0xFFC5C6CD),
    iconCircleBg: Color(0x1A528DFF),
    navBar: Color(0xE6FFFFFF),
    navActiveBg: Color(0x1A528DFF),
    chipBorder: Color(0x4DC5C6CD),
    chipInactiveText: Color(0xFF45474C),
    searchField: Color(0xFFF0F5FD),
    avatarBg: Color(0xFFE4E2E3),
    cardShadow: Color(0x0D0A1628),
    investmentCard: Color(0xCCFFFFFF),
    activitiesSurface: Color(0xFFF8F9FB),
    primaryAction: Color(0xFF0059C7),
    balanceGradientStart: Color(0xFF0059C7),
    balanceGradientEnd: Color(0xFF004398),
    lossAmount: Color(0xFFBA1A1A),
    lossIconBg: Color(0x4DFFDAD6),
    gainBadgeBg: Color(0xFFECFDF5),
    gainBadgeText: Color(0xFF059669),
    navInactive: Color(0xFF45474C),
  );

  /// Figma dark frames: `home` (1:2064), `wallet` (1:2235), `my hub` (1:2398).
  static const dark = GrwColors(
    background: Color(0xFF0D1420),
    backgroundAlt: Color(0xFF0D1420),
    surface: Color(0xFF162032),
    card: Color(0xFF162032),
    headerBar: Color(0xFF0D1420),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0x8CFFFFFF),
    textHint: Color(0x59FFFFFF),
    sectionLabel: Color(0xFF6B8CAE),
    border: Color(0x26FFFFFF),
    borderLight: Color(0x26FFFFFF),
    iconCircleBg: Color(0x1A1A64D4),
    navBar: Color(0xE60D1420),
    navActiveBg: Color(0x1A1A64D4),
    chipBorder: Color(0x26FFFFFF),
    chipInactiveText: Color(0x59FFFFFF),
    searchField: Color(0xFF162032),
    avatarBg: Color(0xFF162032),
    cardShadow: Color(0x33000000),
    investmentCard: Color(0xFF162032),
    activitiesSurface: Color(0xFF162032),
    primaryAction: Color(0xFF1A64D4),
    balanceGradientStart: Color(0xFF1A64D4),
    balanceGradientEnd: Color(0xFF0E4BAF),
    lossAmount: Color(0xFFEF4444),
    lossIconBg: Color(0x1AEF4444),
    gainBadgeBg: Color(0x1A22C55E),
    gainBadgeText: Color(0xFF22C55E),
    navInactive: Color(0x66FFFFFF),
  );
}

extension GrwColorsX on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  GrwColors get grw => isDarkMode ? GrwColors.dark : GrwColors.light;
}
