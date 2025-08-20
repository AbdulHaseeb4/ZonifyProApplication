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
    return Scaffold(
      body: Container(
        width: 1.sw,  // full screen width (responsive)
        height: 1.sh, // full screen height (responsive)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF90CAF9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // --- Center Logo with scale animation ---
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/images/logo1.png',
                  width: 180.w,  // responsive
                  height: 180.w, // maintain aspect ratio based on width
                ),
              ),
            ),

            // --- Bottom Powered By ---
            Positioned(
              bottom: 40.h, // responsive bottom padding
              left: 0,
              right: 0,
              child: Text(
                "Powered by ZonifyPro.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp, // responsive font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
