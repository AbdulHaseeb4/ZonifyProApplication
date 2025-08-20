import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zonifypro/screens/pm/menu_pages/orders/order_create_page.dart';

class ShowReservationPage extends StatefulWidget {
  const ShowReservationPage({super.key});

  /// 🔹 Static global reservation list (accessible from PMProductsPage)
  static List<Map<String, dynamic>> reservations = [];

  @override
  State<ShowReservationPage> createState() => _ShowReservationPageState();
}

class _ShowReservationPageState extends State<ShowReservationPage> {
  Timer? _timer;

  /// Track expanded fields for each reservation
  final Map<int, Set<String>> expandedFields = {};

  @override
  void initState() {
    super.initState();
    // ⏱️ Timer to update countdown for each reservation
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (var r in ShowReservationPage.reservations) {
          if (r["remaining"] > Duration.zero) {
            r["remaining"] = r["remaining"] - const Duration(seconds: 1);
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

  /// Format countdown duration into HH:MM:SS
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final reservations = ShowReservationPage.reservations;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: reservations.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final r = reservations[index];
            return _buildReservationCard(r, index);
          },
        ),
      ),
    );
  }

  /// 🔹 Reservation Card UI
  Widget _buildReservationCard(Map<String, dynamic> r, int index) {
    final Duration remaining = r["remaining"];
    final bool isCritical = remaining.inMinutes < 10;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      margin: EdgeInsets.only(bottom: 20.h),
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Top Image ---
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePreview(context, r["image"]);
                },
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    r["image"],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isCritical
                        ? Colors.red.withOpacity(0.9)
                        : Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    _formatDuration(remaining),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          /// --- Bottom Details ---
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ---- Seller Name ----
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        color: Colors.blueAccent, size: 20),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "Seller : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: r["sellerName"] ?? "Unknown Seller",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                /// ---- Reservation ID ----
                _buildDetailRow(index, "reservationId",
                    Icons.confirmation_num_outlined, "Reservation ID",
                    r["reservationId"]),
                SizedBox(height: 10.h),

                /// ---- Product ID ----
                _buildDetailRow(index, "productId", Icons.qr_code, "Product ID",
                    r["productId"]),
                SizedBox(height: 16.h),

                /// ---- Buttons ----
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderCreatePage(reservation: r),
                            ),
                          );
                        },

                        child: const Text("Create Order",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        onPressed: () {
                          setState(() {
                            ShowReservationPage.reservations.removeAt(index);
                          });
                        },
                        child: const Text("Release",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Detail row with proper alignment
  Widget _buildDetailRow(
      int index, String fieldKey, IconData icon, String label, String value) {
    bool isExpanded = expandedFields[index]?.contains(fieldKey) ?? false;
    bool isExpandable = value.length > 25;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.deepPurple),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: Colors.black)),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    value,
                    maxLines: isExpandable && !isExpanded ? 1 : null,
                    overflow: isExpandable && !isExpanded
                        ? TextOverflow.ellipsis
                        : TextOverflow.visible,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          if (isExpandable)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.orange),
              onPressed: () {
                setState(() {
                  expandedFields[index] ??= {};
                  if (isExpanded) {
                    expandedFields[index]!.remove(fieldKey);
                  } else {
                    expandedFields[index]!.add(fieldKey);
                  }
                });
              },
            ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.copy, size: 20, color: Colors.green),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$label copied to clipboard")));
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 Image Preview Dialog
  void _showImagePreview(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          insetPadding: EdgeInsets.all(10.w),
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 4,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        );
      },
    );
  }

  /// 🔹 Empty state UI
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64.sp, color: Colors.grey.shade400),
          SizedBox(height: 12.h),
          Text("No reservations found",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
