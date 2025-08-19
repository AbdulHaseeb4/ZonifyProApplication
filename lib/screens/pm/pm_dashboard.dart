import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/pm/menu_pages/products/pm_products_page.dart';
import 'pm_home_page.dart';
import 'pm_alerts_page.dart';
import 'pm_mail_page.dart';
import 'pm_profile_page.dart';
import 'menu_pages/delayrefund/pm_delay_refunds_page.dart';
import 'menu_pages/checkpaypal/pm_check_blacklist_paypal_page.dart';
import 'menu_pages/reservation/show_reservation_page.dart';
import 'menu_pages/orders/orders_page.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: const TextStyle(fontSize: 20)));
  }
}

class PMDashboard extends StatefulWidget {
  const PMDashboard({super.key});

  @override
  State<PMDashboard> createState() => _PMDashboardState();
}

class _PMDashboardState extends State<PMDashboard> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = <Widget>[
    const PMHomePage(), // 0
    const PMAlertsPage(), // 1
    const PMMailPage(), // 2
    const PMProfilePage(), // 3
    const PMDelayRefundsPage(), // 4
    const PlaceholderPage(title: "Orders"), // 5 (not used directly)
    const PlaceholderPage(title: "Products"), // 6 (not used directly)
    const PlaceholderPage(title: "Reservations"), // 7 (not used directly)
    const PMProfilePage(changePasswordOnly: true), // 8
    const PMProfilePage(), // 9 user profile
    const PlaceholderPage(title: "Create Excel"), // 10
    const PlaceholderPage(title: "Support"), // 11
    const PMCheckBlacklistPaypalPage(), // 12

    /// ✅ Orders (single page with chips)
    const OrdersPage(), // 13

    /// ✅ Products
    const PMProductsPage(category: "All"), // 14

    /// ✅ Reservations
    const ShowReservationPage(), // 15
  ];

  final List<String> _titles = [
    "PM Dashboard", // 0
    "PM Alerts",    // 1
    "PM Mail",      // 2
    "Profile",      // 3
    "Delay Refunds",// 4
    "Orders",       // 5 placeholder
    "Products",     // 6 placeholder
    "Reservations", // 7 placeholder
    "Change Password", // 8
    "User Profile",    // 9
    "Create Excel",    // 10
    "Support",         // 11
    "Check Blacklisted Paypal", // 12
    "Orders",          // 13 ✅
    "Products",        // 14 ✅
    "Show Reservation" // 15 ✅
  ];

  void _onTabTapped(int index) => setState(() => _selectedIndex = index);
  void _onDrawerItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    child: Image.asset('assets/icons/menu.png',
                        width: 24.w, height: 24.w, color: Colors.white),
                  ),
                  Text(_titles[_selectedIndex],
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.account_circle,
                        color: Colors.white, size: 32),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    onSelected: (value) {
                      if (value == 'edit') setState(() => _selectedIndex = 9);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem<String>(
                          value: 'edit', child: Text("Edit Profile")),
                      PopupMenuItem<String>(
                          value: 'logout', child: Text("Logout")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildModernNavBar(),
    );
  }

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
                    backgroundImage:
                    const AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sara Khan",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Text("Project Manager",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 13.sp)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey.shade300),
            _drawerMainItem(Icons.dashboard, "Dashboard", 0),

            /// ✅ Orders (single menu item)
            _drawerMainItem(Icons.shopping_bag_outlined, "Orders", 13),

            /// ✅ Products
            _drawerMainItem(Icons.inventory_2_outlined, "Products", 14),

            /// ✅ Reservations
            _drawerMainItem(Icons.event_note, "Show Reservation", 15),

            _drawerMainItem(Icons.lock, "Change Password", 8),
            _drawerMainItem(Icons.person_outline, "User Profile", 9),
            _drawerMainItem(Icons.table_view, "Create Excel", 10),
            _drawerMainItem(Icons.support_agent, "Support", 11),
            _drawerMainItem(Icons.payment, "Check Blacklisted Paypal", 12),
            _drawerMainItem(Icons.timer_off, "Delay Refunds", 4),
          ],
        ),
      ),
    );
  }

  Widget _drawerMainItem(IconData icon, String title, int index) {
    bool isActive = _selectedIndex == index;
    return Container(
      decoration: isActive
          ? const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.green, width: 4)),
        color: Color.fromARGB(15, 76, 175, 80),
      )
          : null,
      child: ListTile(
        leading: Icon(icon,
            color: isActive ? Colors.green : Colors.grey.shade600),
        title: Text(title,
            style: TextStyle(
                color: isActive ? Colors.green : Colors.black87,
                fontWeight:
                isActive ? FontWeight.bold : FontWeight.normal)),
        onTap: () => _onDrawerItemTapped(index),
      ),
    );
  }

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
          currentIndex: _selectedIndex > 3 ? 0 : _selectedIndex,
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
          Icon(icon, size: 24,
              color: isActive ? Colors.green : Colors.grey),
          if (isActive)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 2),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green),
            ),
        ],
      ),
      label: '',
    );
  }
}
