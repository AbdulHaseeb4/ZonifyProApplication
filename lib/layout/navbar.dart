import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // ✅ GoRouter import
import '../../core/theme.dart';
import '../../main.dart'; // ✅ rootScaffoldMessengerKey access

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String role;
  final VoidCallback onMenuTap;
  final String? profileImageUrl;

  const Navbar({
    super.key,
    required this.title,
    required this.role,
    required this.onMenuTap,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // ☰ Menu Button
          Tooltip(
            message: "Menu",
            child: InkWell(
              onTap: onMenuTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.dashboard_customize_rounded,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Branding (show only on web OR wide screen)
          if (kIsWeb || screenWidth > 600) ...[
            Text(
              "ZonifyPro",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.lavender,
              ),
            ),
            const SizedBox(width: 20),
          ],

          // Page Title
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ),

          const Spacer(),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.lavender.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              role,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.lavender,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // 👤 Profile Dropdown
          PopupMenuButton<String>(
            tooltip: "Profile",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            elevation: 6,
            offset: const Offset(0, 50),
            onSelected: (value) {
              if (value == "profile") {
                rootScaffoldMessengerKey.currentState?.showSnackBar(
                  const SnackBar(content: Text("Edit Profile clicked")),
                );
              } else if (value == "logout") {
                // ✅ logout → GoRouter
                context.go("/login");
                rootScaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(
                    content: Text("Logged out successfully as $role"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "profile",
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.black54),
                    const SizedBox(width: 10),
                    Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 18, color: Colors.redAccent),
                    const SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  (profileImageUrl != null && profileImageUrl!.isNotEmpty)
                  ? NetworkImage(profileImageUrl!)
                  : null,
              child: (profileImageUrl == null || profileImageUrl!.isEmpty)
                  ? const Icon(Icons.person, color: Colors.black54)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
