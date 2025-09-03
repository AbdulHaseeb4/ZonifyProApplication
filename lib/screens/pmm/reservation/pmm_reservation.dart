import 'package:flutter/material.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMReservationPage extends StatelessWidget {
  const PMMReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "PMM Reservation",
        child: Center(
          child: Text(
            "Welcome to PMM Reservation",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
