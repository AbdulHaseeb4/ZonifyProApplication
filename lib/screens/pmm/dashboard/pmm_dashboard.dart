import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMDashboardPage extends StatelessWidget {
  const PMMDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "PMM Dashboard",
        child: Center(
          child: Text(
            "Welcome to PMM Dashboard",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
