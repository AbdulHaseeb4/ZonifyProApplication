import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'DashboardHomePage.dart';
import 'alerts_page.dart';
import 'add_page.dart';
import 'mail_page.dart';
import 'profile_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  int _selectedDrawerIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = const [
    DashboardHomePage(),
    AlertsPage(),
    AddPage(),
    MailPage(),
    ProfilePage(),
  ];

  final List<String> _titles = [
    "Dashboard",
    "Alerts",
    "Add Users",
    "Mail",
    "Profile",
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _onDrawerItemTap(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      drawer: _buildSideMenu(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF90CAF9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState!.openDrawer(),
                    child: Image.asset(
                      'assets/icons/menu.png',
                      width: 24.w,
                      height: 24.w,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _titles[_selectedIndex],
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 24.w),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: _buildModernNavBar(),
    );
  }

  /// ----------------- Modern Drawer -----------------
  Widget _buildSideMenu() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Profile Section ----------
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundImage: const AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ali Ahmed",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Text("Admin",
                          style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            // ---------- Menu Items ----------
            _drawerItem(Icons.home_outlined, "Home", 0),
            _drawerItem(Icons.book_outlined, "Topics", 1),
            _drawerItem(Icons.message_outlined, "Messages", 2),
            _drawerItem(Icons.notifications_none, "Notifications", 3),
            _drawerItem(Icons.bookmark_border, "Bookmarks", 4),
            _drawerItem(Icons.person_outline, "Profile", 5),

            // ---------- Logout Button ----------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout_sharp, color: Colors.red),
                  title: Text("Logout",
                      style: TextStyle(color: Colors.black54, fontSize: 14.sp)),
                  onTap: () {},
                ),
              ),
            ),

            const Spacer(),

            // ---------- Bottom Center Text ----------
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  "ZONIFYPRO.COM",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int index) {
    bool selected = _selectedDrawerIndex == index;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ListTile(
          leading: Icon(icon,
              color: selected ? Colors.black : Colors.grey.shade700, size: 22.sp),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? Colors.black : Colors.grey.shade700,
            ),
          ),
          onTap: () => _onDrawerItemTap(index),
        ),
      ),
    );
  }

  /// ----------------- Bottom Navigation -----------------
  Widget _buildModernNavBar() {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 6.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildAssetNavItem('assets/icons/dashboard.png', 0),
            _buildAssetNavItem('assets/icons/notification.png', 1),
            _buildAssetNavItem('assets/icons/add.png', 2),
            _buildAssetNavItem('assets/icons/mail.png', 3),
            _buildAssetNavItem('assets/icons/profile.png', 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAssetNavItem(String assetPath, int index) {
    bool isActive = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Image.asset(
        assetPath,
        width: 22.w,
        height: 22.w,
        color: isActive ? Colors.blueAccent : Colors.grey,
      ),
      label: '',
    );
  }
}
