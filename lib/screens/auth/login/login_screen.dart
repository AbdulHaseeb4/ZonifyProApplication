import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isHovered = false;
  bool _isPressed = false;
  bool _logoutMessageShown = false; // ✅ flag added

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (!_logoutMessageShown && args?["loggedOut"] == true) {
      final role = args?["role"] ?? "User"; // 👈 pick role from args
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Logged out successfully as $role"),
              backgroundColor: Colors.green,
            ),
          );
        }
      });

      _logoutMessageShown = true; // ✅ ensure one time only
    }
  }

  void _login(String email, String password) {
    String? targetRoute;
    String? role;

    if (email == "admin@test.com" && password == "12345") {
      targetRoute = "/admin/dashboard";
      role = "admin";
    } else if (email == "manager@test.com" && password == "12345") {
      targetRoute = "/manager/dashboard";
      role = "manager";
    } else if (email == "pmm@test.com" && password == "12345") {
      targetRoute = "/pmm/dashboard";
      role = "pmm";
    } else if (email == "pm@test.com" && password == "12345") {
      targetRoute = "/pm/dashboard";
      role = "pm";
    }

    if (targetRoute != null && role != null) {
      Navigator.pushReplacementNamed(
        context,
        targetRoute,
        arguments: {"role": role, "showMessage": true},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Invalid credentials"),
          backgroundColor: AppTheme.peach,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? 360 : 420,
            ),
            padding: EdgeInsets.all(isMobile ? 20 : 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE5E6EF),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Branding
                Text(
                  "ZonifyPro",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 24 : 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.lavender,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Smarter management. Seamless growth.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),

                // 📧 Email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppTheme.lavender,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔑 Password
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppTheme.lavender,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 28),

                // 🚀 Login Button
                MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) {
                    setState(() {
                      _isHovered = false;
                      _isPressed = false;
                    });
                  },
                  child: GestureDetector(
                    onTapDown: (_) => setState(() => _isPressed = true),
                    onTapUp: (_) => setState(() => _isPressed = false),
                    onTapCancel: () => setState(() => _isPressed = false),
                    onTap: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      _login(email, password);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      transformAlignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..scale(
                          _isPressed
                              ? 0.92
                              : _isHovered
                              ? 1.05
                              : 1.0,
                        ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 18 : 22,
                        vertical: isMobile ? 10 : 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.lavender, AppTheme.mint],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 13 : 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
