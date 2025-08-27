import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class ManagerDashboardPage extends StatelessWidget {
  const ManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "manager",
      child: BaseLayout(
        title: "Dashboard",
        role: "manager",
        userName: "Manager",
        profileUrl: "",
        child: Center(
          child: Text(
            "Welcome to Manager Dashboard",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
