import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navbar.dart';
import 'sidebar.dart';

class BaseLayout extends ConsumerStatefulWidget {
  final String title;
  final Widget child;

  const BaseLayout({super.key, required this.title, required this.child});

  @override
  ConsumerState<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends ConsumerState<BaseLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Navbar(
        title: widget.title,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: const Sidebar(),
      body: SafeArea(child: widget.child),
    );
  }
}
