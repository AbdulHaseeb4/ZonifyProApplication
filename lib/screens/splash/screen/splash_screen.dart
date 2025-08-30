import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;
  bool _showZonify = false;
  String _typedPro = "";
  final String _fullPro = "Pro";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _bounce = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Step 1: Bounce animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _showZonify = true);
      _controller.forward();
    });

    // Step 2: Typing animation for "Pro"
    Future.delayed(const Duration(milliseconds: 1200), () {
      _startTypingPro();
    });

    // ⛔ NOTE: No redirect here anymore, router handles it
  }

  void _startTypingPro() async {
    for (int i = 0; i < _fullPro.length; i++) {
      await Future.delayed(const Duration(milliseconds: 180));
      if (!mounted) return;
      setState(() {
        _typedPro = _fullPro.substring(0, i + 1);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final double fontSize = isMobile ? 32 : 54;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showZonify)
              ScaleTransition(
                scale: _bounce,
                child: Text(
                  "Zonify",
                  style: GoogleFonts.poppins(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.lavender,
                    letterSpacing: 2,
                  ),
                ),
              ),
            Text(
              _typedPro,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: AppTheme.lavender,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
