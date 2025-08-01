import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late List<Map<String, dynamic>> allAlerts;
  List<Map<String, dynamic>> displayedAlerts = [];

  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = "All";
  String searchKeyword = "";

  @override
  void initState() {
    super.initState();
    allAlerts = [
      {
        "title": "Task Delay Warning",
        "sender": "Admin",
        "time": DateTime.now().subtract(const Duration(minutes: 15)),
        "category": "Warning",
        "message": "Your last report submission was delayed.",
        "color": Colors.orangeAccent
      },
      {
        "title": "Incorrect Data Entry",
        "sender": "Admin",
        "time": DateTime.now().subtract(const Duration(hours: 1)),
        "category": "Critical",
        "message": "Data entered in sales sheet was incorrect.",
        "color": Colors.redAccent
      },
      {
        "title": "Policy Violation",
        "sender": "HR",
        "time": DateTime.now().subtract(const Duration(hours: 2)),
        "category": "Critical",
        "message": "Unauthorized access detected in the payroll system.",
        "color": Colors.redAccent
      },
      {
        "title": "Late Check-In",
        "sender": "Admin",
        "time": DateTime.now().subtract(const Duration(hours: 3)),
        "category": "Warning",
        "message": "You checked in late for your shift today.",
        "color": Colors.orangeAccent
      },
      {
        "title": "Appreciation Note",
        "sender": "Admin",
        "time": DateTime.now().subtract(const Duration(hours: 4)),
        "category": "Info",
        "message": "Good work on the last project milestone.",
        "color": Colors.blueAccent
      },
      {
        "title": "Low Disk Space Alert",
        "sender": "IT Support",
        "time": DateTime.now().subtract(const Duration(hours: 5)),
        "category": "System",
        "message": "Server storage usage has exceeded 85%.",
        "color": Colors.orangeAccent
      },
    ];
    displayedAlerts = List.from(allAlerts);
  }

  Future<void> _refreshAlerts() async {
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Alerts refreshed")),
    );
  }

  void _filterAndSearch() {
    List<Map<String, dynamic>> temp = allAlerts;
    if (selectedCategory != "All") {
      temp = temp.where((a) => a['category'] == selectedCategory).toList();
    }
    if (searchKeyword.isNotEmpty) {
      final key = searchKeyword.toLowerCase();
      temp = temp.where((a) {
        return a['title'].toLowerCase().contains(key) ||
            a['message'].toLowerCase().contains(key) ||
            a['sender'].toLowerCase().contains(key);
      }).toList();
    }
    setState(() => displayedAlerts = temp);
  }

  void _deleteAlert(int index) {
    final alert = displayedAlerts.removeAt(index);
    allAlerts.remove(alert);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${alert['title']} deleted")),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  Widget _highlightText(String text) {
    if (searchKeyword.isEmpty) return Text(text);
    final lower = text.toLowerCase();
    final keyword = searchKeyword.toLowerCase();
    if (!lower.contains(keyword)) return Text(text);

    final start = lower.indexOf(keyword);
    final end = start + keyword.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text.substring(0, start), style: const TextStyle(color: Colors.black)),
          TextSpan(
              text: text.substring(start, end),
              style: const TextStyle(color: Colors.black, backgroundColor: Colors.yellow)),
          TextSpan(text: text.substring(end), style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 42.h,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search alerts...",
                  prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(fontSize: 14.sp),
                onChanged: (value) {
                  searchKeyword = value;
                  _filterAndSearch();
                },
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Divider(thickness: 1.h),

          SizedBox(
            height: 36.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 8.w),
                _buildFilterChip("All"),
                SizedBox(width: 8.w),
                _buildFilterChip("Warning"),
                SizedBox(width: 8.w),
                _buildFilterChip("Critical"),
                SizedBox(width: 8.w),
                _buildFilterChip("Info"),
                SizedBox(width: 8.w),
                _buildFilterChip("System"),
                SizedBox(width: 8.w),
                _buildFilterChip("Other"),
                SizedBox(width: 8.w),
              ],
            ),
          ),
          Divider(thickness: 1.h),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAlerts,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0),
                itemCount: displayedAlerts.length,
                itemBuilder: (context, index) {
                  final alert = displayedAlerts[index];
                  return Dismissible(
                    key: Key(alert["title"] + index.toString()),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
                    ),
                    confirmDismiss: (_) async {
                      _deleteAlert(index);
                      return false;
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: alert['color'].withOpacity(0.2),
                          child: Icon(Icons.warning_amber_rounded,
                              color: alert['color'], size: 28.sp),
                        ),
                        title: _highlightText(alert['title']),
                        subtitle: _highlightText(alert['message']),
                        trailing: Text(_formatTime(alert['time']),
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = selectedCategory == label;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 13.sp)),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          selectedCategory = label;
          _filterAndSearch();
        });
      },
      selectedColor: Colors.blueAccent,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
    );
  }
}
