import 'package:flutter/material.dart';
import 'navbar.dart';
import 'sidebar.dart';

class BaseLayout extends StatefulWidget {
  final String title;
  final String role;
  final String userName;
  final String? profileUrl;
  final Widget child;

  const BaseLayout({
    super.key,
    required this.title,
    required this.role,
    required this.userName,
    this.profileUrl,
    required this.child,
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  // 👇 Har BaseLayout apna unique Scaffold key rakhega
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Navbar(
        title: widget.title,
        role: widget.role,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: Sidebar(
        role: widget.role,
        userName: widget.userName,
        profileUrl: widget.profileUrl,
      ),
      body: SafeArea(child: widget.child),
    );
  }
}
