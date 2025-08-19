import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PMCheckBlacklistPaypalPage extends StatefulWidget {
  const PMCheckBlacklistPaypalPage({super.key});

  @override
  State<PMCheckBlacklistPaypalPage> createState() =>
      _PMCheckBlacklistPaypalPageState();
}

class _PMCheckBlacklistPaypalPageState
    extends State<PMCheckBlacklistPaypalPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _result;

  void _checkBlacklist() {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _result = "Please enter a PayPal email or ID");
      return;
    }

    // --- Dummy check logic (replace with API or DB in future) ---
    List<String> blacklist = ["fraud@gmail.com", "blocked@paypal.com"];
    bool isBlacklisted = blacklist.contains(email.toLowerCase());

    setState(() {
      _result = isBlacklisted
          ? "⚠️ $email is BLACKLISTED!"
          : "✅ $email is safe.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title Removed
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Enter PayPal email or ID"),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkBlacklist,
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  backgroundColor: Colors.green),
              child: const Text("Check Now",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 20.h),
          if (_result != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey.shade100),
              child: Text(
                _result!,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: _result!.contains("BLACKLISTED")
                        ? Colors.red
                        : Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}
