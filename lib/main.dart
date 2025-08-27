import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';

// ----------------- COMMON -----------------
import 'screens/splash/screen/splash_screen.dart';
import 'screens/auth/login/login_screen.dart';

// ----------------- ADMIN -----------------
import 'screens/admin/dashboard/admin_dashboard.dart';

// ----------------- MANAGER -----------------
import 'screens/manager/dashboard/manager_dashboard.dart';

// ----------------- PMM -----------------
import 'screens/pmm/dashboard/pmm_dashboard.dart';

// ----------------- PM -----------------
import 'screens/pm/dashboard/pm_dashboard.dart';
import 'screens/pm/orders/pm_orders.dart';
import 'screens/pm/products/pm_products.dart';
import 'screens/pm/reservation/pm_reservation.dart';
import 'screens/pm/delayrefund/pm_delay_refund.dart';
import 'screens/pm/changepassword/pm_change_password.dart';
import 'screens/pm/excel/pm_excel.dart';
import 'screens/pm/pm_support.dart';
import 'screens/pm/blacklist/pm_blacklist.dart';
import 'screens/pm/products/product_detail_page.dart';

// ✅ Global ScaffoldMessengerKey for SnackBars
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const ZonifyProApp());
}

class ZonifyProApp extends StatelessWidget {
  const ZonifyProApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: "/splash",
      routes: [
        // ----------------- COMMON -----------------
        GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
        GoRoute(
          path: "/splash",
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) => const LoginScreen(),
        ),

        // ----------------- ADMIN -----------------
        GoRoute(
          path: "/admin/dashboard",
          builder: (context, state) => const AdminDashboardPage(),
        ),

        // ----------------- MANAGER -----------------
        GoRoute(
          path: "/manager/dashboard",
          builder: (context, state) => const ManagerDashboardPage(),
        ),

        // ----------------- PMM -----------------
        GoRoute(
          path: "/pmm/dashboard",
          builder: (context, state) => const PMMDashboardPage(),
        ),

        // ----------------- PM -----------------
        GoRoute(
          path: "/pm/dashboard",
          builder: (context, state) => const PMDashboardPage(),
        ),
        GoRoute(
          path: "/pm/orders",
          builder: (context, state) => const PMOrdersPage(),
        ),
        GoRoute(
          path: "/pm/products",
          builder: (context, state) => const PMProductsPage(category: "All"),
        ),
        GoRoute(
          path: "/pm/reservation",
          builder: (context, state) => const PMReservationPage(),
        ),
        GoRoute(
          path: "/pm/delay_refund",
          builder: (context, state) => const PMDelayRefundPage(),
        ),
        GoRoute(
          path: "/pm/change_password",
          builder: (context, state) => const PMChangePasswordPage(),
        ),
        GoRoute(
          path: "/pm/excel",
          builder: (context, state) => const PMExcelPage(),
        ),
        GoRoute(
          path: "/pm/support",
          builder: (context, state) => const PMSupportPage(),
        ),
        GoRoute(
          path: "/pm/blacklist",
          builder: (context, state) => const PMBlacklistPage(),
        ),

        // ----------------- PM SUBPAGE (Dynamic Product Detail) -----------------
        GoRoute(
          path: "/pm/products/:id",
          builder: (context, state) {
            return const ProductDetailPage(); // ✅ product data state.extra se milega
          },
        ),
      ],
    );

    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey, // ✅ attach key here
      title: 'ZonifyPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      routerConfig: router,
    );
  }
}
