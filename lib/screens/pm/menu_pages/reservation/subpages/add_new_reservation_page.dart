import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewReservationPage extends StatefulWidget {
  const AddNewReservationPage({super.key});

  @override
  State<AddNewReservationPage> createState() => _AddNewReservationPageState();
}

class _AddNewReservationPageState extends State<AddNewReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _productIdCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _productIdCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    setState(() => _submitting = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Reserved Product: ${_productIdCtrl.text}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), // page bg
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product ID field with floating label + icon
                TextFormField(
                  controller: _productIdCtrl,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? "Product ID is required"
                      : null,
                  decoration: InputDecoration(
                    labelText: "Enter Product ID",
                    prefixIcon: const Icon(Icons.qr_code_2, color: Color(0xFF2EB85C)),
                    // remove fill color, keep transparent
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF2EB85C), width: 2),
                    ),
                  ),
                ),

                SizedBox(height: 22.h),

                // Reserve button
                SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2EB85C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                    child: _submitting
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      "Reserve Now",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
