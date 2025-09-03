import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMSupportPage extends StatelessWidget {
  const PMMSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "Support",
        child: Center(
          child: Text(
            "Welcome to PMM Support Page",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
