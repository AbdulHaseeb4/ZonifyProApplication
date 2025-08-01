import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListPage extends StatefulWidget {
  final String userType;
  const UserListPage({super.key, required this.userType});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<String> users;
  late List<String> filteredUsers;
  late String title;
  late List<Color> gradientColors;

  @override
  void initState() {
    super.initState();

    final managers = ["Manager 1", "Manager 2", "Manager 3", "Manager 4", "Manager 5"];
    final pmms = ["PMM 1", "PMM 2", "PMM 3", "PMM 4", "PMM 5", "PMM 6", "PMM 7", "PMM 8"];
    final pms = [
      "PM 1", "PM 2", "PM 3", "PM 4", "PM 5",
      "PM 6", "PM 7", "PM 8", "PM 9", "PM 10",
      "PM 11", "PM 12", "PM 13", "PM 14", "PM 15"
    ];

    if (widget.userType == "manager") {
      users = managers;
      title = "Managers";
      gradientColors = [const Color(0xFF6D9EEB), const Color(0xFF3C78D8)];
    } else if (widget.userType == "pmm") {
      users = pmms;
      title = "PMM";
      gradientColors = [const Color(0xFF6D9EEB), const Color(0xFF3C78D8)];
    } else {
      users = pms;
      title = "Project Managers";
      gradientColors = [const Color(0xFF6D9EEB), const Color(0xFF3C78D8)];
    }

    filteredUsers = List.from(users);
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      filteredUsers = users.where((user) => user.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            "$title List",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4.r,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: TextField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: gradientColors[1], size: 20.sp),
                  hintText: "Search users...",
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
            ),
          ),
          Divider(height: 1.h, thickness: 1.h),

          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(), // no bounce or animation
              padding: EdgeInsets.all(12.w),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: gradientColors[0].withOpacity(0.2),
                      child: Icon(Icons.person, color: gradientColors[1], size: 20.sp),
                    ),
                    title: Text(
                      user,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: gradientColors[1],
                      ),
                    ),
                    subtitle: Text(
                      "Email: ${user.toLowerCase().replaceAll(' ', '')}@example.com",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$user clicked")),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
