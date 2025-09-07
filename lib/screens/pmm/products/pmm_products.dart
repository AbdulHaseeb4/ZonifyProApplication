import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      "seller": "S101",
      "market": "US",
      "saleLimit": "50",
      "todayRemain": "25",
      "totalRemain": "30",
      "commission": "1000",
      "keywords": "Headphones, Audio",
      "link": "https://example.com/product1",
      "productId": "PRD-001",
      "active": false,
    },
    {
      "seller": "S102",
      "market": "UK",
      "saleLimit": "60",
      "todayRemain": "40",
      "totalRemain": "50",
      "commission": "1200",
      "keywords": "Mobile Charger",
      "link": "https://example.com/product2",
      "productId": "PRD-002",
      "active": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(
        title: "PMM Products",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Search Bar + Add Product Button
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

            // 🔹 Category Buttons
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
                                        : const Radius.circular(0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
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

            // 📋 Product Table
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
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Seller')),
                            DataColumn(label: Text('Market')),
                            DataColumn(label: Text('Sale Limit')),
                            DataColumn(label: Text('Today Remain')),
                            DataColumn(label: Text('Total Remain')),
                            DataColumn(label: Text('Commission')),
                            DataColumn(label: Text('Keywords')),
                            DataColumn(label: Text('Product Link')),
                            DataColumn(label: Text('Product ID')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: products.map((product) {
                            final isActive = product['active'] as bool;
                            return DataRow(
                              cells: [
                                DataCell(Text(product['seller'])),
                                DataCell(Text(product['market'])),
                                DataCell(Text(product['saleLimit'])),
                                DataCell(Text(product['todayRemain'])),
                                DataCell(Text(product['totalRemain'])),
                                DataCell(Text('PKR ${product['commission']}')),
                                DataCell(Text(product['keywords'])),
                                DataCell(
                                  Text(
                                    product['link'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DataCell(Text(product['productId'])),
                                DataCell(
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            product['active'] = !isActive;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                product['active']
                                                    ? 'Product Activated'
                                                    : 'Product Deactivated',
                                              ),
                                              backgroundColor: product['active']
                                                  ? Colors.green
                                                  : Colors.red,
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isActive
                                              ? Colors.green
                                              : Colors.red,
                                          minimumSize: const Size(60, 28),
                                        ),
                                        child: Text(
                                          isActive ? 'Active' : 'Inactive',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      ElevatedButton(
                                        onPressed: () => context.push(
                                          "/pmm/products/${product['productId']}",
                                          extra: product,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          minimumSize: const Size(60, 28),
                                        ),
                                        child: const Text(
                                          "View",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
    );
  }
}
