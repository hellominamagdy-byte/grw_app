import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get h1 => GoogleFonts.inter(
    fontSize: 26, fontWeight: FontWeight.w800,
    color: AppColors.txt, letterSpacing: -0.5,
  );

  static TextStyle get h2 => GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.w800,
    color: AppColors.txt, letterSpacing: -0.3,
  );

  static TextStyle get pageTitle => GoogleFonts.inter(
    fontSize: 17, fontWeight: FontWeight.w700,
    color: AppColors.txt,
  );

  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 16, fontWeight: FontWeight.w700,
    color: AppColors.txt,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w400,
    color: AppColors.txt,
  );

  static TextStyle get bodySemiBold => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w600,
    color: AppColors.txt,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 11, fontWeight: FontWeight.w500,
    color: AppColors.txtS,
  );

  static TextStyle get micro => GoogleFonts.inter(
    fontSize: 10, fontWeight: FontWeight.w600,
    color: AppColors.txtH, letterSpacing: 0.5,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 9, fontWeight: FontWeight.w800,
    color: AppColors.txtH,
    letterSpacing: 1.5,
    textBaseline: TextBaseline.alphabetic,
  );

  // Dark mode variants
  static TextStyle get h1Dark => h1.copyWith(color: AppColors.txtDark);
  static TextStyle get h2Dark => h2.copyWith(color: AppColors.txtDark);
  static TextStyle get pageTitleDark => pageTitle.copyWith(color: AppColors.txtDark);
  static TextStyle get bodyDark => body.copyWith(color: AppColors.txtDark);
  static TextStyle get captionDark => caption.copyWith(color: AppColors.txtSDark);
}
