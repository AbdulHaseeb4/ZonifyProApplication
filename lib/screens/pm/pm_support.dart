import 'package:flutter/material.dart';
import '../../layout/base_layout.dart';

class PMSupportPage extends StatelessWidget {
  const PMSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      title: "Support",
      child: Center(
        child: Text("PM Support Page", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
