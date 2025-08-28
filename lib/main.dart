import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
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

// ✅ Simple auth state
bool isLoggedIn = false;
String? loggedInRole; // 👈 user ka role store karenge

void main() {
  usePathUrlStrategy(); // ✅ Web ke liye clean URLs
  runApp(const ZonifyProApp());
}

class ZonifyProApp extends StatelessWidget {
  const ZonifyProApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: "/splash",

      // ✅ redirect logic (auth guard)
      redirect: (context, state) {
        final goingTo = state.fullPath ?? "";

        if (!isLoggedIn &&
            (goingTo.startsWith("/pm") ||
                goingTo.startsWith("/admin") ||
                goingTo.startsWith("/manager") ||
                goingTo.startsWith("/pmm"))) {
          return "/login";
        }

        if (isLoggedIn &&
            (goingTo == "/login" || goingTo == "/splash" || goingTo == "/")) {
          switch (loggedInRole) {
            case "admin":
              return "/admin/dashboard";
            case "manager":
              return "/manager/dashboard";
            case "pmm":
              return "/pmm/dashboard";
            case "pm":
              return "/pm/dashboard";
            default:
              return "/login";
          }
        }

        return null;
      },

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

        // 👇 Products with nested detail route
        GoRoute(
          path: "/pm/products",
          builder: (context, state) => const PMProductsPage(category: "All"),
          routes: [
            GoRoute(
              path: ":id", // ✅ nested dynamic route
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? "";
                final data = state.extra as Map<String, dynamic>?;
                return ProductDetailPage(product: data, productId: id);
              },
            ),
          ],
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
      ],
    );

    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      title: 'ZonifyPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      routerConfig: router,
    );
  }
}
