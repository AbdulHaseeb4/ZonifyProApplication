import 'package:flutter/material.dart';
import '../../../layout/base_layout.dart';

class PMDelayRefundPage extends StatelessWidget {
  const PMDelayRefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      title: "Delay Refund",
      child: Center(
        child: Text("PM Delay Refund Page", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
