import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMAddProductPage extends StatelessWidget {
  const PMMAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const DashboardWrapper(
        defaultRole: "pmm",
        child: BaseLayout(title: "Add Product", child: PMMAddProductForm()),
      ),
    );
  }
}

class PMMAddProductForm extends StatefulWidget {
  const PMMAddProductForm({super.key});

  @override
  State<PMMAddProductForm> createState() => _PMMAddProductFormState();
}

class _PMMAddProductFormState extends State<PMMAddProductForm> {
  final _formKey = GlobalKey<FormState>();
  List<ImageProvider?> uploadedImages = [null, null, null, null];
  int selectedImageIndex = -1;

  final instructionsController = TextEditingController();
  final refundController = TextEditingController();
  final commissionController = TextEditingController();

  final Map<String, IconData> fieldIcons = {
    'keywords': Icons.search,
    'brand name': Icons.storefront,
    'sold by': Icons.storefront,
    'product link': Icons.link,
    'product price': Icons.attach_money,
    'sale limit/day': Icons.bar_chart,
    'overall sale limit': Icons.show_chart,
    'select market': Icons.public,
    'seller type': Icons.group,
    'review type': Icons.reviews,
    'product commission': Icons.percent,
    'select category': Icons.category,
  };

  final Map<String, IconData> paragraphFieldIcons = {
    'Instructions': Icons.edit_note,
    'Refund Conditions': Icons.attach_money,
    'Commission Conditions': Icons.pie_chart,
  };

