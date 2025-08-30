import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Providers
import '../providers/auth_provider.dart';

// COMMON
import '../screens/auth/login/login_screen.dart';

// ADMIN
import '../screens/admin/dashboard/admin_dashboard.dart';
import 'package:zonifypro/screens/admin/add_user/admin_create_user.dart';

// MANAGER
import '../screens/manager/dashboard/manager_dashboard.dart';

// PMM
import '../screens/pmm/dashboard/pmm_dashboard.dart';

// PM
import '../screens/pm/dashboard/pm_dashboard.dart';
import '../screens/pm/orders/pm_orders.dart';
import '../screens/pm/products/pm_products.dart';
import '../screens/pm/reservation/pm_reservation.dart';
import '../screens/pm/delayrefund/pm_delay_refund.dart';
import '../screens/pm/changepassword/pm_change_password.dart';
import '../screens/pm/excel/pm_excel.dart';
import '../screens/pm/pm_support.dart';
import '../screens/pm/blacklist/pm_blacklist.dart';
import '../screens/pm/products/product_detail_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authAsync = ref.watch(authStateProvider);
  final appUserAsync = ref.watch(appUserProvider);

  return GoRouter(
    initialLocation: "/login",
    debugLogDiagnostics: true,

    redirect: (context, state) {
      final goingTo = state.fullPath ?? "";
      final user = authAsync.value;
      final appUser = appUserAsync.value;

      // 🕑 Wait for both auth + user role
      if (authAsync.isLoading || appUserAsync.isLoading) return null;

      // ❌ If not logged in and trying to access dashboards → force login
      if (user == null &&
          (goingTo.startsWith("/pm") ||
              goingTo.startsWith("/admin") ||
              goingTo.startsWith("/manager") ||
              goingTo.startsWith("/pmm"))) {
        return "/login";
      }

      // ✅ If logged in & going to /login or / → send to correct dashboard
      if (user != null && (goingTo == "/login" || goingTo == "/")) {
        switch (appUser?.role) {
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

      return null; // ✅ allow navigation
    },

    routes: [
      // COMMON
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),

      // ADMIN
      GoRoute(
        path: "/admin/dashboard",
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: "/admin/create_user",
        builder: (context, state) => const AdminCreateUserPage(),
      ),

      // MANAGER
      GoRoute(
        path: "/manager/dashboard",
        builder: (context, state) => const ManagerDashboardPage(),
      ),

      // PMM
      GoRoute(
        path: "/pmm/dashboard",
        builder: (context, state) => const PMMDashboardPage(),
      ),

      // PM
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
        routes: [
          GoRoute(
            path: ":id",
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
});
