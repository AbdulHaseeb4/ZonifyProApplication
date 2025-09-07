import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';

class PMMAddProductPage extends StatelessWidget {
  const PMMAddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardWrapper(
      defaultRole: "pmm",
      child: BaseLayout(title: "Add Product", child: PMMAddProductForm()),
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
    'select category': Icons.category, // ✅ Added
  };

  final List<String> dummyOptions = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F5F7),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Add New Product',
                        style: TextStyle(fontSize: 13, color: Colors.black),
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
                      size: 12,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Add Product',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF24A2D3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Product Info',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  build3FieldRow(
                                    "Keywords",
                                    "Brand Name",
                                    "Sold By",
                                  ),
                                  const SizedBox(height: 10),
                                  build3FieldRow(
                                    "Product Link",
                                    "Product Price",
                                    "Sale Limit/Day",
                                  ),
                                  const SizedBox(height: 10),
                                  build3FieldRow(
                                    "Overall Sale Limit",
                                    "Product Commission",
                                    "Seller Type",
                                  ),
                                  const SizedBox(height: 10),
                                  build3FieldRow(
                                    "Review Type",
                                    "Select Market",
                                    "Select Category",
                                  ), // ✅ Changed
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 420,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Upload Images',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
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
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image:
                                              uploadedImages[selectedImageIndex]!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(4, (index) {
                                    final isSelected =
                                        index == selectedImageIndex;
                                    return GestureDetector(
                                      onTap: () {
                                        if (uploadedImages[index] != null) {
                                          setState(
                                            () => selectedImageIndex = index,
                                          );
                                        }
                                      },
                                      child: DottedBorder(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.grey.shade400,
                                        strokeWidth: isSelected ? 2 : 1,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(10),
                                        dashPattern: [6, 3],
                                        child: Container(
                                          height: double.infinity,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: uploadedImages[index] == null
                                              ? Center(
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Color(0xFF885EC7),
                                                    ),
                                                    onPressed: () async {
                                                      final image =
                                                          await _pickImage();
                                                      if (image != null) {
                                                        setState(() {
                                                          uploadedImages[index] =
                                                              image;
                                                          selectedImageIndex =
                                                              index;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                )
                                              : Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        child: Image(
                                                          image:
                                                              uploadedImages[index]!,
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
                                                            uploadedImages[index] =
                                                                null;
                                                            if (selectedImageIndex ==
                                                                index) {
                                                              int fallback =
                                                                  uploadedImages
                                                                      .indexWhere(
                                                                        (img) =>
                                                                            img !=
                                                                            null,
                                                                      );
                                                              selectedImageIndex =
                                                                  fallback >= 0
                                                                  ? fallback
                                                                  : -1;
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Colors
                                                                    .black54,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          padding:
                                                              const EdgeInsets.all(
                                                                2,
                                                              ),
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
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build3FieldRow(String label1, String label2, String? label3) {
    return Row(
      children: [
        Expanded(child: buildSmartField(label1)),
        const SizedBox(width: 10),
        Expanded(child: buildSmartField(label2)),
        if (label3 != null) ...[
          const SizedBox(width: 10),
          Expanded(child: buildSmartField(label3)),
        ],
      ],
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
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.grey.shade400),
            radius: const Radius.circular(8),
            thickness: MaterialStateProperty.all(4),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          overlayColor: MaterialStatePropertyAll(
            Color(0xFFEAF6FF),
          ), // Hover effect
          selectedMenuItemBuilder: (context, child) => Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD6ECFF),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: child,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 18),
        ),
        items: dummyOptions.map((item) {
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

  Future<ImageProvider?> _pickImage() async {
    return const AssetImage("assets/images/sample.jpeg");
  }
}
