import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PMProfilePage extends StatelessWidget {
  const PMProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ---------- Top Profile Card ----------
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.green.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 60.sp, color: Colors.green.shade600),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Ali Hassan",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text("Project Manager",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70)),
                  SizedBox(height: 12.h),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt, size: 18),
                    label: const Text("Change Picture"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Performance",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 0.65),
                          duration: const Duration(seconds: 1),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                                value: value,
                                minHeight: 10.h,
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightGreenAccent),
                              ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text("65% completed",
                          style:
                          TextStyle(fontSize: 12.sp, color: Colors.white70))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 25.h),

            /// ---------- Account Details ----------
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account Details",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 18.h),
                  _buildInfoField(
                      icon: Icons.person, label: "Name", value: "Ali Hassan"),
                  _buildInfoField(
                      icon: Icons.alternate_email,
                      label: "Username",
                      value: "Ali_Hassan6"),
                  _buildInfoField(
                      icon: Icons.email,
                      label: "Email",
                      value: "hassanrajpoot4414@gmail.com",
                      readOnly: true),
                  _buildInfoField(
                      icon: Icons.male, label: "Gender", value: "Male"),
                  _buildInfoField(
                      icon: Icons.location_on,
                      label: "Address",
                      value: "Address"),
                  _buildInfoField(icon: Icons.location_city, label: "City", value: "City"),
                  _buildInfoField(icon: Icons.flag, label: "Country", value: "Country"),
                  _buildInfoField(
                      icon: Icons.phone,
                      label: "Phone",
                      value: "wa.me/923241164855",
                      keyboard: TextInputType.phone),
                  _buildInfoField(icon: Icons.account_balance, label: "Bank Name", value: "Bank"),
                  _buildInfoField(icon: Icons.credit_card, label: "Account#", value: "Account number"),
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 4,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        "Update Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required String value,
    bool readOnly = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
          SizedBox(height: 6.h),
          TextFormField(
            initialValue: value,
            readOnly: readOnly,
            keyboardType: keyboard,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.green.shade400),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
