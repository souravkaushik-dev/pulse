import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme light = TextTheme(
    headlineLarge: GoogleFonts.inter(
      fontSize: 34.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
      color: Colors.black,
    ),

    headlineMedium: GoogleFonts.inter(
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    titleLarge: GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    titleMedium: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    bodyLarge: GoogleFonts.inter(
      fontSize: 15.sp,
      color: Colors.black,
    ),

    bodyMedium: GoogleFonts.inter(
      fontSize: 13.sp,
      color: Colors.grey,
    ),
  );

  static TextTheme dark = light.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );
}