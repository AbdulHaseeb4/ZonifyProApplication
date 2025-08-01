import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/splashscreen.dart';

void main() {
  runApp(const ZonifyProApp());
}

class ZonifyProApp extends StatelessWidget {
  const ZonifyProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Base design size (iPhone 11 Pro)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ZonifyPro',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            fontFamily: 'Poppins',
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
