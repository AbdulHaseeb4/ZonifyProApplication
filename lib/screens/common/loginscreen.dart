import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/admin/admin_dashboard.dart';
import 'package:zonifypro/screens/pm/pm_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isSubmitted = false;

  static const Color gradientStart = Color(0xFF2196F3);
  static const Color gradientEnd = Color(0xFF90CAF9);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  void _login() {
    setState(() {
      _isSubmitted = true;
    });
    if (_formKey.currentState!.validate()) {
      // --- Admin vs PM check
      if (_emailController.text == "pm@zonifypro.com" &&
          _passwordController.text == "12345678") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PMDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboard()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.black.withOpacity(0.4),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 0.12.sh),
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: const AssetImage('assets/images/logo1.png'),
                  backgroundColor: Colors.white.withOpacity(0.8),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                ),
                SizedBox(height: 0.05.sh),

                /// --- Login Box ---
                Container(
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10.r,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _isSubmitted
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        /// Email Field
                        TextFormField(
                          controller: _emailController,
                          validator: _validateEmail,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Image.asset(
                                'assets/icons/email.png',
                                width: 20.w,
                                height: 20.w,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: gradientStart, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        /// Password Field
                        TextFormField(
                          controller: _passwordController,
                          validator: _validatePassword,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Image.asset(
                                'assets/icons/lock.png',
                                width: 20.w,
                                height: 20.w,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () =>
                                  setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: gradientStart, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Login Button (icon removed, text centered)
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 0.5.sw,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [gradientStart, gradientEnd],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: ElevatedButton(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r)),
                                ),
                                onPressed: _login,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
