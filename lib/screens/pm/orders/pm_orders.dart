import 'package:flutter/material.dart';
import '../../../layout/base_layout.dart';

class PMOrdersPage extends StatelessWidget {
  const PMOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      title: "Orders",
      child: Center(
        child: Text("PM Orders Page", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
