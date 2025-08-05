import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationStyledCardPage extends StatefulWidget {
  const ReservationStyledCardPage({super.key});

  @override
  State<ReservationStyledCardPage> createState() =>
      _ReservationStyledCardPageState();
}

class _ReservationStyledCardPageState extends State<ReservationStyledCardPage> {
  final List<Map<String, dynamic>> reservations = [
    {
      "seller": "Seller 1",
      "productId": "PRD-100-SUPER-LONG-PRODUCT-ID-EXAMPLE-1234567890",
      "orderId": "ORD-1000-EXTREMELY-LONG-ORDER-ID-EXAMPLE-1234567890",
      "orderDate": "2025-08-01",
      "image": "assets/images/profile.png", // use your product image here
      "remaining": const Duration(hours: 1, minutes: 15, seconds: 45),
    }
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (var r in reservations) {
          final Duration rem = r["remaining"];
          if (rem > Duration.zero) {
            r["remaining"] = rem - const Duration(seconds: 1);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final r = reservations[index];
            return _buildReservationCard(r, index);
          },
        ),
      ),
    );
  }

  Widget _buildReservationCard(Map<String, dynamic> r, int index) {
    final Duration remaining = r["remaining"];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---- Header ----
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Text("${index + 1}",
                      style: const TextStyle(color: Colors.green)),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(r["seller"],
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange]),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(_formatDuration(remaining),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            /// ---- Main Image ----
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(r["image"], width: 150.w, height: 100.h),
              ),
            ),

            SizedBox(height: 16.h),

            /// ---- Details ----
            _buildDetailRow(Icons.qr_code, "Product ID", r["productId"]),
            SizedBox(height: 8.h),
            _buildDetailRow(Icons.receipt_long, "Order ID", r["orderId"]),
            SizedBox(height: 8.h),
            _buildDetailRow(Icons.calendar_today, "Order Date", r["orderDate"],
                expandArrow: false),

            SizedBox(height: 16.h),

            /// ---- Bottom Buttons ----
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r))),
                    onPressed: () {},
                    child: const Text("Create Order"),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r))),
                    onPressed: () {},
                    child: const Text("Release"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value,
      {bool expandArrow = true}) {
    bool isExpanded = false; // you can implement expand logic per field
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.green.shade700)),
              Text(
                value,
                maxLines: isExpanded ? null : 1,
                overflow: isExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        if (expandArrow)
          Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
        IconButton(
            icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
            onPressed: () {})
      ],
    );
  }
}
