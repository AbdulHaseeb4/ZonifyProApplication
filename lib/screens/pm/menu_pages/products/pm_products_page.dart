import 'package:flutter/material.dart';
import 'package:zonifypro/screens/pm/menu_pages/products/product_detail_page.dart';
import 'package:zonifypro/screens/pm/menu_pages/reservation/show_reservation_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PMProductsPage extends StatefulWidget {
  final String category;
  const PMProductsPage({super.key, required this.category});

  @override
  State<PMProductsPage> createState() => _PMProductsPageState();
}

class _PMProductsPageState extends State<PMProductsPage> {
  final TextEditingController _searchController = TextEditingController();

  String searchKeyword = '';
  String selectedMarket = "Select Market";
  String selectedType = "Select Type";
  String selectedCategory = "All"; // 👈 filter chip state

  // ✅ Fixed categories
  final List<String> categories = [
    "All",
    "General",
    "Electronics",
    "Health & Beauty",
    "Baby Products",
    "Gaming Devices",
    "Fashion (Cloths & Shoes)",
    "Mobile Accessories",
    "Expensive Products",
    "Pet Related",
    "Home & Kitchen",
  ];

  final List<String> marketOptions = [
    'Select Market', 'All', 'US', 'UK', 'DE', 'CA', 'AUS', 'UAE', 'FR', 'IN',
  ];

  final List<String> typeOptions = [
    'Select Type', 'All', 'Text Review', 'Top Reviewer', 'No review',
    'Feedback', 'Rating', 'RAS', 'RAO', 'Seller Testing', 'Pic Review', 'Vid Review',
  ];

  Map<String, IconData> getTypeIcons() => {
    'Select Type': Icons.help_outline,
    'All': Icons.all_inclusive,
    'Text Review': Icons.text_fields,
    'Top Reviewer': Icons.emoji_events,
    'No review': Icons.cancel_presentation,
    'Feedback': Icons.feedback,
    'Rating': Icons.star_rate,
    'RAS': Icons.bolt,
    'RAO': Icons.security,
    'Seller Testing': Icons.science,
    'Pic Review': Icons.image,
    'Vid Review': Icons.videocam,
  };

  Map<String, IconData> getMarketIcons() => {
    'Select Market': Icons.help_outline,
    'All': Icons.public,
    'US': Icons.flag,
    'UK': Icons.flag_circle,
    'DE': Icons.language,
    'FR': Icons.map,
    'CA': Icons.map_outlined,
    'AUS': Icons.flag_outlined,
    'UAE': Icons.flag_outlined,
    'IN': Icons.flag_outlined,
  };

  final List<double> _colW = <double>[
    90.w, 70.w, 80.w, 90.w, 90.w, 90.w, 130.w, 200.w, 90.w, 70.w, 180.w,
  ];

