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
  late AnimationController _proController;
  late Animation<double> _proScale;
  bool _showPro = false;

  String _syncText = "";
  final String _syncFull = "Pro";

  @override
  void initState() {
    super.initState();

    _proController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _proScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _proController, curve: Curves.elasticOut),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _showPro = true);
      _proController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      _startTypingSync();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      // ✅ Ab yahan named route use karenge
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  void _startTypingSync() async {
    for (int i = 0; i < _syncFull.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (!mounted) return;
      setState(() {
        _syncText = _syncFull.substring(0, i + 1);
      });
    }
  }

  @override
  void dispose() {
    _proController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final double fontSize = isMobile ? 32 : 54; // ✅ responsive font size

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showPro)
              ScaleTransition(
                scale: _proScale,
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
              _syncText,
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
