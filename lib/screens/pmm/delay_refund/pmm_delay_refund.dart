import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMDelayRefundPage extends StatelessWidget {
  const PMMDelayRefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "Delay Refunds",
        child: Center(
          child: Text(
            "Welcome to PMM Delay Refunds Page",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
