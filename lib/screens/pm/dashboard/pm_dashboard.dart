import 'package:flutter/material.dart';
import 'package:zonifypro/core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMDashboardPage extends StatelessWidget {
  const PMDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pm",
      child: BaseLayout(
        title: "PM Dashboard",
        child: Center(
          child: Text(
            "Welcome to PM Dashboard",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
