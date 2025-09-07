import 'package:flutter/material.dart';
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
              // 🔹 HEADER
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
                      // TODO: Proceed with form submission logic here
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

              // 🔻 CARDS ROW
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟩 PRODUCT INFO CARD
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 420,
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
                              const SizedBox(height: 16),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: const Center(
                                    child: Text(
                                      "Product Info Form Here",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 🟦 UPLOAD IMAGE CARD
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

                              // 📷 Main Image View
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

                              // 📦 4 Upload Slots - reduced spacing
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
                                          setState(() {
                                            selectedImageIndex = index;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.blue
                                                : Colors.grey.shade400,
                                            width: isSelected ? 2 : 1,
                                          ),
                                        ),
                                        child: uploadedImages[index] == null
                                            ? Center(
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Color.fromARGB(
                                                      255,
                                                      136,
                                                      94,
                                                      199,
                                                    ),
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

  Future<ImageProvider?> _pickImage() async {
    // 📌 Placeholder image loader — Replace with actual picker later
    return const AssetImage("assets/images/sample.jpeg");
  }
}
