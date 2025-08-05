import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class PMHomePage extends StatelessWidget {
  const PMHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"title": "Completed", "value": "0", "change": "0%", "isUp": true, "icon": Icons.check_circle},
      {"title": "Cancelled", "value": "1", "change": "9.09%", "isUp": false, "icon": Icons.cancel},
      {"title": "Refunded", "value": "7", "change": "63.63%", "isUp": false, "icon": Icons.undo},
      {"title": "Commissioned", "value": "0", "change": "0%", "isUp": true, "icon": Icons.trending_up},
      {"title": "Refund Pending", "value": "0", "change": "0%", "isUp": false, "icon": Icons.pending_actions},
      {"title": "Reviewed", "value": "0", "change": "0%", "isUp": true, "icon": Icons.reviews},
      {"title": "Ordered", "value": "2", "change": "18.18%", "isUp": true, "icon": Icons.shopping_cart},
      {"title": "Review Submitted", "value": "0", "change": "0%", "isUp": true, "icon": Icons.rate_review},
      {"title": "Review Deleted", "value": "1", "change": "9.09%", "isUp": false, "icon": Icons.delete_forever},
      {"title": "On Hold", "value": "0", "change": "0%", "isUp": false, "icon": Icons.pause_circle},
    ];

    final completedOrders = [
      {"id": "#10023", "customer": "John Doe", "date": "02 Aug", "amount": "\$120.00"},
      {"id": "#10022", "customer": "Sara Khan", "date": "01 Aug", "amount": "\$85.50"},
      {"id": "#10021", "customer": "Ali Raza", "date": "31 Jul", "amount": "\$65.00"},
    ];

    final orderStatusData = [
      {"status": "Completed", "count": 45, "color": Colors.green},
      {"status": "Pending", "count": 35, "color": Colors.orange},
      {"status": "Cancelled", "count": 15, "color": Colors.red},
      {"status": "Refunded", "count": 5, "color": Colors.blueGrey},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Title (No extra gap)
              Text(
                "Orders Overview",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),

              /// Stats Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1.25,
                ),
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  var item = stats[index];
                  bool isUp = item["isUp"] as bool;
                  IconData icon = item["icon"] as IconData;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(
                          width: 4.w,
                          color: isUp ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor:
                          (isUp ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1)),
                          child: Icon(icon, color: isUp ? Colors.green : Colors.red, size: 20.sp),
                        ),
                        SizedBox(height: 12.h),
                        Text(item["title"] as String,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800])),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(item["value"] as String,
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                            const Spacer(),
                            Icon(isUp ? Icons.arrow_upward : Icons.arrow_downward,
                                color: isUp ? Colors.green : Colors.red, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(item["change"] as String,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isUp ? Colors.green : Colors.red)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),

              /// Completed Orders Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Completed Orders",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12.h),
                    ...completedOrders.map((order) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order["id"]!,
                                      style: TextStyle(
                                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                  Text("${order["customer"]} - ${order["date"]}",
                                      style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                                ],
                              ),
                            ),
                            Text(order["amount"]!,
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    }).toList(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          // navigate to all orders screen
                        },
                        child: const Text("View All →"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              /// Order By Status Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order By Status",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 180.h,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: orderStatusData.map((data) {
                            return PieChartSectionData(
                              value: (data["count"] as int).toDouble(),
                              color: data["color"] as Color,
                              radius: 60,
                              title: "${data["count"]}%",
                              titleStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Column(
                      children: orderStatusData.map((data) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              CircleAvatar(radius: 5.r, backgroundColor: data["color"] as Color),
                              SizedBox(width: 8.w),
                              Expanded(
                                  child: Text(data["status"] as String,
                                      style: TextStyle(fontSize: 14.sp))),
                              Text("${data["count"]} Orders",
                                  style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
