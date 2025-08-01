import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  final String subject;
  final List<Map<String, dynamic>> messages;

  const ChatScreen({super.key, required this.subject, required this.messages});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController replyController = TextEditingController();

  void sendReply() {
    if (replyController.text.trim().isNotEmpty) {
      setState(() {
        widget.messages.add({
          "from": "You",
          "message": replyController.text.trim(),
          "time": DateTime.now(),
        });
      });
      replyController.clear();
    }
  }

  String formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          title: Text(
            widget.subject,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
            onPressed: () => Navigator.pop(context),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6D9EEB), Color(0xFF3C78D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                final msg = widget.messages[index];
                final isMe = msg["from"] == "You";
                return Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Colors.blueAccent.withOpacity(0.8)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        msg["message"],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        formatTime(msg["time"]),
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildReplyBox(),
        ],
      ),
    );
  }

  Widget _buildReplyBox() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 8.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.r,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: replyController,
                  minLines: 1,
                  maxLines: 4,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: sendReply,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
