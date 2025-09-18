import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Providers
import '../providers/auth_provider.dart';

// COMMON
import '../screens/auth/login/login_screen.dart';

// ADMIN
import '../screens/admin/dashboard/admin_dashboard.dart';
import '../screens/admin/add_user/admin_create_user.dart';

// MANAGER
import '../screens/manager/dashboard/manager_dashboard.dart';

// PMM
import '../screens/pmm/dashboard/pmm_dashboard.dart';
import '../screens/pmm/add_product/pmm_add_product.dart';
import '../screens/pmm/change_pass/pmm_change_password.dart';
import '../screens/pmm/delay_refund/pmm_delay_refund.dart';
import '../screens/pmm/excel/pmm_excel.dart';
import '../screens/pmm/orders/pmm_orders.dart';
import '../screens/pmm/premium_products/pmm_premium_products.dart';
import '../screens/pmm/products/pmm_products.dart';
import '../screens/pmm/profile/pmm_profile.dart';
import '../screens/pmm/reservation/pmm_reservation.dart';
import '../screens/pmm/support/pmm_support.dart';

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

      // 🕑 Wait for auth + user role
      if (authAsync.isLoading || appUserAsync.isLoading) return null;

      // ❌ Not logged in but trying dashboard → force login
      if (user == null &&
          (goingTo.startsWith("/pm") ||
              goingTo.startsWith("/admin") ||
              goingTo.startsWith("/manager") ||
              goingTo.startsWith("/pmm"))) {
        return "/login";
      }

      // ✅ Logged in & on /login or / → redirect by role
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

      return null; // allow navigation
    },

    routes: [
      // COMMON
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),

      // ADMIN
      GoRoute(
        path: "/admin/dashboard",
        builder: (c, s) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: "/admin/create_user",
        builder: (c, s) => const AdminCreateUserPage(),
      ),

      // MANAGER
      GoRoute(
        path: "/manager/dashboard",
        builder: (c, s) => const ManagerDashboardPage(),
      ),

      // PMM
      GoRoute(
        path: "/pmm/dashboard",
        builder: (c, s) => const PMMDashboardPage(),
      ),
      GoRoute(path: "/pmm/orders", builder: (c, s) => const PMMOrdersPage()),
      GoRoute(
        path: "/pmm/products",
        builder: (c, s) => const PMMProductsPage(),
      ),
      GoRoute(
        path: "/pmm/add_product",
        builder: (c, s) => const PMMAddProductPage(),
      ),
      GoRoute(
        path: "/pmm/premium_products",
        builder: (c, s) => const PMMPremiumProductsPage(),
      ),
      GoRoute(
        path: "/pmm/reservation",
        builder: (c, s) => const PMMReservationPage(),
      ),
      GoRoute(
        path: "/pmm/change_password",
        builder: (c, s) => const PMMChangePasswordPage(),
      ),
      GoRoute(path: "/pmm/profile", builder: (c, s) => const PMMProfilePage()),
      GoRoute(path: "/pmm/excel", builder: (c, s) => const PMMExcelPage()),
      GoRoute(path: "/pmm/support", builder: (c, s) => const PMMSupportPage()),
      GoRoute(
        path: "/pmm/delay_refund",
        builder: (c, s) => const PMMDelayRefundPage(),
      ),

      // PM
      GoRoute(
        path: "/pm/dashboard",
        builder: (c, s) => const PMDashboardPage(),
      ),
      GoRoute(path: "/pm/orders", builder: (c, s) => const PMOrdersPage()),
      GoRoute(
        path: "/pm/products",
        builder: (c, s) => const PMProductsPage(category: "All"),
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
        builder: (c, s) => const PMReservationPage(),
      ),
      GoRoute(
        path: "/pm/delay_refund",
        builder: (c, s) => const PMDelayRefundPage(),
      ),
      GoRoute(
        path: "/pm/change_password",
        builder: (c, s) => const PMChangePasswordPage(),
      ),
      GoRoute(path: "/pm/excel", builder: (c, s) => const PMExcelPage()),
      GoRoute(path: "/pm/support", builder: (c, s) => const PMSupportPage()),
      GoRoute(
        path: "/pm/blacklist",
        builder: (c, s) => const PMBlacklistPage(),
      ),
    ],
  );
});
