import 'package:flutter/material.dart';
import '../../../layout/base_layout.dart';

class PMChangePasswordPage extends StatelessWidget {
  const PMChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      title: "Change Password",
      child: Center(
        child: Text("PM Change Password Page", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
