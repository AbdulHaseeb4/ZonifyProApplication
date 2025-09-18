import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum SnackBarType { success, error, warning, info }

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
        accent = const Color(0xFF4CAF50); // soft green
        icon = PhosphorIconsFill.checkCircle;
        break;
      case SnackBarType.error:
        accent = const Color(0xFFE57373); // soft red
        icon = PhosphorIconsFill.xCircle;
        break;
      case SnackBarType.warning:
        accent = const Color(0xFFFFB74D); // amber
        icon = PhosphorIconsFill.warningCircle;
        break;
      case SnackBarType.info:
        accent = const Color(0xFF64B5F6); // light blue
        icon = PhosphorIconsFill.info;
        break;
    }

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      duration: const Duration(seconds: 5),
      content: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ), // slim
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: accent.withValues(alpha: 0.4), // ✅ new API
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.15), // ✅ new API
              blurRadius: 6,
              offset: const Offset(0, 2),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // Close Button
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Icon(PhosphorIconsLight.x, size: 18, color: accent),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
