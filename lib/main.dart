import 'package:flutter/material.dart';
import 'core/theme.dart';

// Common Screens
import 'screens/splash/screen/splash_screen.dart';
import 'screens/auth/login/login_screen.dart';

// Admin Screens
import 'screens/admin/dashboard/admin_dashboard.dart';

// Manager Screens
import 'screens/manager/dashboard/manager_dashboard.dart';

// PMM Screens
import 'screens/pmm/dashboard/pmm_dashboard.dart';

// PM Screens
import 'screens/pm/dashboard/pm_dashboard.dart';
import 'screens/pm/orders/pm_orders.dart';
import 'screens/pm/products/pm_products.dart';
import 'screens/pm/reservation/pm_reservation.dart';
import 'screens/pm/delayrefund/pm_delay_refund.dart';
import 'screens/pm/changepassword/pm_change_password.dart';
import 'screens/pm/excel/pm_excel.dart';
import 'screens/pm/pm_support.dart';
import 'screens/pm/blacklist/pm_blacklist.dart';
import 'screens/pm/products/product_detail_page.dart'; // ✅ Product details

void main() {
  runApp(const ZonifyProApp());
}

class ZonifyProApp extends StatelessWidget {
  const ZonifyProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZonifyPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      initialRoute: "/splash",

      // ✅ Named Routes
      routes: {
        // ----------------- COMMON -----------------
        "/": (context) => const SplashScreen(),
        "/splash": (context) => const SplashScreen(),
        "/login": (context) => const LoginScreen(),

        // ----------------- ADMIN -----------------
        "/admin/dashboard": (context) => const AdminDashboardPage(),
        // 🔹 Future subpages for Admin
        // "/admin/user_detail": (context) => const AdminUserDetailPage(),

        // ----------------- MANAGER -----------------
        "/manager/dashboard": (context) => const ManagerDashboardPage(),
        // 🔹 Future subpages for Manager
        // "/manager/report_detail": (context) => const ManagerReportDetailPage(),

        // ----------------- PMM -----------------
        "/pmm/dashboard": (context) => const PMMDashboardPage(),
        // 🔹 Future subpages for PMM
        // "/pmm/analysis_detail": (context) => const PMMAnalysisDetailPage(),

        // ----------------- PM -----------------
        "/pm/dashboard": (context) => const PMDashboardPage(),
        "/pm/orders": (context) => const PMOrdersPage(),
        "/pm/products": (context) => const PMProductsPage(category: "All"),
        "/pm/reservation": (context) => const PMReservationPage(),
        "/pm/delay_refund": (context) => const PMDelayRefundPage(),
        "/pm/change_password": (context) => const PMChangePasswordPage(),
        "/pm/excel": (context) => const PMExcelPage(),
        "/pm/support": (context) => const PMSupportPage(),
        "/pm/blacklist": (context) => const PMBlacklistPage(),
      },

      // ✅ Dynamic Routes (subpages with arguments)
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // ----------------- PM SUBPAGES -----------------
          case "/pm/products/product_detail":
            final product = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product),
            );

          // ----------------- Future PM subpages -----------------
          // case "/pm/orders/order_detail":
          //   final order = settings.arguments as Map<String, dynamic>;
          //   return MaterialPageRoute(
          //     builder: (_) => PMOrderDetailPage(order: order),
          //   );

          // case "/pm/reservation/reservation_detail":
          //   final reservation = settings.arguments as Map<String, dynamic>;
          //   return MaterialPageRoute(
          //     builder: (_) => PMReservationDetailPage(reservation: reservation),
          //   );

          // case "/pm/support/ticket_detail":
          //   final ticket = settings.arguments as Map<String, dynamic>;
          //   return MaterialPageRoute(
          //     builder: (_) => PMSupportTicketDetailPage(ticket: ticket),
          //   );

          default:
            return null; // fallback handled by routes
        }
      },
    );
  }
}
