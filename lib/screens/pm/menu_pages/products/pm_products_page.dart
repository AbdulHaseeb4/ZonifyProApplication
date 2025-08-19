import 'package:flutter/material.dart';
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

  final List<String> marketOptions = [
    'Select Market', 'All', 'US', 'UK', 'DE', 'IT', 'CA', 'ES', 'AUS', 'JAPAN', 'KSA', 'UAE', 'General', 'FR',
    'Mexico', 'Russia', 'Sweden', 'Netherland', 'US-High Commission', 'UK-High Commission', 'Walmart-US',
    'Turkey', 'Kindle Books', 'ETSY', 'Singapore', 'India', 'Kindle US', 'eBay US', 'Walmart-UK', 'Poland',
    'TikTok US', 'Walmart-CA', 'Ali Express', 'Temu-US', 'Otto-DE', 'Temu-UK', 'SHEIN-US', 'Temu-DE',
    'Google Reviews UK', 'Taobao', 'Google Reviews US', 'TikTok UK', 'Wayfair UK', 'Wayfair US', 'Brazil',
  ];

  final List<String> typeOptions = [
    'Select Type', 'All', 'Text Review', 'Top Reviewer', 'No review', 'Feedback',
    'Rating', 'RAS', 'RAO', 'Seller Testing', 'Pic Review', 'Vid Review',
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
    'IT': Icons.account_balance,
    'CA': Icons.map_outlined,
    'General': Icons.dashboard_customize,
    'Kindle Books': Icons.book_online,
    'ETSY': Icons.storefront,
    'eBay US': Icons.shopping_cart,
    'Walmart-US': Icons.store,
    'Temu-US': Icons.shopping_bag,
    'Ali Express': Icons.fireplace,
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

  // 🔹 Function to highlight search matches
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
        spans.add(TextSpan(
            text: text.substring(start, index),
            style: TextStyle(fontSize: 12.sp, color: Colors.black)));
      }
      spans.add(TextSpan(
          text: text.substring(index, index + lowerSearch.length),
          style: TextStyle(fontSize: 12.sp, backgroundColor: Colors.yellow, color: Colors.black)));
      start = index + lowerSearch.length;
    }

    if (start < text.length) {
      spans.add(TextSpan(
          text: text.substring(start),
          style: TextStyle(fontSize: 12.sp, color: Colors.black)));
    }

    return RichText(text: TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 14.h),
              Row(
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
              SizedBox(height: 24.h),
              Expanded(child: _buildProductTable()),
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
      data: DropdownMenuThemeData(
        textStyle: TextStyle(fontSize: 13.sp, color: Colors.black87),
      ),
      child: Container(
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

    List<Map<String, dynamic>> allProducts = [
      {
        'category': 'Gaming Devices',
        'seller': '124',
        'market': 'US',
        'saleLimit': '40',
        'todayRemain': '20',
        'totalRemain': '25',
        'commission': '1500',
        'keywords': 'Gaming Mouse',
        'link': 'https://example.com/gaming/1',
        'productId': 'edb510d7-d741-43a8-a249-a8e450b1f894',
      },
      {
        'category': 'Health & Beauty',
        'seller': '349',
        'market': 'UK',
        'saleLimit': '30',
        'todayRemain': '15',
        'totalRemain': '18',
        'commission': '1200',
        'keywords': 'Face Wash',
        'link': 'https://example.com/health/1',
        'productId': '2934aaad-1b94-4c06-bb72-975a6c63a32c',
      },
      {
        'category': 'Fashion (Cloths & Shoes)',
        'seller': '789',
        'market': 'DE',
        'saleLimit': '50',
        'todayRemain': '28',
        'totalRemain': '30',
        'commission': '1700',
        'keywords': 'Sneakers',
        'link': 'https://example.com/fashion/1',
        'productId': '1a37ca6d-98f4-4641-94ce-d61e8b167160',
      },
      {
        'category': 'Electronics',
        'seller': '56',
        'market': 'CA',
        'saleLimit': '35',
        'todayRemain': '17',
        'totalRemain': '20',
        'commission': '1300',
        'keywords': 'Bluetooth Speaker',
        'link': 'https://example.com/electronics/1',
        'productId': '7ef270e3-daba-469b-b275-ef49f8986127',
      },
      {
        'category': 'Mobile Accessories',
        'seller': '471',
        'market': 'IN',
        'saleLimit': '60',
        'todayRemain': '40',
        'totalRemain': '50',
        'commission': '2000',
        'keywords': 'Phone Case',
        'link': 'https://example.com/mobile/1',
        'productId': 'ea6d5a0d-4510-4ddf-b995-ced0132ba17e',
      },
      {
        'category': 'Baby Products',
        'seller': '867',
        'market': 'AUS',
        'saleLimit': '25',
        'todayRemain': '10',
        'totalRemain': '12',
        'commission': '1100',
        'keywords': 'Baby Shampoo',
        'link': 'https://example.com/baby/1',
        'productId': '6c11d7ae-641b-4ebc-9b12-cfbf30cabf89',
      },
      {
        'category': 'Home & Kitchen',
        'seller': '320',
        'market': 'UAE',
        'saleLimit': '70',
        'todayRemain': '50',
        'totalRemain': '65',
        'commission': '2100',
        'keywords': 'Cookware Set',
        'link': 'https://example.com/home/1',
        'productId': 'd3d43156-b3d5-4e1a-bec8-d73fdd339333',
      },
      {
        'category': 'Books & Education',
        'seller': '901',
        'market': 'UK',
        'saleLimit': '15',
        'todayRemain': '9',
        'totalRemain': '10',
        'commission': '900',
        'keywords': 'Educational Book',
        'link': 'https://example.com/books/1',
        'productId': '31ddc4fb-ec39-4df4-a14b-87b8979f1c3f',
      },
      {
        'category': 'Fitness',
        'seller': '223',
        'market': 'US',
        'saleLimit': '20',
        'todayRemain': '10',
        'totalRemain': '15',
        'commission': '1800',
        'keywords': 'Resistance Band',
        'link': 'https://example.com/fitness/1',
        'productId': 'ffb6e36c-9c2b-4dc2-bbcf-1fca3a2a7e3e',
      },
      {
        'category': 'Toys',
        'seller': '776',
        'market': 'FR',
        'saleLimit': '45',
        'todayRemain': '25',
        'totalRemain': '30',
        'commission': '1600',
        'keywords': 'Educational Toy',
        'link': 'https://example.com/toys/1',
        'productId': 'b47b5c23-e928-404f-8bd7-97db95f86fd9',
      },
    ];

    List<Map<String, dynamic>> filteredProducts = widget.category == "All Products"
        ? allProducts
        : allProducts.where((p) => p['category'] == widget.category).toList();

    if (searchKeyword.isNotEmpty) {
      filteredProducts = filteredProducts.where((p) =>
      p['productId'].toString().toLowerCase().contains(searchKeyword) ||
          p['seller'].toString().toLowerCase().contains(searchKeyword) ||
          p['keywords'].toString().toLowerCase().contains(searchKeyword)
      ).toList();
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
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
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
                        child: Text(
                          p['link'],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      )),
                      _c(8, _highlightText(p['productId'])),
                      _c(9, Center(
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
                      _c(10, FittedBox(
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade400,
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                minimumSize: Size(60.w, 30.h),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                elevation: 1.0,
                              ),
                              child: const Text("Reserve", style: TextStyle(fontSize: 11, color: Colors.white)),
                            ),
                            SizedBox(width: 6.w),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade500,
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                minimumSize: Size(60.w, 30.h),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
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
