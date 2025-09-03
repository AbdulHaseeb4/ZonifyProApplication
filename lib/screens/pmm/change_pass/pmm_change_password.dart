import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMChangePasswordPage extends StatelessWidget {
  const PMMChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "Change Password",
        child: Center(
          child: Text(
            "Welcome to PMM Change Password",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
