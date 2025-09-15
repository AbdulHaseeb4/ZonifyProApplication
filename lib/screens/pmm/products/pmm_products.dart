// ✅ Final Code: Only your 3 required changes. Baqi sab same hai.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zonifypro/core/theme.dart';
import 'package:zonifypro/screens/pm/reservation/pm_reservation.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMProductsPage extends StatefulWidget {
  const PMMProductsPage({super.key});

  @override
  State<PMMProductsPage> createState() => _PMMProductsPageState();
}

class _PMMProductsPageState extends State<PMMProductsPage> {
  String selectedCategory = "All";

  final List<Map<String, dynamic>> categories = const [
    {"label": "All", "count": 150},
    {"label": "General", "count": 20},
    {"label": "Electronics", "count": 30},
    {"label": "Pet Related", "count": 7},
    {"label": "Baby Products", "count": 10},
    {"label": "Gaming Devices", "count": 8},
    {"label": "Home Kitchen", "count": 18},
    {"label": "Health & Beauty", "count": 15},
    {"label": "Mobile Accessories", "count": 25},
    {"label": "Expensive Products", "count": 5},
    {"label": "Fashion (Clothes & Shoes)", "count": 12},
  ];

  List<Map<String, dynamic>> products = [
    {
      "category": "General",
      "seller": "S101",
      "market": "US",
      "saleLimit": "50",
      "todayRemain": "25",
      "totalRemain": "30",
      "commission": "1000",
      "keywords": "Headphones, Audio",
      "link": "https://example.com/product1",
      "productId": "PRD-001",
    },
    {
      "category": "Electronics",
      "seller": "S102",
      "market": "UK",
      "saleLimit": "60",
      "todayRemain": "40",
      "totalRemain": "50",
      "commission": "1200",
      "keywords": "Mobile Charger",
      "link": "https://example.com/product2",
      "productId": "PRD-002",
    },
  ];

  final List<double> _colW = [90, 70, 80, 90, 90, 90, 130, 200, 90, 70, 180];

  Widget _h(String text, int i, {bool isMobile = false}) => SizedBox(
    width: _colW[i],
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: isMobile ? 11 : 13,
          color: Colors.black87,
        ),
      ),
    ),
  );

  DataCell _c(int i, Widget child) => DataCell(
    SizedBox(
      width: _colW[i],
      child: Center(child: child),
    ),
  );

  Widget _highlightText(String text, {bool isMobile = false}) {
    return Text(text, style: TextStyle(fontSize: isMobile ? 11 : 12));
  }

  @override
  Widget build(BuildContext context) {
    return DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "PMM Products",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: TextField(
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Search by keywords, Product ID, seller ID",
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => context.go("/pmm/add_product"),
                    icon: const Icon(Icons.add, size: 14, color: Colors.white),
                    label: const Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    final String label = cat['label'] as String;
                    final int count = cat['count'] as int;
                    final bool isSelected = selectedCategory == label;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => setState(() => selectedCategory = label),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.horizontal(
                                    left: const Radius.circular(7),
                                    right: isSelected
                                        ? const Radius.circular(7)
                                        : Radius.zero,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    if (isSelected)
                                      const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    if (isSelected) const SizedBox(width: 6),
                                    Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected) const SizedBox(width: 8),
                              if (isSelected)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    count.toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width - 32,
                          ),
                          child: _buildProductTable(
                            MediaQuery.of(context).size.width < 600,
                          ),
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
    );
  }

  Widget _buildProductTable(bool isMobile) {
    final filteredProducts = selectedCategory == "All"
        ? products
        : products.where((p) => p['category'] == selectedCategory).toList();

    return DataTable(
      headingRowColor: WidgetStateProperty.all(
        Colors.grey[300],
      ), // ✅ Grey heading
      dividerThickness: 0,
      columns: [
        DataColumn(label: _h('Seller', 0, isMobile: isMobile)),
        DataColumn(label: _h('Market', 1, isMobile: isMobile)),
        DataColumn(label: _h('Sale Limit', 2, isMobile: isMobile)),
        DataColumn(label: _h('Today Remain', 3, isMobile: isMobile)),
        DataColumn(label: _h('Total Remain', 4, isMobile: isMobile)),
        DataColumn(label: _h('Commission', 5, isMobile: isMobile)),
        DataColumn(label: _h('Keywords', 6, isMobile: isMobile)),
        DataColumn(label: _h('Product Link', 7, isMobile: isMobile)),
        DataColumn(label: _h('Product ID', 8, isMobile: isMobile)),
        DataColumn(label: _h('Image', 9, isMobile: isMobile)),
        DataColumn(label: _h('Actions', 10, isMobile: isMobile)),
      ],
      rows: List<DataRow>.generate(filteredProducts.length, (index) {
        final p = filteredProducts[index];
        final alreadyReserved = PMReservationPage.reservations.any(
          (r) => r['productId'] == p['productId'],
        );

        return DataRow(
          color: WidgetStateProperty.all(
            index.isEven ? Colors.white : Colors.grey[200],
          ), // ✅ Alternate rows
          cells: [
            _c(0, _highlightText(p['seller'], isMobile: isMobile)),
            _c(
              1,
              Text(p['market'], style: TextStyle(fontSize: isMobile ? 11 : 12)),
            ),
            _c(
              2,
              Text(
                p['saleLimit'],
                style: TextStyle(fontSize: isMobile ? 11 : 12),
              ),
            ),
            _c(
              3,
              Text(
                p['todayRemain'],
                style: TextStyle(fontSize: isMobile ? 11 : 12),
              ),
            ),
            _c(
              4,
              Text(
                p['totalRemain'],
                style: TextStyle(fontSize: isMobile ? 11 : 12),
              ),
            ),
            _c(
              5,
              Text(
                'PKR ${p['commission']}',
                style: TextStyle(fontSize: isMobile ? 11 : 12),
              ),
            ),
            _c(6, _highlightText(p['keywords'], isMobile: isMobile)),
            _c(
              7,
              Tooltip(
                message: p['link'],
                child: Text(p['link'], overflow: TextOverflow.ellipsis),
              ),
            ),
            _c(8, _highlightText(p['productId'], isMobile: isMobile)),
            _c(
              9,
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image.asset(
                  "assets/images/sample.jpeg",
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _c(
              10,
              Wrap(
                spacing: 6,
                children: [
                  ElevatedButton(
                    onPressed: alreadyReserved
                        ? null
                        : () {
                            setState(() {
                              PMReservationPage.reservations.add({
                                "sellerName": p["seller"],
                                "reservationId": DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                "productId": p["productId"],
                                "image": "assets/images/sample.jpeg",
                                "remaining": const Duration(hours: 2),
                              });
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: alreadyReserved
                          ? Colors.grey
                          : AppTheme.peach,
                      minimumSize: const Size(60, 28),
                    ),
                    child: Text(
                      alreadyReserved ? "Reserved" : "Reserve",
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push(
                      "/pmm/products/${p['productId']}",
                      extra: p,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.mint,
                      minimumSize: const Size(60, 28),
                    ),
                    child: const Text(
                      "View",
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