  Widget _h(String text, int i) => SizedBox(
    width: _colW[i],
    child: Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
    ),
  );

  DataCell _c(int i, Widget child) => DataCell(
    SizedBox(width: _colW[i], child: Center(child: child)),
  );

  Widget _highlightText(String text) {
    if (searchKeyword.isEmpty) return Text(text, style: TextStyle(fontSize: 12.sp));
    final lowerText = text.toLowerCase();
    final lowerSearch = searchKeyword.toLowerCase();

    if (!lowerText.contains(lowerSearch)) {
      return Text(text, style: TextStyle(fontSize: 12.sp));
    }

    final spans = <TextSpan>[];
    int start = 0;
    int index;

    while ((index = lowerText.indexOf(lowerSearch, start)) != -1) {
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: const TextStyle(color: Colors.black)));
      }
      spans.add(TextSpan(
          text: text.substring(index, index + lowerSearch.length),
          style: const TextStyle(backgroundColor: Colors.yellow, color: Colors.black)));
      start = index + lowerSearch.length;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: const TextStyle(color: Colors.black)));
    }
    return RichText(text: TextSpan(style: TextStyle(fontSize: 12.sp), children: spans));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search
            Padding(
              padding: EdgeInsets.all(16.w),
              child: _buildSearchBar(),
            ),

            /// Filter Chips
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isActive = selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat, style: TextStyle(fontSize: 12.sp)),
                    selected: isActive,
                    selectedColor: Colors.green.shade400,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: isActive ? Colors.white : Colors.black87,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (_) => setState(() => selectedCategory = cat),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            /// Dropdown filters
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      value: selectedMarket,
                      items: marketOptions,
                      onChanged: (val) => setState(() => selectedMarket = val),
                      iconMap: getMarketIcons(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildDropdown(
                      value: selectedType,
                      items: typeOptions,
                      onChanged: (val) => setState(() => selectedType = val),
                      iconMap: getTypeIcons(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// Table
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildProductTable(),
              ),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 3, offset: const Offset(0, 2))],
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
              setState(() => searchKeyword = '');
            },
          )
              : null,
          hintText: "Search by Product Code, Keywords, Seller ID",
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        onChanged: (val) => setState(() => searchKeyword = val.trim().toLowerCase()),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String) onChanged,
    required Map<String, IconData> iconMap,
  }) {
    return DropdownMenuTheme(
      data: DropdownMenuThemeData(textStyle: TextStyle(fontSize: 13.sp, color: Colors.black87)),
      child: Container(
        height: 36.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 3, offset: const Offset(0, 2))],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54, size: 18),
            isExpanded: true,
            borderRadius: BorderRadius.circular(14.r),
            onChanged: (val) => val != null ? onChanged(val) : null,
            items: items.map((item) {
              final icon = iconMap[item] ?? Icons.circle;
              return DropdownMenuItem(
                value: item,
                child: Row(
                  children: [
                    Icon(icon, size: 16),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(item,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: value == item ? FontWeight.bold : FontWeight.normal,
                            color: Colors.black54,
                          )),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildProductTable() {
    final ScrollController v = ScrollController();
    final ScrollController h = ScrollController();
    const double spacing = 18.0;
    final double minTableWidth = _colW.reduce((a, b) => a + b) + spacing * (_colW.length - 1);

    /// ✅ Dummy Products List
    List<Map<String, dynamic>> allProducts = [
      {"category": "General", "seller": "101", "market": "US", "saleLimit": "30", "todayRemain": "15", "totalRemain": "20", "commission": "1000", "keywords": "General Item", "link": "https://example.com/general", "productId": "GEN-001"},
      {"category": "Electronics", "seller": "102", "market": "UK", "saleLimit": "40", "todayRemain": "20", "totalRemain": "25", "commission": "1500", "keywords": "Bluetooth Speaker", "link": "https://example.com/electronics", "productId": "ELE-001"},
      {"category": "Health & Beauty", "seller": "103", "market": "DE", "saleLimit": "25", "todayRemain": "10", "totalRemain": "15", "commission": "900", "keywords": "Face Wash", "link": "https://example.com/health", "productId": "HB-001"},
      {"category": "Baby Products", "seller": "104", "market": "CA", "saleLimit": "20", "todayRemain": "8", "totalRemain": "12", "commission": "800", "keywords": "Baby Shampoo", "link": "https://example.com/baby", "productId": "BABY-001"},
      {"category": "Gaming Devices", "seller": "105", "market": "AUS", "saleLimit": "50", "todayRemain": "30", "totalRemain": "40", "commission": "2000", "keywords": "Gaming Mouse", "link": "https://example.com/gaming", "productId": "GAME-001"},
      {"category": "Fashion (Cloths & Shoes)", "seller": "106", "market": "UAE", "saleLimit": "60", "todayRemain": "35", "totalRemain": "45", "commission": "2200", "keywords": "Sneakers", "link": "https://example.com/fashion", "productId": "FASH-001"},
      {"category": "Mobile Accessories", "seller": "107", "market": "FR", "saleLimit": "35", "todayRemain": "18", "totalRemain": "22", "commission": "1200", "keywords": "Phone Case", "link": "https://example.com/mobile", "productId": "MOB-001"},
      {"category": "Expensive Products", "seller": "108", "market": "IN", "saleLimit": "10", "todayRemain": "5", "totalRemain": "7", "commission": "5000", "keywords": "Luxury Watch", "link": "https://example.com/expensive", "productId": "EXP-001"},
      {"category": "Pet Related", "seller": "109", "market": "US", "saleLimit": "15", "todayRemain": "7", "totalRemain": "10", "commission": "700", "keywords": "Pet Food", "link": "https://example.com/pet", "productId": "PET-001"},
      {"category": "Home & Kitchen", "seller": "110", "market": "UK", "saleLimit": "45", "todayRemain": "25", "totalRemain": "30", "commission": "1600", "keywords": "Cookware Set", "link": "https://example.com/home", "productId": "HOME-001"},
    ];

    /// ✅ Apply Category Filter
    List<Map<String, dynamic>> filteredProducts =
    selectedCategory == "All"
        ? allProducts
        : allProducts.where((p) => p['category'] == selectedCategory).toList();

    /// ✅ Apply Search Filter
    if (searchKeyword.isNotEmpty) {
      filteredProducts = filteredProducts.where((p) =>
      p['productId'].toString().toLowerCase().contains(searchKeyword) ||
          p['seller'].toString().toLowerCase().contains(searchKeyword) ||
          p['keywords'].toString().toLowerCase().contains(searchKeyword)).toList();
    }

    return Scrollbar(
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
                headingTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                headingRowColor: MaterialStateProperty.all(const Color(0xffe4e6eb)),
                columns: [
                  DataColumn(label: _h('Seller', 0)),
                  DataColumn(label: _h('Market', 1)),
                  DataColumn(label: _h('Sale Limit', 2)),
                  DataColumn(label: _h('Today Remain', 3)),
                  DataColumn(label: _h('Total Remain', 4)),
                  DataColumn(label: _h('Commission', 5)),
                  DataColumn(label: _h('Keywords', 6)),
                  DataColumn(label: _h('Product Link', 7)),
                  DataColumn(label: _h('Product ID', 8)),
                  DataColumn(label: _h('Image', 9)),
                  DataColumn(label: _h('Actions', 10)),
                ],
                rows: filteredProducts.asMap().entries.map((entry) {
                  final i = entry.key;
                  final p = entry.value;

                  return DataRow(
                    color: MaterialStateProperty.all(
                      i % 2 == 0 ? const Color(0xfffdfdfd) : const Color(0xfff0f2f5),
                    ),
                    cells: [
                      _c(0, _highlightText(p['seller'])),
                      _c(1, Text(p['market'], style: TextStyle(fontSize: 12.sp))),
                      _c(2, Text(p['saleLimit'], style: TextStyle(fontSize: 12.sp))),
                      _c(3, Text(p['todayRemain'], style: TextStyle(fontSize: 12.sp))),
                      _c(4, Text(p['totalRemain'], style: TextStyle(fontSize: 12.sp))),
                      _c(5, Text('PKR ${p['commission']}', style: TextStyle(fontSize: 12.sp))),
                      _c(6, _highlightText(p['keywords'])),
                      _c(7, Tooltip(
                        message: p['link'],
                        child: Text(p['link'], overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp)),
                      )),
                      _c(8, _highlightText(p['productId'])),
                      _c(9, Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: Image.asset('assets/images/sample.jpeg', width: 40.w, height: 40.h, fit: BoxFit.cover),
                        ),
                      )),
                      _c(10, FittedBox(
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  ShowReservationPage.reservations.add({
                                    "sellerName": p["seller"],
                                    "reservationId": DateTime.now().millisecondsSinceEpoch.toString(),
                                    "productId": p["productId"],
                                    "image": "assets/images/sample.jpeg",
                                    "remaining": const Duration(hours: 2),
                                  });
                                });
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Reserved")));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade400,
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                minimumSize: Size(60.w, 30.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                elevation: 1.0,
                              ),
                              child: const Text("Reserve", style: TextStyle(fontSize: 11, color: Colors.white)),
                            ),
                            SizedBox(width: 6.w),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: p)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade500,
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                minimumSize: Size(60.w, 30.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                elevation: 1.0,
                              ),
                              child: const Text("View", style: TextStyle(fontSize: 11, color: Colors.white)),
                            ),
                          ],
                        ),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
