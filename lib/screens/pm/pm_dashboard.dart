import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/pm/menu_pages/products/pm_products_page.dart';
import 'pm_home_page.dart';
import 'pm_alerts_page.dart';
import 'pm_mail_page.dart';
import 'pm_profile_page.dart';
import 'menu_pages/pm_delay_refunds_page.dart';
import 'menu_pages/pm_check_blacklist_paypal_page.dart';
import 'menu_pages/reservation/subpages/show_reservation_page.dart';
import 'menu_pages/reservation/subpages/add_new_reservation_page.dart';
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
    const PMProfilePage(changePasswordOnly: true), // 8 change password
    const PMProfilePage(), // 9 user profile
    const PlaceholderPage(title: "Create Excel"), // 10
    const PlaceholderPage(title: "Support"), // 11
    const PMCheckBlacklistPaypalPage(), // 12

    // Orders subpages
    const OrdersPage(), // All Orders (13) – no status filter
    const OrdersPage(status: "Ordered"), // 14
    const OrdersPage(status: "Reviewed"), // 15
    const OrdersPage(status: "Review Submitted Pending Refund"), // 16
    const OrdersPage(status: "Review Deleted"), // 17
    const OrdersPage(status: "Refunded"), // 18
    const OrdersPage(status: "On Hold"), // 19
    const OrdersPage(status: "Refunded Pending Refund"), // 20
    const OrdersPage(status: "Cancelled"), // 21
    const OrdersPage(status: "Commissioned"), // 22
    const OrdersPage(status: "Completed"), // 23


    // Products subpages
    const PMProductsPage(category: "All Products"), // 24
    const PMProductsPage(category: "General"),      // 25
    const PMProductsPage(category: "Electronics"),  // 26
    const PMProductsPage(category: "Health & Beauty"), // 27
    const PMProductsPage(category: "Baby Products"), // 28
    const PMProductsPage(category: "Gaming Devices"), // 29
    const PMProductsPage(category: "Fashion (Cloths & Shoes)"), // 30
    const PMProductsPage(category: "Mobile Accessories"), // 31
    const PMProductsPage(category: "Expensive Products"), // 32
    const PMProductsPage(category: "Pet Related"), // 33
    const PMProductsPage(category: "Home & Kitchen"), // 34



    // Reservations subpages
    const AddNewReservationPage(), // 35
    const ShowReservationPage(), // 36
  ];

  final List<String> _titles = [
    "PM Dashboard",
    "PM Alerts",
    "PM Mail",
    "Profile",
    "Delay Refunds",
    "Orders",
    "Products",
    "Reservations",
    "Change Password",
    "User Profile",
    "Create Excel",
    "Support",
    "Check Blacklisted Paypal",
    "All Orders",
    "Ordered",
    "Reviewed",
    "Review Submitted Pending Refund",
    "Review Deleted",
    "Refunded",
    "On Hold",
    "Refunded Pending Refund",
    "Cancelled",
    "Commissioned",
    "Completed",
    "All Products",
    "General",
    "Electronics",
    "Health & Beauty",
    "Baby Products",
    "Gaming Devices",
    "Fashion (Cloths & Shoes)",
    "Mobile Accessories",
    "Expensive Products",
    "Pet Related",
    "Home & Kitchen",
    "Add New Reservation",
    "Show Reservation",
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
            borderRadius:
            BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
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
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    onSelected: (value) {
                      if (value == 'edit') setState(() => _selectedIndex = 9);
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem<String>(value: 'edit', child: Text("Edit Profile")),
                      PopupMenuItem<String>(value: 'logout', child: Text("Logout")),
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
                  CircleAvatar(radius: 28.r, backgroundImage: const AssetImage('assets/images/profile.png')),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sara Khan", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      Text("Project Manager", style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: Colors.grey.shade300),
            _drawerMainItem(Icons.dashboard, "Dashboard", 0),

            /// Orders (highlight if any subpage active)
            ExpansionTile(
              initiallyExpanded: _selectedIndex >= 13 && _selectedIndex <= 23,
              leading: Icon(Icons.shopping_bag_outlined,
                  color: (_selectedIndex >= 13 && _selectedIndex <= 23)
                      ? Colors.green
                      : Colors.grey.shade600),
              title: Text("Orders",
                  style: TextStyle(
                      fontWeight: (_selectedIndex >= 13 && _selectedIndex <= 23)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: (_selectedIndex >= 13 && _selectedIndex <= 23)
                          ? Colors.green
                          : Colors.black87)),
              children: [
                _drawerSubItem(Icons.remove_red_eye_outlined, "All", 13),
                _drawerSubItem(Icons.remove_red_eye_outlined, "Ordered", 14),
                _drawerSubItem(Icons.remove_red_eye_outlined, "Reviewed", 15),
                _drawerSubItem(Icons.thumb_up_alt_outlined, "Review Submitted Pending Refund", 16),
                _drawerSubItem(Icons.cancel_outlined, "Review Deleted", 17),
                _drawerSubItem(Icons.assignment_returned_outlined, "Refunded", 18),
                _drawerSubItem(Icons.pan_tool_outlined, "On Hold", 19),
                _drawerSubItem(Icons.refresh_outlined, "Refunded Pending Refund", 20),
                _drawerSubItem(Icons.close, "Cancelled", 21),
                _drawerSubItem(Icons.handshake_outlined, "Commissioned", 22),
                _drawerSubItem(Icons.done_all, "Completed", 23),
              ],
            ),

            /// Products (highlight if any subpage active)
            ExpansionTile(
              initiallyExpanded: _selectedIndex >= 24 && _selectedIndex <= 34,
              leading: Icon(Icons.inventory_2_outlined,
                  color: (_selectedIndex >= 24 && _selectedIndex <= 34)
                      ? Colors.green
                      : Colors.grey.shade600),
              title: Text("Products",
                  style: TextStyle(
                      fontWeight: (_selectedIndex >= 24 && _selectedIndex <= 34)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: (_selectedIndex >= 24 && _selectedIndex <= 34)
                          ? Colors.green
                          : Colors.black87)),
              children: [
                _drawerSubItem(Icons.inventory, "All Products", 24),
                _drawerSubItem(Icons.category, "General", 25),
                _drawerSubItem(Icons.devices_other, "Electronics", 26),
                _drawerSubItem(Icons.spa_outlined, "Health & Beauty", 27),
                _drawerSubItem(Icons.child_friendly, "Baby Products", 28),
                _drawerSubItem(Icons.videogame_asset_outlined, "Gaming Devices", 29),
                _drawerSubItem(Icons.checkroom_outlined, "Fashion (Cloths & Shoes)", 30),
                _drawerSubItem(Icons.phone_android_outlined, "Mobile Accessories", 31),
                _drawerSubItem(Icons.attach_money_outlined, "Expensive Products", 32),
                _drawerSubItem(Icons.pets_outlined, "Pet Related", 33),
                _drawerSubItem(Icons.kitchen_outlined, "Home & Kitchen", 34),
              ],
            ),

            /// Reservations (highlight if any subpage active)
            ExpansionTile(
              initiallyExpanded: _selectedIndex >= 35 && _selectedIndex <= 36,
              leading: Icon(Icons.event_note,
                  color: (_selectedIndex >= 35 && _selectedIndex <= 36)
                      ? Colors.green
                      : Colors.grey.shade600),
              title: Text("Reservations",
                  style: TextStyle(
                      fontWeight: (_selectedIndex >= 35 && _selectedIndex <= 36)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: (_selectedIndex >= 35 && _selectedIndex <= 36)
                          ? Colors.green
                          : Colors.black87)),
              children: [
                _drawerSubItem(Icons.add, "Add New", 35),
                _drawerSubItem(Icons.remove_red_eye_outlined, "Show", 36),
              ],
            ),

            _drawerMainItem(Icons.lock, "Change Password", 8),
            _drawerMainItem(Icons.person_outline, "User Profile", 9),
            _drawerMainItem(Icons.table_view, "Create Excel", 10),
            _drawerMainItem(Icons.support_agent, "Support", 11),
            _drawerMainItem(Icons.payment, "Check Blacklisted Paypal", 12),
            _drawerMainItem(Icons.timer_off, "Delay Refunds", 4),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
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
        leading: Icon(icon, color: isActive ? Colors.green : Colors.grey.shade600),
        title: Text(title,
            style: TextStyle(
                color: isActive ? Colors.green : Colors.black87,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        onTap: () => _onDrawerItemTapped(index),
      ),
    );
  }

  Widget _drawerSubItem(IconData icon, String title, int index) {
    bool isActive = _selectedIndex == index;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 72.w, right: 16.w),
      leading: Icon(icon, color: isActive ? Colors.green : Colors.grey.shade600),
      title: Text(title,
          style: TextStyle(
              color: isActive ? Colors.green : Colors.black87,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      onTap: () => _onDrawerItemTapped(index),
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
          Icon(icon, size: 24, color: isActive ? Colors.green : Colors.grey),
          if (isActive)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 2),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),
        ],
      ),
      label: '',
    );
  }
}
