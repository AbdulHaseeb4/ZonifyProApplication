import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zonifypro/core/theme.dart';
import 'package:zonifypro/screens/pm/reservation/pm_reservation.dart';
import 'package:zonifypro/layout/base_layout.dart';

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
  String selectedCategory = "All";

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
    'Select Market',
    'All',
    'US',
    'UK',
    'DE',
    'CA',
    'AUS',
    'UAE',
    'FR',
    'IN',
  ];

  final List<String> typeOptions = [
    'Select Type',
    'All',
    'Text Review',
    'Top Reviewer',
    'No review',
    'Feedback',
    'Rating',
    'RAS',
    'RAO',
    'Seller Testing',
    'Pic Review',
    'Vid Review',
  ];

  Map<String, IconData> getTypeIcons() => {
    'Select Type': Icons.help_outline,
    'All': Icons.all_inclusive,
    'Text Review': Icons.text_fields,
    'Top Reviewer': Icons.emoji_events,
    'No review': Icons.cancel,
    'Feedback': Icons.feedback,
    'Rating': Icons.star,
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
    if (searchKeyword.isEmpty) {
      return Text(text, style: TextStyle(fontSize: isMobile ? 11 : 12));
    }
    final lowerText = text.toLowerCase();
    final lowerSearch = searchKeyword.toLowerCase();

    if (!lowerText.contains(lowerSearch)) {
      return Text(text, style: TextStyle(fontSize: isMobile ? 11 : 12));
    }

    final spans = <TextSpan>[];
    int start = 0;
    int index;

    while ((index = lowerText.indexOf(lowerSearch, start)) != -1) {
      if (index > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, index),
            style: const TextStyle(color: Colors.black),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + lowerSearch.length),
          style: const TextStyle(
            backgroundColor: Colors.yellow,
            color: Colors.black,
          ),
        ),
      );
      start = index + lowerSearch.length;
    }
    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: isMobile ? 11 : 12),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return BaseLayout(
      title: "Products",
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search + Filters
            Padding(
              padding: const EdgeInsets.all(16),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(isMobile),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                value: selectedMarket,
                                items: marketOptions,
                                onChanged: (val) =>
                                    setState(() => selectedMarket = val),
                                iconMap: getMarketIcons(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDropdown(
                                value: selectedType,
                                items: typeOptions,
                                onChanged: (val) =>
                                    setState(() => selectedType = val),
                                iconMap: getTypeIcons(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(flex: 2, child: _buildSearchBar(isMobile)),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: _buildDropdown(
                            value: selectedMarket,
                            items: marketOptions,
                            onChanged: (val) =>
                                setState(() => selectedMarket = val),
                            iconMap: getMarketIcons(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: _buildDropdown(
                            value: selectedType,
                            items: typeOptions,
                            onChanged: (val) =>
                                setState(() => selectedType = val),
                            iconMap: getTypeIcons(),
                          ),
                        ),
                      ],
                    ),
            ),

            /// 🏷️ Categories
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 12),
              child: SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isActive = selectedCategory == cat;
                    return ChoiceChip(
                      label: Text(
                        cat,
                        style: TextStyle(fontSize: isMobile ? 11 : 12),
                      ),
                      selected: isActive,
                      selectedColor: AppTheme.lavender,
                      backgroundColor: AppTheme.card,
                      labelStyle: TextStyle(
                        color: isActive ? Colors.white : Colors.black87,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      onSelected: (_) => setState(() => selectedCategory = cat),
                    );
                  },
                ),
              ),
            ),

            /// 📋 Product Table
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
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
                          child: _buildProductTable(isMobile),
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

  /// 🔍 Search
  Widget _buildSearchBar(bool isMobile) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _searchController,
        style: TextStyle(fontSize: isMobile ? 12 : 13),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.lavender,
            size: 18,
          ),
          suffixIcon: searchKeyword.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => searchKeyword = '');
                  },
                )
              : null,
          hintText: "Search by Product Code, Keywords, Seller ID",
          hintStyle: TextStyle(
            fontSize: isMobile ? 11 : 12,
            color: Colors.grey.shade600,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: AppTheme.lavender, width: 1.5),
          ),
        ),
        onChanged: (val) =>
            setState(() => searchKeyword = val.trim().toLowerCase()),
      ),
    );
  }

  /// ⬇️ Dropdown
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String) onChanged,
    required Map<String, IconData> iconMap,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black54,
            size: 18,
          ),
          isExpanded: true,
          borderRadius: BorderRadius.circular(14),
          onChanged: (val) => val != null ? onChanged(val) : null,
          items: items.map((item) {
            final icon = iconMap[item] ?? Icons.circle;
            return DropdownMenuItem(
              value: item,
              child: Row(
                children: [
                  Icon(icon, size: 16, color: AppTheme.mint),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 📋 Product Table
  Widget _buildProductTable(bool isMobile) {
    List<Map<String, dynamic>> allProducts = [
      {
        "category": "General",
        "seller": "101",
        "market": "US",
        "saleLimit": "30",
        "todayRemain": "15",
        "totalRemain": "20",
        "commission": "1000",
        "keywords": "General Item",
        "link": "https://example.com/general",
        "productId": "GEN-001",
      },
      {
        "category": "Electronics",
        "seller": "102",
        "market": "UK",
        "saleLimit": "40",
        "todayRemain": "20",
        "totalRemain": "25",
        "commission": "1500",
        "keywords": "Bluetooth Speaker",
        "link": "https://example.com/electronics",
        "productId": "ELE-001",
      },
    ];

    List<Map<String, dynamic>> filteredProducts = selectedCategory == "All"
        ? allProducts
        : allProducts.where((p) => p['category'] == selectedCategory).toList();

    if (searchKeyword.isNotEmpty) {
      filteredProducts = filteredProducts
          .where(
            (p) =>
                p['productId'].toString().toLowerCase().contains(
                  searchKeyword,
                ) ||
                p['seller'].toString().toLowerCase().contains(searchKeyword) ||
                p['keywords'].toString().toLowerCase().contains(searchKeyword),
          )
          .toList();
    }

    return DataTable(
      headingRowHeight: 44,
      dataRowMinHeight: isMobile ? 48 : 56,
      dataRowMaxHeight: isMobile ? 52 : 60,
      horizontalMargin: 12,
      columnSpacing: 18,
      dividerThickness: 0.4,
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.black87,
      ),
      headingRowColor: WidgetStateProperty.all(AppTheme.card),
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
      rows: filteredProducts.map((p) {
        final alreadyReserved = PMReservationPage.reservations.any(
          (r) => r['productId'] == p['productId'],
        );

        return DataRow(
          color: WidgetStateProperty.all(AppTheme.background),
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
              Image.asset("assets/images/sample.jpeg", width: 36, height: 36),
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
                    onPressed: () {
                      final id = p['productId'];
                      context.push("/pm/products/$id", extra: p);
                    },
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
      }).toList(),
    );
  }
}
