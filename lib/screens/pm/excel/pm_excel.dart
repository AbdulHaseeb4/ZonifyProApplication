import 'package:flutter/material.dart';
import '../../../layout/base_layout.dart';

class PMExcelPage extends StatelessWidget {
  const PMExcelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      title: "Excel",
      role: "pm",
      userName: "PM User",
      profileUrl: "",
      child: Center(
        child: Text(
          "PM Excel Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
