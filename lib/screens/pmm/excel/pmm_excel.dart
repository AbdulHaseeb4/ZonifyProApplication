import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMExcelPage extends StatelessWidget {
  const PMMExcelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "Excel Export",
        child: Center(
          child: Text(
            "Welcome to PMM Excel Page",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
