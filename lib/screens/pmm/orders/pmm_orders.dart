import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMOrdersPage extends StatelessWidget {
  const PMMOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "PMM Orders",
        child: Center(
          child: Text("Welcome to PMM Orders", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