  final Map<String, List<String>> dropdownOptions = {
    'select market': ['Amazon', 'Daraz', 'eBay', 'Walmart'],
    'seller type': ['Individual', 'Company', 'Reseller'],
    'review type': ['Manual Review', 'Auto Review', 'Verified Purchase'],
    'select category': ['Electronics', 'Fashion', 'Beauty', 'Home & Kitchen'],
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Container(
          color: const Color(0xFFF4F5F7),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                            color: Colors.black,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Add New Product',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (uploadedImages.every((img) => img == null)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please upload at least one product image",
                                ),
                              ),
                            );
                            return;
                          }
                        },
                        icon: const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Add Product',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF24A2D3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Responsive Layout
                  isMobile
                      ? Column(
                          children: [
                            buildCard(
                              title: "Product Info",
                              icon: Icons.info_outline,
                              children: buildResponsiveFields([
                                "Keywords",
                                "Brand Name",
                                "Sold By",
                                "Product Link",
                                "Product Price",
                                "Sale Limit/Day",
                                "Overall Sale Limit",
                                "Product Commission",
                                "Seller Type",
                                "Review Type",
                                "Select Market",
                                "Select Category",
                              ], true),
                            ),
                            const SizedBox(height: 20),
                            buildCard(
                              title: "Product Conditions",
                              icon: Icons.rule,
                              children: [
                                _buildSingleRowField(
                                  instructionsController,
                                  'Instructions',
                                ),
                                const SizedBox(height: 10),
                                _buildSingleRowField(
                                  refundController,
                                  'Refund Conditions',
                                ),
                                const SizedBox(height: 10),
                                _buildSingleRowField(
                                  commissionController,
                                  'Commission Conditions',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            buildCard(
                              title: "Upload Images",
                              icon: Icons.image_outlined,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: selectedImageIndex == -1
                                      ? const Center(
                                          child: Text(
                                            "No Image View",
                                            style: TextStyle(
                                              color: Colors.black45,
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image(
                                            image:
                                                uploadedImages[selectedImageIndex]!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 10),
                                // ✅ Mobile: Row with Expanded
                                Row(
                                  children: List.generate(4, (index) {
                                    return Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: index < 3 ? 12 : 0,
                                        ),
                                        child: imageUploadTile(index),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  buildCard(
                                    title: "Product Info",
                                    icon: Icons.info_outline,
                                    children: buildResponsiveFields([
                                      "Keywords",
                                      "Brand Name",
                                      "Sold By",
                                      "Product Link",
                                      "Product Price",
                                      "Sale Limit/Day",
                                      "Overall Sale Limit",
                                      "Product Commission",
                                      "Seller Type",
                                      "Review Type",
                                      "Select Market",
                                      "Select Category",
                                    ], false),
                                  ),
                                  const SizedBox(height: 20),
                                  buildCard(
                                    title: "Product Conditions",
                                    icon: Icons.rule,
                                    children: [
                                      _buildSingleRowField(
                                        instructionsController,
                                        'Instructions',
                                      ),
                                      const SizedBox(height: 10),
                                      _buildSingleRowField(
                                        refundController,
                                        'Refund Conditions',
                                      ),
                                      const SizedBox(height: 10),
                                      _buildSingleRowField(
                                        commissionController,
                                        'Commission Conditions',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 1,
                              child: buildCard(
                                title: "Upload Images",
                                icon: Icons.image_outlined,
                                children: [
                                  Container(
                                    height: 260,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: selectedImageIndex == -1
                                        ? const Center(
                                            child: Text(
                                              "No Image View",
                                              style: TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image(
                                              image:
                                                  uploadedImages[selectedImageIndex]!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(height: 10),
                                  // ✅ Web: Row with evenly spaced fixed-size boxes
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(4, (index) {
                                      return SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: imageUploadTile(index),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildResponsiveFields(List<String> labels, bool isMobile) {
    List<Widget> rows = [];
    for (int i = 0; i < labels.length; i += isMobile ? 1 : 3) {
      rows.add(
        Row(
          children: List.generate(isMobile ? 1 : 3, (j) {
            final idx = i + j;
            if (idx >= labels.length) return const SizedBox();
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: j < 2 ? 10 : 0),
                child: buildSmartField(labels[idx]),
              ),
            );
          }),
        ),
      );
      rows.add(const SizedBox(height: 10));
    }
    return rows;
  }

  Widget buildCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Colors.black),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget buildSmartField(String label) {
    final lower = label.toLowerCase();
    final icon = fieldIcons[lower] ?? Icons.text_fields;
    final dropdownFields = [
      'select market',
      'seller type',
      'review type',
      'select category',
    ];

    if (dropdownFields.contains(lower)) {
      return DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 16, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          isDense: true,
        ),
        items: (dropdownOptions[lower] ?? []).map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: const TextStyle(fontSize: 12)),
          );
        }).toList(),
        onChanged: (val) {},
      );
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 16, color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        isDense: true,
      ),
      style: const TextStyle(fontSize: 12),
    );
  }

  Widget _buildSingleRowField(TextEditingController controller, String label) {
    final icon = paragraphFieldIcons[label] ?? Icons.text_fields;
    return TextField(
      controller: controller,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: Colors.blue),
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      style: const TextStyle(fontSize: 12),
    );
  }

  Widget imageUploadTile(int index) {
    final isSelected = index == selectedImageIndex;
    return GestureDetector(
      onTap: () {
        if (uploadedImages[index] != null) {
          setState(() => selectedImageIndex = index);
        }
      },
      child: DottedBorder(
        color: isSelected ? Colors.blue : Colors.grey.shade400,
        strokeWidth: isSelected ? 2 : 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [6, 3],
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: uploadedImages[index] == null
              ? Center(
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFF885EC7)),
                    onPressed: () async {
                      final image = await _pickImage();
                      if (image != null) {
                        setState(() {
                          uploadedImages[index] = image;
                          selectedImageIndex = index;
                        });
                      }
                    },
                  ),
                )
              : Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: uploadedImages[index]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            uploadedImages[index] = null;
                            if (selectedImageIndex == index) {
                              int fallback = uploadedImages.indexWhere(
                                (img) => img != null,
                              );
                              selectedImageIndex = fallback >= 0
                                  ? fallback
                                  : -1;
                            }
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
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

  Future<ImageProvider?> _pickImage() async {
    return const AssetImage("assets/images/sample.jpeg");
  }
}
