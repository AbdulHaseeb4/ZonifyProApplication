import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zonifypro/core/theme.dart';

class Sidebar extends StatelessWidget {
  final String role;
  final String userName;
  final String? profileUrl;

  const Sidebar({
    super.key,
    required this.role,
    required this.userName,
    this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = _getMenuItems(role);
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      width: 230,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.lavender, AppTheme.mint],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        (profileUrl != null && profileUrl!.isNotEmpty)
                        ? NetworkImage(profileUrl!)
                        : null,
                    backgroundColor: Colors.white24,
                    child: (profileUrl == null || profileUrl!.isEmpty)
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: menuItems.map((item) {
                  final isActive = currentRoute == item['route'];

                  return _SidebarTile(
                    icon: item['icon'],
                    text: item['text'],
                    isActive: isActive,
                    onTap: () {
                      Navigator.pop(context);
                      if (currentRoute != item['route']) {
                        // ✅ Replace instead of push
                        Navigator.pushNamed(context, item['route'] as String);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getMenuItems(String role) {
    switch (role.toLowerCase()) {
      case "pm":
        return [
          {
            "icon": Icons.dashboard,
            "text": "Dashboard",
            "route": "/pm/dashboard",
          },
          {
            "icon": Icons.shopping_cart,
            "text": "Orders",
            "route": "/pm/orders",
          },
          {
            "icon": Icons.inventory,
            "text": "Products",
            "route": "/pm/products",
          },
          {
            "icon": Icons.bookmark_added,
            "text": "Reservation",
            "route": "/pm/reservation",
          },
          {
            "icon": Icons.timer,
            "text": "Delay Refund",
            "route": "/pm/delay_refund",
          },
          {
            "icon": Icons.lock_reset,
            "text": "Change Password",
            "route": "/pm/change_password",
          },
          {"icon": Icons.table_view, "text": "Excel", "route": "/pm/excel"},
          {
            "icon": Icons.support_agent,
            "text": "Support",
            "route": "/pm/support",
          },
          {"icon": Icons.block, "text": "Blacklist", "route": "/pm/blacklist"},
        ];
      case "pmm":
        return [
          {
            "icon": Icons.dashboard,
            "text": "Dashboard",
            "route": "/pmm/dashboard",
          },
        ];
      case "manager":
        return [
          {
            "icon": Icons.dashboard,
            "text": "Dashboard",
            "route": "/manager/dashboard",
          },
        ];
      case "admin":
        return [
          {
            "icon": Icons.dashboard,
            "text": "Dashboard",
            "route": "/admin/dashboard",
          },
        ];
      default:
        return [
          {"icon": Icons.error, "text": "No Options", "route": "/"},
        ];
    }
  }
}

class _SidebarTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.icon,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive
        ? AppTheme.lavender
        : (_isHovered
              ? AppTheme.lavender.withValues(alpha: 0.85)
              : AppTheme.textPrimary);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.lavender.withValues(alpha: 0.07)
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: widget.isActive
              ? const Border(
                  left: BorderSide(color: AppTheme.lavender, width: 3),
                )
              : null,
        ),
        transform: Matrix4.identity()
          ..scaleByDouble(
            _isHovered ? 1.04 : 1.0,
            _isHovered ? 1.04 : 1.0,
            1.0,
            1.0,
          ),
        child: ListTile(
          dense: true,
          horizontalTitleGap: 8,
          minLeadingWidth: 26,
          leading: Icon(widget.icon, color: color, size: 18),
          title: Text(
            widget.text,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
              color: color,
            ),
          ),
          onTap: widget.onTap,
          trailing: AnimatedOpacity(
            opacity: (_isHovered || widget.isActive) ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.chevron_right,
              size: 15,
              color: AppTheme.lavender,
            ),
          ),
        ),
      ),
    );
  }
}
