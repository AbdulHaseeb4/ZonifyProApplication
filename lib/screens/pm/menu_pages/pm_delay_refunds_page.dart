import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PMDelayRefundsPage extends StatefulWidget {
  const PMDelayRefundsPage({super.key});

  @override
  State<PMDelayRefundsPage> createState() => _PMDelayRefundsPageState();
}

class _PMDelayRefundsPageState extends State<PMDelayRefundsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String searchKeyword = '';

  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> filteredOrders = [];

  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  double _progressValue = 0;

  static const int maxLimit = 100;

  /// Expanded fields per card
  final Map<int, Set<String>> expandedFields = {};

  @override
  void initState() {
    super.initState();

    /// Dummy data
    orders = List.generate(20, (index) {
      return {
        "name": "Seller ${index + 1}",
        "productId":
        "PRD-${100 + index}-SUPER-LONG-PRODUCT-ID-FOR-OVERFLOW-HANDLING-TEST-1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-END",
        "orderDate": "2025-08-${(index % 30) + 1}".padLeft(10, '0'),
        "delayedDays": (index % 10) + 1,
        "orderId":
        "ORD-${1000 + index}-EXTREMELY-LONG-ORDER-ID-FOR-UI-OVERFLOW-HANDLING-TESTING-PURPOSE-0987654321-ZYXWVUTSRQPONM-END",
      };
    });

    filteredOrders = List.from(orders);

    double progress = filteredOrders.length / maxLimit;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _progressAnimation =
    Tween<double>(begin: 0, end: progress).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {
          _progressValue = _progressAnimation.value;
        });
      });

    _animationController.forward();
  }

  void _filterOrders(String query) {
    setState(() {
      searchKeyword = query.trim().toLowerCase();
      if (searchKeyword.isEmpty) {
        filteredOrders = List.from(orders);
      } else {
        filteredOrders = orders.where((order) {
          final index = orders.indexOf(order) + 1;
          return index.toString().contains(searchKeyword) ||
              order["name"].toString().toLowerCase().contains(searchKeyword) ||
              order["productId"].toString().toLowerCase().contains(searchKeyword) ||
              order["orderId"].toString().toLowerCase().contains(searchKeyword);
        }).toList();
      }

      double progress = filteredOrders.length / maxLimit;
      _progressAnimation =
      Tween<double>(begin: _progressValue, end: progress).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ))
        ..addListener(() {
          setState(() {
            _progressValue = _progressAnimation.value;
          });
        });
      _animationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _highlightMatch(String text) {
    if (searchKeyword.isEmpty) {
      return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
    }
    final lowerText = text.toLowerCase();
    final startIndex = lowerText.indexOf(searchKeyword);
    if (startIndex == -1) {
      return Text(text, style: const TextStyle(fontWeight: FontWeight.bold));
    }

    final endIndex = startIndex + searchKeyword.length;
    final beforeMatch = text.substring(0, startIndex);
    final match = text.substring(startIndex, endIndex);
    final afterMatch = text.substring(endIndex);

    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: beforeMatch,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        TextSpan(
            text: match,
            style:
            const TextStyle(backgroundColor: Colors.yellow, color: Colors.black)),
        TextSpan(
            text: afterMatch,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressHeaderCard(),
              SizedBox(height: 6.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              SizedBox(height: 6.h),
              _buildSearchBar(),
              SizedBox(height: 6.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              SizedBox(height: 6.h),
              /// ---- Only List Scrolls ----
              Expanded(
                child: filteredOrders.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _buildInfoCard(order, index),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressHeaderCard() {
    double fullWidth = MediaQuery.of(context).size.width - 64.w;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A85B6), Color(0xFFBAC8E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pending Refund Orders",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 12.h),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 12.h,
                  width: fullWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 12.h,
                  width: fullWidth * _progressValue,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4e73df), Color(0xFF1cc88a)],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "Pending Refunds: ${filteredOrders.length}",
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(fontSize: 14.sp),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const Icon(Icons.search, color: Colors.green, size: 20),
          suffixIcon: searchKeyword.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, color: Colors.redAccent, size: 20),
            onPressed: () {
              _searchController.clear();
              _filterOrders('');
            },
          )
              : null,
          hintText: "Search by Seller Name",
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
        ),
        onChanged: _filterOrders,
      ),
    );
  }

  Widget _buildInfoCard(Map<String, dynamic> order, int index) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Text("${index + 1}",
                      style: const TextStyle(color: Colors.green)),
                ),
                SizedBox(width: 10.w),
                Expanded(child: _highlightMatch(order["name"].toString())),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(colors: [
                      order["delayedDays"] > 5
                          ? Colors.redAccent
                          : Colors.orangeAccent,
                      order["delayedDays"] > 5
                          ? Colors.red
                          : Colors.deepOrange
                    ]),
                  ),
                  child: Text("${order["delayedDays"]} Days",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildDetailRow(index, "productId", Icons.qr_code, Colors.deepPurple,
                "Product ID", order["productId"]),
            SizedBox(height: 6.h),
            _buildDetailRow(index, "orderId", Icons.receipt_long, Colors.blue,
                "Order ID", order["orderId"]),
            SizedBox(height: 6.h),
            _buildDetailRow(index, "orderDate", Icons.calendar_today,
                Colors.orange, "Order Date", order["orderDate"],
                showArrow: false),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12.h)),
                onPressed: () {},
                child: const Text("View Details",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(int index, String fieldKey, IconData icon,
      Color iconColor, String label, String value,
      {bool showArrow = true}) {
    bool isExpanded = expandedFields[index]?.contains(fieldKey) ?? false;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: iconColor),
        SizedBox(width: 8.w),
        Expanded(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Tooltip(
              message: value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700)),
                  Text(
                    value,
                    maxLines: isExpanded ? null : 1,
                    overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showArrow)
          IconButton(
            icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 18,
                color: Colors.grey),
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
          icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Copied to clipboard")));
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.inbox, size: 60.sp, color: Colors.grey.shade400),
            SizedBox(height: 12.h),
            Text("No pending refund orders",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600))
          ],
        ),
      ),
    );
  }
}
