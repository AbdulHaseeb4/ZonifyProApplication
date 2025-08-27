import 'package:flutter/material.dart';
import '../../../layout/base_layout.dart';

class PMBlacklistPage extends StatelessWidget {
  const PMBlacklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      title: "Blacklist",
      role: "pm",
      userName: "PM User",
      profileUrl: "",
      child: Center(
        child: Text(
          "PM Blacklist Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
