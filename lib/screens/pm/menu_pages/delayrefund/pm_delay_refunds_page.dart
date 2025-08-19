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

  /// Expanded fields per card (index-based for this list)
  final Map<int, Set<String>> expandedFields = {};

  /// ---------- Dynamic Capacity Tiers ----------
  /// Adjust tiers as you like (e.g., >20 => cap 30 etc.)
  final List<Map<String, int>> _capacityTiers = [
    {"max": 5, "cap": 20},   // up to 5 => cap 20
    {"max": 20, "cap": 40},  // 6..20 => cap 40
    {"max": 50, "cap": 60},  // 21..50 => cap 60
    {"max": 100, "cap": 100} // 51..100 => cap 100
  ];

  int _capacityForCount(int n) {
    for (final t in _capacityTiers) {
      if (n <= t["max"]!) return t["cap"]!;
    }
    // After 100, grow in 50-steps (150, 200, ...)
    final steps = ((n - 1) / 50).floor();
    return 100 + (steps + 1) * 50;
  }

  @override
  void initState() {
    super.initState();

    /// Dummy data with product image
    orders = List.generate(20, (index) {
      return {
        "name": "Seller ${index + 1}",
        "productId":
        "PRD-${100 + index}-SUPER-LONG-PRODUCT-ID-FOR-OVERFLOW-HANDLING-TEST-1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-END",
        "orderDate": "2025-08-${(index % 30) + 1}".padLeft(10, '0'),
        "delayedDays": (index % 10) + 1,
        "orderId":
        "ORD-${1000 + index}-EXTREMELY-LONG-ORDER-ID-FOR-UI-OVERFLOW-HANDLING-TESTING-PURPOSE-0987654321-ZYXWVUTSRQPONM-END",
        "image": "assets/images/sample.jpeg",
      };
    });

    filteredOrders = List.from(orders);

    final int cap = _capacityForCount(filteredOrders.length);
    final double progress =
    (cap == 0) ? 0 : (filteredOrders.length / cap).clamp(0, 1);

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

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
          return order["name"]
              .toString()
              .toLowerCase()
              .contains(searchKeyword) ||
              order["productId"]
                  .toString()
                  .toLowerCase()
                  .contains(searchKeyword) ||
              order["orderId"]
                  .toString()
                  .toLowerCase()
                  .contains(searchKeyword);
        }).toList();
      }

      final int cap = _capacityForCount(filteredOrders.length);
      final double progress =
      (cap == 0) ? 0 : (filteredOrders.length / cap).clamp(0, 1);

      _progressAnimation = Tween<double>(begin: _progressValue, end: progress)
          .animate(CurvedAnimation(
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
    _searchController.dispose();
    super.dispose();
  }

  Widget _highlightMatch(String text) {
    if (searchKeyword.isEmpty) {
      return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
    }
    final lowerText = text.toLowerCase();
    final startIndex = lowerText.indexOf(searchKeyword);
    if (startIndex == -1) {
      return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
    }

    final endIndex = startIndex + searchKeyword.length;
    final beforeMatch = text.substring(0, startIndex);
    final match = text.substring(startIndex, endIndex);
    final afterMatch = text.substring(endIndex);

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: beforeMatch,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        TextSpan(
          text: match,
          style: const TextStyle(backgroundColor: Colors.yellow, color: Colors.black),
        ),
        TextSpan(
          text: afterMatch,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSlimProgressHeaderCard(),
              SizedBox(height: 4.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              SizedBox(height: 4.h),
              _buildSearchBar(),
              SizedBox(height: 4.h),
              Divider(color: Colors.grey.shade300, thickness: 1),
              SizedBox(height: 4.h),
              Expanded(
                child: filteredOrders.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _buildInfoCard(order, index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// SLIM header: less padding, smaller text, thinner bar, only number shown
  Widget _buildSlimProgressHeaderCard() {
    final fullWidth = MediaQuery.of(context).size.width - 24.w - 24.w; // padding both sides
    final int count = filteredOrders.length;
    final int cap = _capacityForCount(count);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF6A85B6), Color(0xFFBAC8E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title & number on same row (small fonts)
            Row(
              children: [
                const Text(
                  "Pending Refund Orders",
                  style: TextStyle(
                    fontSize: 13, // smaller title
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                // ONLY NUMBER (no "/ cap")
                Text(
                  "$count",
                  style: const TextStyle(
                    fontSize: 14, // slightly bigger to pop
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 6.h, // thinner bar
                  width: fullWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white.withOpacity(0.28),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 6.h,
                  width: fullWidth * _progressValue, // animated fill
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4e73df), Color(0xFF1cc88a)],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(fontSize: 13.sp),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const Icon(Icons.search, color: Colors.green, size: 18),
          suffixIcon: searchKeyword.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, color: Colors.redAccent, size: 18),
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

  /// CARD with product image on top, days badge at corner, seller row one-line
  Widget _buildInfoCard(Map<String, dynamic> order, int index) {
    final int delayedDays = order["delayedDays"] as int? ?? 0;
    final String imagePath = order["image"] as String? ?? '';

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Top Image with badge ---
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: GestureDetector(
                  onTap: () => _showImagePreview(context, imagePath),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: Color(0xFFEAF1F7),
                      child: Center(
                        child: Icon(Icons.broken_image_outlined, size: 40),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    gradient: LinearGradient(colors: [
                      delayedDays > 7 ? Colors.redAccent : Colors.orangeAccent,
                      delayedDays > 7 ? Colors.red : Colors.deepOrange,
                    ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "$delayedDays Days",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// --- Bottom content ---
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Seller Name: one-line (no copy/arrow)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.store_outlined, size: 18, color: Colors.green),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        "Seller Name: ${order["name"]}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                _buildDetailRow(
                  index,
                  "productId",
                  Icons.qr_code,
                  Colors.deepPurple,
                  "Product ID",
                  order["productId"],
                ),
                SizedBox(height: 6.h),

                _buildDetailRow(
                  index,
                  "orderId",
                  Icons.receipt_long,
                  Colors.blue,
                  "Order ID",
                  order["orderId"],
                ),
                SizedBox(height: 6.h),

                _buildDetailRow(
                  index,
                  "orderDate",
                  Icons.calendar_today,
                  Colors.orange,
                  "Order Date",
                  order["orderDate"],
                  showArrow: false,
                ),

                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "View Details",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      int index,
      String fieldKey,
      IconData icon,
      Color iconColor,
      String label,
      String value, {
        bool showArrow = true,
      }) {
    final isExpanded = expandedFields[index]?.contains(fieldKey) ?? false;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: iconColor),
        SizedBox(width: 6.w),
        Expanded(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Tooltip(
              message: value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                  Text(
                    value,
                    maxLines: isExpanded ? null : 1,
                    overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.5.sp, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showArrow)
          IconButton(
            icon: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.grey,
            ),
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
        // Copy allowed for these detail fields (not for seller name)
        IconButton(
          icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: value));
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Copied to clipboard")),
            );
          },
        ),
      ],
    );
  }

  void _showImagePreview(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          insetPadding: EdgeInsets.all(8.w),
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 4,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox(
                height: 200,
                child: Center(
                  child: Icon(Icons.broken_image_outlined, size: 40),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.inbox, size: 52.sp, color: Colors.grey.shade400),
            SizedBox(height: 8.h),
            Text(
              "No pending refund orders",
              style: TextStyle(fontSize: 14.5.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
