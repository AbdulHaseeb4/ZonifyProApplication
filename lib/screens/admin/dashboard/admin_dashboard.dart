import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "admin",
      child: BaseLayout(
        title: "Dashboard",
        role: "admin",
        userName: "Admin",
        profileUrl: "",
        child: Center(
          child: Text(
            "Welcome to Admin Dashboard",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
