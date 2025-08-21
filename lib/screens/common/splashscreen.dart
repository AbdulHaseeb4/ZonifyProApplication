import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/common/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // ✅ Responsive breakpoints
    double logoSize;
    double fontSize;

    if (screenWidth < 600) {
      // Mobile
      logoSize = 140.w;
      fontSize = 14.sp;
    } else if (screenWidth < 1100) {
      // Tablet
      logoSize = 200;
      fontSize = 16;
    } else {
      // Desktop/Web
      logoSize = 260;
      fontSize = 18;
    }

    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF90CAF9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            /// --- Center Logo with scale animation ---
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/images/logo1.png',
                  width: logoSize,
                  height: logoSize,
                ),
              ),
            ),

            /// --- Bottom Powered By ---
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Text(
                "Powered by ZonifyPro.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
