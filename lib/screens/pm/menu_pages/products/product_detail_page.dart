import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;
  PageController? _pageController; // nullable
  Timer? _autoPlayTimer;

  final List<String> images = [
    "assets/images/sample.jpeg",
    "assets/images/sample.jpeg",
    "assets/images/sample.jpeg", // dummy extra images
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    /// Auto-play every 3 seconds
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController != null && _pageController!.hasClients) {
        int nextPage = (currentIndex + 1) % images.length;
        _pageController!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Image Slider with Arrows ---
          SizedBox(
            height: 220.h,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController, // ✅ safe, no LateInitializationError
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),

                /// Left Arrow
                Positioned(
                  left: 8,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
                    onPressed: () {
                      if (_pageController != null && _pageController!.hasClients) {
                        int prevPage = currentIndex > 0 ? currentIndex - 1 : images.length - 1;
                        _pageController!.animateToPage(
                          prevPage,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),

                /// Right Arrow
                Positioned(
                  right: 8,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.sp),
                    onPressed: () {
                      if (_pageController != null && _pageController!.hasClients) {
                        int nextPage = (currentIndex + 1) % images.length;
                        _pageController!.animateToPage(
                          nextPage,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          /// --- Slider Indicator ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
                  (index) => Container(
                margin: EdgeInsets.all(4.w),
                width: currentIndex == index ? 12.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),

          /// --- Heading with design line ---
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  width: 40.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),

          /// --- Scrollable Sections ---
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              children: [
                _buildExpandableGroup(
                  title: "Main Details",
                  icon: Icons.info,
                  details: [
                    _buildCopyableRow(Icons.key, "Keywords", widget.product['keywords']),
                    _buildCopyableRow(Icons.store, "Sold By", widget.product['seller']),
                    _buildCopyableRow(Icons.qr_code, "Product ID", widget.product['productId']),
                    _buildCopyableRow(Icons.rate_review, "Review Type", widget.product['reviewType']),
                  ],
                ),
                _buildExpandableGroup(
                  title: "Other Details",
                  icon: Icons.list_alt,
                  details: [
                    _buildDetailRow(Icons.location_city, "Market", widget.product['market']),
                    _buildDetailRow(Icons.category, "Category", widget.product['category']),
                    _buildDetailRow(Icons.attach_money, "Commission", widget.product['commission']),
                    _buildDetailRow(Icons.sell, "Overall Sale Limit", widget.product['overallSaleLimit']),
                    _buildDetailRow(Icons.today, "Today Sale Limit", widget.product['todaySaleLimit']),
                    _buildDetailRow(Icons.storage, "Total Remaining", widget.product['totalRemaining']),
                    _buildDetailRow(Icons.price_change, "Product Price", widget.product['price']),
                  ],
                ),
                _buildExpandableTileCard(
                  icon: Icons.menu_book,
                  title: "Instructions",
                  content:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque.",
                ),
                _buildExpandableTileCard(
                  icon: Icons.refresh,
                  title: "Refund Condition",
                  content:
                  "Refunds are applicable only if product is unused and returned within 7 days. No refund on digital products.",
                ),
                _buildExpandableTileCard(
                  icon: Icons.rule,
                  title: "Commission Condition",
                  content:
                  "Commission will be calculated on total sale value excluding taxes and discounts. Settlement period: 30 days.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --- Expandable Group (for grouped details) ---
  Widget _buildExpandableGroup({
    required String title,
    required IconData icon,
    required List<Widget> details,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green, size: 18.sp),
        title: Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        children: details,
      ),
    );
  }

  /// --- Row with Copy Button ---
  Widget _buildCopyableRow(IconData icon, String label, String? value) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.blueGrey, size: 18.sp),
      title: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.copy, color: Colors.green, size: 18),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$label copied")),
          );
        },
      ),
    );
  }

  /// --- Row without Copy Button ---
  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.grey, size: 18.sp),
      title: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  /// --- Individual Expandable Card ---
  Widget _buildExpandableTileCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green, size: 18.sp),
        title: Text(
          title,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Text(
              content,
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
