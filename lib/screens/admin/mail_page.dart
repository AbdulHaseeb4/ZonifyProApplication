import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/admin/menu_pages/chat_screen.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  late List<Map<String, dynamic>> allMails;
  List<Map<String, dynamic>> displayedMails = [];

  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = "All";
  String searchKeyword = "";

  @override
  void initState() {
    super.initState();
    allMails = [
      {
        "subject": "Meeting Reminder",
        "sender": "John Doe",
        "time": DateTime.now().subtract(const Duration(hours: 2)),
        "category": "Work",
        "messages": [
          {
            "from": "John Doe",
            "message": "Don't forget our meeting today at 3 PM",
            "time": DateTime.now().subtract(const Duration(hours: 2))
          },
        ]
      },
      {
        "subject": "HR Policy Update",
        "sender": "HR Department",
        "time": DateTime.now().subtract(const Duration(days: 2)),
        "category": "HR",
        "messages": [
          {
            "from": "HR Department",
            "message": "Please read the updated HR policies for 2025.",
            "time": DateTime.now().subtract(const Duration(days: 2, hours: 3))
          }
        ]
      },
    ];
    displayedMails = List.from(allMails);
  }

  Future<void> _refreshMails() async {
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Mail refreshed")));
  }

  void _filterAndSearch() {
    List<Map<String, dynamic>> temp = allMails;
    if (selectedCategory != "All") {
      temp = temp.where((mail) => mail['category'] == selectedCategory).toList();
    }
    if (searchKeyword.isNotEmpty) {
      temp = temp.where((mail) {
        final keyword = searchKeyword.toLowerCase();
        return mail['subject'].toLowerCase().contains(keyword) ||
            mail['sender'].toLowerCase().contains(keyword);
      }).toList();
    }
    setState(() => displayedMails = temp);
  }

  void _undoAction(Map<String, dynamic> mail, bool isArchive) {
    if (!allMails.contains(mail)) allMails.insert(0, mail);
    if (!displayedMails.contains(mail)) displayedMails.insert(0, mail);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isArchive ? "Archive undone" : "Delete undone")),
    );
  }

  void _archiveMail(int index) {
    final mail = displayedMails.removeAt(index);
    allMails.remove(mail);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${mail['subject']} archived")),
    );
  }

  void _deleteMail(int index) {
    final mail = displayedMails.removeAt(index);
    allMails.remove(mail);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${mail['subject']} deleted")),
    );
  }

  String formatTime(DateTime time) {
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

          /// --- Search Bar ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 42.h,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search mails...",
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

          /// --- Category Chips ---
          SizedBox(
            height: 36.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  _buildFilterChip("All"),
                  SizedBox(width: 8.w),
                  _buildFilterChip("Work"),
                  SizedBox(width: 8.w),
                  _buildFilterChip("HR"),
                  SizedBox(width: 8.w),
                  _buildFilterChip("System"),
                  SizedBox(width: 8.w),
                  _buildFilterChip("Personal"),
                ],
              ),
            ),
          ),

          Divider(thickness: 1.h),

          /// --- Mail List ---
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshMails,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0),
                itemCount: displayedMails.length,
                itemBuilder: (context, index) {
                  final mail = displayedMails[index];
                  return Dismissible(
                    key: Key(mail["subject"] + index.toString()),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.archive, color: Colors.white, size: 28.sp),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        _archiveMail(index);
                      } else {
                        _deleteMail(index);
                      }
                      return false;
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                subject: mail['subject'],
                                messages: mail['messages'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(14.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22.r,
                                backgroundColor: Colors.blueAccent.withOpacity(0.2),
                                child: Text(
                                  mail["sender"][0],
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _highlightText(mail["subject"]),
                                    SizedBox(height: 4.h),
                                    _highlightText(mail["sender"]),
                                  ],
                                ),
                              ),
                              Text(
                                formatTime(mail["time"]),
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
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
    final isSelected = selectedCategory == label;
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
