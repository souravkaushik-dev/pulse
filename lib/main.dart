import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ScreenUtilPlusInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const PulseApp();
      },
    ),
  );
}