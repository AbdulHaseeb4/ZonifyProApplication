import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final TextEditingController _searchController = TextEditingController();

  // 🔹 Scroll controllers class level par
  final ScrollController v = ScrollController();
  final ScrollController h = ScrollController();

  // 🔹 Order statuses for filter chips
  final List<String> orderStatuses = [
    "All",
    "Ordered",
    "Reviewed",
    "Review Submitted Pending Refund",
    "Review Deleted",
    "Refunded",
    "On Hold",
    "Refunded Pending Refund",
    "Cancelled",
    "Commissioned",
    "Completed",
  ];

  String selectedStatus = "All";

  // 🔹 Dummy orders
  final List<Map<String, String>> allOrders = [
    {
      "id": "101",
      "sellerId": "SELL123",
      "user": "Ali",
      "orderNo": "ORD-001",
      "productId": "PROD-001",
      "email": "ali@example.com",
      "market": "Amazon",
      "type": "Electronics",
      "createDate": "2025-08-19",
      "status": "Ordered"
    },
    {
      "id": "102",
      "sellerId": "SELL456",
      "user": "Sara",
      "orderNo": "ORD-002",
      "productId": "PROD-002",
      "email": "sara@example.com",
      "market": "eBay",
      "type": "Fashion",
      "createDate": "2025-08-18",
      "status": "Reviewed"
    },
    {
      "id": "103",
      "sellerId": "SELL789",
      "user": "Usman",
      "orderNo": "ORD-003",
      "productId": "PROD-003",
      "email": "usman@example.com",
      "market": "Daraz",
      "type": "Gadgets",
      "createDate": "2025-08-17",
      "status": "Review Submitted Pending Refund"
    },
    {
      "id": "104",
      "sellerId": "SELL321",
      "user": "Zara",
      "orderNo": "ORD-004",
      "productId": "PROD-004",
      "email": "zara@example.com",
      "market": "AliExpress",
      "type": "Beauty",
      "createDate": "2025-08-16",
      "status": "Review Deleted"
    },
    {
      "id": "105",
      "sellerId": "SELL654",
      "user": "Ahmed",
      "orderNo": "ORD-005",
      "productId": "PROD-005",
      "email": "ahmed@example.com",
      "market": "Amazon",
      "type": "Home & Kitchen",
      "createDate": "2025-08-15",
      "status": "Refunded"
    },
    {
      "id": "106",
      "sellerId": "SELL111",
      "user": "Iqra",
      "orderNo": "ORD-006",
      "productId": "PROD-006",
      "email": "iqra@example.com",
      "market": "Noon",
      "type": "Groceries",
      "createDate": "2025-08-14",
      "status": "On Hold"
    },
    {
      "id": "107",
      "sellerId": "SELL112",
      "user": "Bilal",
      "orderNo": "ORD-007",
      "productId": "PROD-007",
      "email": "bilal@example.com",
      "market": "Flipkart",
      "type": "Toys",
      "createDate": "2025-08-13",
      "status": "Refunded Pending Refund"
    },
    {
      "id": "108",
      "sellerId": "SELL113",
      "user": "Nida",
      "orderNo": "ORD-008",
      "productId": "PROD-008",
      "email": "nida@example.com",
      "market": "Snapdeal",
      "type": "Books",
      "createDate": "2025-08-12",
      "status": "Cancelled"
    },
    {
      "id": "109",
      "sellerId": "SELL114",
      "user": "Ahsan",
      "orderNo": "ORD-009",
      "productId": "PROD-009",
      "email": "ahsan@example.com",
      "market": "Daraz",
      "type": "Mobile",
      "createDate": "2025-08-11",
      "status": "Commissioned"
    },
    {
      "id": "110",
      "sellerId": "SELL115",
      "user": "Mehwish",
      "orderNo": "ORD-010",
      "productId": "PROD-010",
      "email": "mehwish@example.com",
      "market": "AliExpress",
      "type": "Fitness",
      "createDate": "2025-08-10",
      "status": "Completed"
    },
  ];

  // 🔹 Filtered list
  List<Map<String, String>> get _filteredOrders {
    List<Map<String, String>> filtered = selectedStatus == "All"
        ? allOrders
        : allOrders.where((o) => o["status"] == selectedStatus).toList();

    String query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered
          .where((o) => o["email"]!.toLowerCase().contains(query))
          .toList();
    }

    return filtered;
  }

  final List<double> _colW = <double>[
    50.w, 90.w, 90.w, 80.w, 90.w, 60.w, 160.w, 100.w, 90.w, 100.w, 140.w, 170.w
  ];

  Widget _h(String text, int i) => SizedBox(
    width: _colW[i],
    child: Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
    ),
  );

  DataCell _c(int i, String value) {
    final query = _searchController.text.toLowerCase();

    if (i == 6 && query.isNotEmpty && value.toLowerCase().contains(query)) {
      final lowerValue = value.toLowerCase();
      final startIndex = lowerValue.indexOf(query);
      final endIndex = startIndex + query.length;

      final before = value.substring(0, startIndex);
      final match = value.substring(startIndex, endIndex);
      final after = value.substring(endIndex);

      return DataCell(SizedBox(
        width: _colW[i],
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
              children: [
                TextSpan(text: before),
                TextSpan(
                  text: match,
                  style: const TextStyle(
                    backgroundColor: Colors.yellow,
                    color: Colors.black,
                  ),
                ),
                TextSpan(text: after),
              ],
            ),
          ),
        ),
      ));
    }

    return DataCell(SizedBox(
      width: _colW[i],
      child: Tooltip(
        message: value,
        child: Text(
          value,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    ));
  }

  // 🔹 Scroll to email column
  void _scrollToEmailColumn() {
    // Column index of "Email" = 6
    double offset = 0;
    for (int i = 0; i < 6; i++) {
      offset += _colW[i] + 18; // width + spacing
    }

    if (h.hasClients) {
      h.animateTo(
        offset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // 🔹 Report dialog
  void _showReportDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? selectedIssue;

        final issues = [
          "Refund delay",
          "Commission issue",
          "Less refund",
          "Other issue",
          "Dispute",
          "Wrong refund screenshot",
        ];

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔹 Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Select the ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                              TextSpan(
                                text: "issue!",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(Icons.close,
                                color: Colors.black87, size: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // 🔹 Issues grid
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 12.h,
                      children: issues.map((issue) {
                        final isSelected = selectedIssue == issue;
                        return ChoiceChip(
                          label: Text(issue,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500)),
                          selected: isSelected,
                          selectedColor: Colors.green.shade400,
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                          onSelected: (_) {
                            setState(() => selectedIssue = issue);
                          },
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 24.h),

                    // 🔹 Confirm button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedIssue == null
                            ? null
                            : () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Order $orderId reported for: $selectedIssue"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 16.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text("Confirm",
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 18.0;
    final double minTableWidth =
        _colW.reduce((a, b) => a + b) + spacing * (_colW.length - 1);

    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 12.h),

              // 🔹 Status Filter Chips
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  itemCount: orderStatuses.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final status = orderStatuses[index];
                    final isActive = selectedStatus == status;
                    return ChoiceChip(
                      label: Text(status, style: TextStyle(fontSize: 12.sp)),
                      selected: isActive,
                      selectedColor: Colors.green.shade400,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: isActive ? Colors.white : Colors.black87,
                        fontWeight:
                        isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) {
                        setState(() => selectedStatus = status);
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // 🔹 Orders Table
              Expanded(
                child: Scrollbar(
                  controller: v,
                  thickness: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: SingleChildScrollView(
                      controller: h,
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: minTableWidth),
                        child: SingleChildScrollView(
                          controller: v,
                          child: DataTable(
                            headingRowHeight: 48.h,
                            dataRowMinHeight: 56.h,
                            dataRowMaxHeight: 60.h,
                            horizontalMargin: 12.w,
                            columnSpacing: spacing.w,
                            dividerThickness: 0.4,
                            headingTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                            ),
                            headingRowColor: MaterialStateProperty.all(
                                const Color(0xffe4e6eb)),
                            columns: [
                              DataColumn(label: _h("ID", 0)),
                              DataColumn(label: _h("Product ID", 1)),
                              DataColumn(label: _h("Seller ID", 2)),
                              DataColumn(label: _h("User", 3)),
                              DataColumn(label: _h("Order No", 4)),
                              DataColumn(label: _h("Image", 5)),
                              DataColumn(label: _h("Email", 6)),
                              DataColumn(label: _h("Market", 7)),
                              DataColumn(label: _h("Type", 8)),
                              DataColumn(label: _h("Date", 9)),
                              DataColumn(label: _h("Status", 10)),
                              DataColumn(label: _h("Action", 11)),
                            ],
                            rows: _filteredOrders.asMap().entries.map((entry) {
                              final index = entry.key;
                              final order = entry.value;
                              final isEven = index % 2 == 0;

                              return DataRow(
                                color: MaterialStateProperty.all(
                                  isEven
                                      ? const Color(0xfffdfdfd)
                                      : const Color(0xfff0f2f5),
                                ),
                                cells: [
                                  _c(0, order["id"]!),
                                  _c(1, order["productId"]!),
                                  _c(2, order["sellerId"]!),
                                  _c(3, order["user"]!),
                                  _c(4, order["orderNo"]!),
                                  DataCell(Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Image.asset(
                                        'assets/images/sample.jpeg',
                                        width: 40.w,
                                        height: 40.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                                  _c(6, order["email"]!),
                                  _c(7, order["market"]!),
                                  _c(8, order["type"]!),
                                  _c(9, order["createDate"]!),
                                  _c(10, order["status"]!),
                                  DataCell(Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          Colors.orange.shade400,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 6.h),
                                          minimumSize: Size(70.w, 32.h),
                                          tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20.r),
                                          ),
                                        ),
                                        child: Text("View",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(width: 6.w),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showReportDialog(
                                              context, order["id"]!);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade400,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 6.h),
                                          minimumSize: Size(70.w, 32.h),
                                          tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20.r),
                                          ),
                                        ),
                                        child: Text("Report",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          prefixIcon:
          const Icon(Icons.search, color: Colors.green, size: 18),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear,
                color: Colors.redAccent, size: 18),
            onPressed: () {
              _searchController.clear();
              setState(() {});
              if (h.hasClients) {
                h.animateTo(0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              }
            },
          )
              : null,
          hintText: "Search by Email",
          hintStyle:
          TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty) {
            _scrollToEmailColumn();
          }
        },
      ),
    );
  }
}
