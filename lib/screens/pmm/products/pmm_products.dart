import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMProductsPage extends StatelessWidget {
  const PMMProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "PMM Products",
        child: Center(
          child: Text(
            "Welcome to PMM Products",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
