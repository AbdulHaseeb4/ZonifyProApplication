import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PMHomePage extends StatelessWidget {
  const PMHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth >= 900;

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

    /// grid count responsive
    int gridCount = screenWidth >= 1500
        ? 5 // Large screen: 5 cards per row
        : screenWidth >= 1200
        ? 4
        : screenWidth >= 800
        ? 3
        : 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                "Orders Overview",
                style: TextStyle(
                  fontSize: isWeb ? 28 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              /// Stats Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: isWeb ? 1.2 : 1.1, // Compact cards on web
                ),
                itemBuilder: (context, index) {
                  final item = stats[index];
                  final isUp = item["isUp"] as bool;
                  final icon = item["icon"] as IconData;

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: isUp ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: isUp
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          child: Icon(icon, color: isUp ? Colors.green : Colors.red),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item["title"] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8), // 👈 Spacer replaced with SizedBox
                        Row(
                          children: [
                            Text(
                              item["value"] as String,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Icon(
                              isUp ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isUp ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item["change"] as String,
                              style: TextStyle(
                                color: isUp ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              /// Completed Orders
              _buildCard(
                title: "Completed Orders",
                child: Column(
                  children: completedOrders.map((order) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order["id"]!),
                                Text("${order["customer"]} - ${order["date"]}",
                                    style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          Text(order["amount"]!,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              /// Order By Status
              _buildCard(
                title: "Order By Status",
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: PieChart(
                        PieChartData(
                          sections: orderStatusData.map((data) {
                            return PieChartSectionData(
                              value: (data["count"] as int).toDouble(),
                              color: data["color"] as Color,
                              radius: isWeb ? 80 : 60,
                              title: "${data["count"]}",
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: orderStatusData.map((data) {
                        return Row(
                          children: [
                            CircleAvatar(
                                radius: 5, backgroundColor: data["color"] as Color),
                            const SizedBox(width: 8),
                            Expanded(child: Text(data["status"] as String)),
                            Text("${data["count"]} Orders",
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

