import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pm_home_page.dart';
import 'pm_alerts_page.dart';
import 'pm_mail_page.dart';
import 'pm_profile_page.dart';

class PMDashboard extends StatefulWidget {
  const PMDashboard({super.key});

  @override
  State<PMDashboard> createState() => _PMDashboardState();
}

class _PMDashboardState extends State<PMDashboard> {
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = const [
    PMHomePage(),
    PMAlertsPage(),
    PMMailPage(),
    PMProfilePage(),
  ];

  final List<String> _titles = [
    "PM Dashboard",
    "PM Alerts",
    "PM Mail",
    "Profile",
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      drawer: _buildSideMenu(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.account_circle,
                        color: Colors.white, size: 32),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        setState(() => _selectedIndex = 3); // Profile tab
                      } else if (value == 'logout') {
                        // handle logout
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Text("Edit Profile"),
                      ),
                      PopupMenuItem<String>(
                        value: 'logout',
                        child: Text("Logout"),
                      ),
                    ],
                  ),
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

  /// ----------------- Drawer -----------------
  Widget _buildSideMenu() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
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
                      Text("Sara Khan",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Text("Project Manager",
                          style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey.shade300),

            /// 1. Dashboard
            _drawerMainItem(Icons.dashboard, "Dashboard", isActive: true),

            /// 2. Orders (with sub-options)
            _customExpansionTile(
              title: "Orders",
              icon: Icons.shopping_bag_outlined,
              children: const [
                {"icon": Icons.remove_red_eye, "label": "All"},
                {"icon": Icons.remove_red_eye, "label": "Ordered"},
                {"icon": Icons.remove_red_eye, "label": "Reviewed"},
                {"icon": Icons.thumbs_up_down, "label": "Review Submitted Pending Refund"},
                {"icon": Icons.cancel_presentation, "label": "Review Deleted"},
                {"icon": Icons.money_off, "label": "Refunded"},
                {"icon": Icons.pause_circle, "label": "On Hold"},
                {"icon": Icons.refresh, "label": "Refunded Pending Review"},
                {"icon": Icons.cancel, "label": "Cancelled"},
                {"icon": Icons.credit_card, "label": "Commissioned"},
                {"icon": Icons.check_circle, "label": "Completed"},
              ],
            ),

            /// 3. Products (with sub-options)
            _customExpansionTile(
              title: "Products",
              icon: Icons.inventory_2_outlined,
              children: const [
                {"icon": Icons.inventory, "label": "All Products"},
                {"icon": Icons.category, "label": "General"},
                {"icon": Icons.devices_other, "label": "Electronics"},
                {"icon": Icons.health_and_safety, "label": "Health & Beauty"},
                {"icon": Icons.child_care, "label": "Baby Products"},
                {"icon": Icons.sports_esports, "label": "Gaming Devices"},
                {"icon": Icons.checkroom, "label": "Fashion (Cloths & Shoes)"},
                {"icon": Icons.phone_android, "label": "Mobile Accessories"},
                {"icon": Icons.attach_money, "label": "Expensive Products"},
                {"icon": Icons.pets, "label": "Pet Related"},
                {"icon": Icons.kitchen, "label": "Home & Kitchen"},
              ],
            ),

            /// 4. Reservations (with sub-options)
            _customExpansionTile(
              title: "Reservations",
              icon: Icons.event_note,
              children: const [
                {"icon": Icons.add, "label": "Add New"},
                {"icon": Icons.remove_red_eye, "label": "Show"},
              ],
            ),

            /// 5. Change Password
            _drawerMainItem(Icons.lock, "Change Password"),

            /// 6. User Profile
            _drawerMainItem(Icons.person_outline, "User Profile"),

            /// 7. Create Excel
            _drawerMainItem(Icons.table_view, "Create Excel"),

            /// 8. Support
            _drawerMainItem(Icons.support_agent, "Support"),

            /// 9. Check Blacklisted Paypal
            _drawerMainItem(Icons.payment, "Check Blacklisted Paypal"),

            /// 10. Delay Refunds
            _drawerMainItem(Icons.timer_off, "Delay Refunds"),

            /// 11. Logout
            _drawerMainItem(Icons.logout, "Logout"),

            Divider(thickness: 1, color: Colors.grey.shade300),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
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

  Widget _drawerMainItem(IconData icon, String title, {bool isActive = false}) {
    return Container(
      decoration: isActive
          ? const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.green, width: 4),
        ),
        color: Color.fromARGB(15, 76, 175, 80),
      )
          : null,
      child: ListTile(
        leading: Icon(icon,
            color: isActive ? Colors.green : Colors.grey.shade600, size: 22),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.black87,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          // TODO: Handle navigation for each item
        },
      ),
    );
  }

  Widget _customExpansionTile({
    required String title,
    required IconData icon,
    required List<Map<String, dynamic>> children,
  }) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.grey.shade700),
        title: Text(title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
        iconColor: Colors.green,
        collapsedIconColor: Colors.grey,
        children: children.map((child) {
          return ListTile(
            leading: Icon(child["icon"] as IconData,
                size: 20, color: Colors.grey.shade600),
            title: Text(child["label"] as String,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
            onTap: () {
              // TODO: Handle submenu navigation
            },
          );
        }).toList(),
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
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _customNavItem(Icons.dashboard, 0),
            _customNavItem(Icons.notifications, 1),
            _customNavItem(Icons.mail, 2),
            _customNavItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _customNavItem(IconData icon, int index) {
    bool isActive = _selectedIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Icon(icon, size: 24, color: isActive ? Colors.green : Colors.grey),
          if (isActive)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
        ],
      ),
      label: '',
    );
  }
}
