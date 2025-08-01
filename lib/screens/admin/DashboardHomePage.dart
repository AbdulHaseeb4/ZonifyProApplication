import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/admin/menu_pages/user_list_page.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  /// ----------------- TOP CARDS -----------------
  Widget buildTopCard(
      String title, String value, String iconPath, VoidCallback onTap, List<Color> colors) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.last.withOpacity(0.3),
                blurRadius: 8.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48.w,
                width: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Image.asset(iconPath, color: Colors.white),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ----------------- STATISTICS CARDS -----------------
  Widget buildStatCard(String title, String value, String iconPath, List<Color> colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.3),
            blurRadius: 6.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Image.asset(
                iconPath,
                height: 28.w,
                width: 28.w,
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Text(
            "Orders Overview",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),

          /// ---------- TOP 3 CARDS ----------
          Row(
            children: [
              buildTopCard("Managers", "5", "assets/icons/manager.png", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserListPage(userType: "manager"),
                  ),
                );
              }, [const Color(0xFF89CFF0), const Color(0xFF4682B4)]),
              buildTopCard("PMM", "8", "assets/icons/pmm.png", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserListPage(userType: "pmm"),
                  ),
                );
              }, [const Color(0xFFDDA0DD), const Color(0xFF9370DB)]),
              buildTopCard("PM", "15", "assets/icons/pm.png", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserListPage(userType: "pm"),
                  ),
                );
              }, [const Color(0xFF98FB98), const Color(0xFF2E8B57)]),
            ],
          ),

          SizedBox(height: 24.h),
          Text(
            "Statistics",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),

          /// ---------- STATISTICS CARDS ----------
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.2,
            children: [
              buildStatCard("Total Orders", "250", "assets/icons/orders.png",
                  [const Color(0xFF89CFF0), const Color(0xFF4682B4)]),
              buildStatCard("Total Refunds", "20", "assets/icons/refund.png",
                  [const Color(0xFFDDA0DD), const Color(0xFF9370DB)]),
              buildStatCard("Commission Completed", "PKR 4,500",
                  "assets/icons/money.png",
                  [const Color(0xFF98FB98), const Color(0xFF2E8B57)]),
              buildStatCard("Review Submitted", "180", "assets/icons/review.png",
                  [const Color(0xFFADD8E6), const Color(0xFF4682B4)]),
              buildStatCard("Review Delayed", "12", "assets/icons/delay.png",
                  [const Color(0xFFFFE4B5), const Color(0xFFF4A460)]),
              buildStatCard("Review Deleted", "5", "assets/icons/delete.png",
                  [const Color(0xFFFFB6C1), const Color(0xFFCD5C5C)]),
            ],
          ),
        ],
      ),
    );
  }
}
