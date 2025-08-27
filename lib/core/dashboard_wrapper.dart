import 'package:flutter/material.dart';

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
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      final role = args?["role"] ?? widget.defaultRole;
      final showMessage = args?["showMessage"] ?? false;

      if (showMessage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
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
