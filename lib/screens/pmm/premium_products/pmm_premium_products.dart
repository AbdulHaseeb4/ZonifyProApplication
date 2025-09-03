import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMPremiumProductsPage extends StatelessWidget {
  const PMMPremiumProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "Premium Products",
        child: Center(
          child: Text(
            "Welcome to PMM Premium Products",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
