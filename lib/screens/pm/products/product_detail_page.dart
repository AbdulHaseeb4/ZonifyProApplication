import 'package:flutter/material.dart';
import 'package:zonifypro/core/theme.dart';
import 'package:zonifypro/layout/base_layout.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic>? product;
  const ProductDetailPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final data = product ??
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (data == null) {
      return BaseLayout(
        title: "Product Details",
        role: "pm",
        userName: "PM User",
        profileUrl: "",
        child: const Center(
          child: Text(
            "⚠️ No product data found.",
            style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
          ),
        ),
      );
    }

    return BaseLayout(
      title: "Product Details",
      role: "pm",
      userName: "PM User",
      profileUrl: "",
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: AppTheme.card,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Product Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/sample.jpeg",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 📋 Product Info
                Text("Product ID: ${data['productId']}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary)),
                const SizedBox(height: 8),
                Text("Seller: ${data['seller']}",
                    style: const TextStyle(color: AppTheme.textSecondary)),
                Text("Market: ${data['market']}",
                    style: const TextStyle(color: AppTheme.textSecondary)),
                Text("Keywords: ${data['keywords']}",
                    style: const TextStyle(color: AppTheme.textSecondary)),

                const Spacer(),

                // 🔘 Back button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.mint,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back"),
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
