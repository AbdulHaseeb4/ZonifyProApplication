import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMAddProductPage extends StatelessWidget {
  const PMMAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "Add Product",
        child: Center(
          child: Text(
            "Welcome to PMM Add Product",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
