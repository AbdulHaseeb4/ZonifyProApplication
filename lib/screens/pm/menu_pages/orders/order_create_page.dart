// 📌 File name: order_create_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class OrderCreatePage extends StatefulWidget {
  final Map<String, dynamic> reservation;

  const OrderCreatePage({super.key, required this.reservation});

  @override
  State<OrderCreatePage> createState() => _OrderCreatePageState();
}

class _OrderCreatePageState extends State<OrderCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _orderNoCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _reviewLinkCtrl = TextEditingController();

  /// multiple images
  final List<File> _orderPics = [];
  final List<File> _refundPics = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final r = widget.reservation;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create New Order",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Reservation Product Image Only ---
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  r["image"],
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 24.h),

              /// --- Section: Order Details ---
              _buildSectionTitle("Order Details"),

              _buildTextField(
                controller: _orderNoCtrl,
                label: "Order Number",
                required: true,
              ),
              SizedBox(height: 16.h),

              _buildTextField(
                controller: _emailCtrl,
                label: "Customer Email",
                required: true,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),

              _buildTextField(
                controller: _reviewLinkCtrl,
                label: "AMZ Review Link (Optional)",
              ),

              SizedBox(height: 24.h),

              /// --- Section: Uploads ---
              _buildSectionTitle("Uploads"),

              /// Row: Order Pic + Refund Pic
              Row(
                children: [
                  Expanded(
                    child: _buildImagePickerField("Order Pics", _orderPics),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildImagePickerField("Refund Pics", _refundPics),
                  ),
                ],
              ),

              SizedBox(height: 28.h),

              /// --- Submit Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("✅ Order Created Successfully!"),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Create Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
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

  /// 🔹 Section Title with rounded underline
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.h, bottom: 20.h),
          height: 4,
          width: 120.w,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }

  /// 🔹 TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black87, fontSize: 13.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
      ),
      validator: required
          ? (val) => val == null || val.isEmpty ? "$label is required" : null
          : null,
    );
  }

  /// 🔹 Image Picker Field (Upload button + small thumbnails + fixed cross button)
  Widget _buildImagePickerField(String label, List<File> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 6.h),

        Row(
          children: [
            /// Upload Button (fixed)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                side: const BorderSide(color: Colors.blueAccent, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                minimumSize: Size(100.w, 40.h), // 👈 button ka size fix
              ),
              onPressed: () async {
                if (images.length >= 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("⚠️ Maximum 4 images allowed"),
                    ),
                  );
                  return;
                }
                final picked = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 75);
                if (picked != null) {
                  setState(() {
                    images.add(File(picked.path));
                  });
                }
              },
              icon: const Icon(Icons.upload_file,
                  color: Colors.blueAccent, size: 18),
              label: const Text(
                "Upload",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),

            SizedBox(width: 8.w),

            /// Images scrollable list
            Expanded(
              child: SizedBox(
                height: 50.h, // 👈 thumbnails fixed height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        /// Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            images[index],
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.cover,
                          ),
                        ),

                        /// Cross button top-right corner
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                images.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }




}
