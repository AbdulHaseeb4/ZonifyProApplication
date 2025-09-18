import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum SnackBarType { success, error, warning, info }

/// 🔹 Responsive helper with 3 breakpoints
class Responsive {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isMobile(BuildContext context) => width(context) < 600;

  static bool isTablet(BuildContext context) {
    final w = width(context);
    return w >= 600 && w < 1024;
  }

  static bool isDesktop(BuildContext context) => width(context) >= 1024;
}

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    Color accent;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        accent = const Color(0xFF4CAF50);
        icon = PhosphorIconsFill.checkCircle;
        break;
      case SnackBarType.error:
        accent = const Color(0xFFE57373);
        icon = PhosphorIconsFill.xCircle;
        break;
      case SnackBarType.warning:
        accent = const Color(0xFFFFB74D);
        icon = PhosphorIconsFill.warningCircle;
        break;
      case SnackBarType.info:
        accent = const Color(0xFF64B5F6);
        icon = PhosphorIconsFill.info;
        break;
    }

    // ✅ Responsive width
    double snackWidth;
    if (Responsive.isMobile(context)) {
      snackWidth = double.infinity; // full width
    } else if (Responsive.isTablet(context)) {
      snackWidth = Responsive.width(context) * 0.7; // 70% of screen
    } else {
      snackWidth = 400; // fixed card for desktop
    }

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      content: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.2, end: 1.0), // zoom bounce
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            width: snackWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ), // ✅ thin
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accent.withOpacity(0.4), width: 1),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: accent, size: 20),
                const SizedBox(width: 10),

                // Message
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.poppins(
                      fontSize: Responsive.isMobile(context) ? 12 : 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // OK Button
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: accent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ), // ✅ slim button
                    textStyle: GoogleFonts.poppins(
                      fontSize: Responsive.isMobile(context) ? 11 : 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
