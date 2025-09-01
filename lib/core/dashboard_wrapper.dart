import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ✅ GoRouter import
import '../main.dart'; // ✅ global key access

class DashboardWrapper extends StatefulWidget {
  final Widget child;
  final String defaultRole;

  const DashboardWrapper({
    super.key,
    required this.child,
    required this.defaultRole,
  });

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  bool _messageShown = false; // ✅ ensure one-time only

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_messageShown) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

      final role = extra?["role"] ?? widget.defaultRole;
      final showMessage = extra?["showMessage"] ?? false;

      if (showMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text("Login Successful as $role"),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      }

      _messageShown = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
