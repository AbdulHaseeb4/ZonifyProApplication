import 'package:flutter/material.dart';
import 'package:zonifypro/core/theme.dart';
import 'package:zonifypro/layout/base_layout.dart';

class PMReservationPage extends StatefulWidget {
  static final List<Map<String, dynamic>> reservations = [];

  const PMReservationPage({super.key});

  @override
  State<PMReservationPage> createState() => _PMReservationPageState();
}

class _PMReservationPageState extends State<PMReservationPage> {
  void _releaseReservation(int index) {
    setState(() => PMReservationPage.reservations.removeAt(index));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Reservation released")));
  }

  @override
  Widget build(BuildContext context) {
    final reservations = PMReservationPage.reservations;

    return BaseLayout(
      title: "Reservations",
      child: reservations.isEmpty
          ? const Center(
              child: Text(
                "No reservations yet.",
                style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final r = reservations[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🖼 Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            r["image"],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 📋 Product Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product: ${r["productId"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                "Seller: ${r["sellerName"]}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 🔘 Action Buttons
                        Wrap(
                          spacing: 8,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.mint,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Create Order clicked"),
                                  ),
                                );
                              },
                              child: const Text(
                                "Create Order",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.peach,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => _releaseReservation(index),
                              child: const Text(
                                "Release",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
