import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMProfilePage extends StatelessWidget {
  const PMMProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "User Profile",
        child: Center(
          child: Text(
            "Welcome to PMM User Profile",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
