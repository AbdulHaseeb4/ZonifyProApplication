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
  final Set<String> selectedReviewTypes = {};
  final List<String> reviewTypes = [
    'Text Review',
    'Picture Review',
    'Video Review',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildSectionCard(
              icon: Icons.info_outline,
              title: "Product Information",
              children: [
                _buildTextField("Keywords"),
                _buildTextField("Brand Name"),
                _buildTextField("Sold By"),
                _buildTextField("Product Link"),
                _buildDropdown("Seller Type", ["Individual", "Company"]),
                _buildDropdown("Market", ["Daraz", "Amazon", "eBay"]),
                _buildDropdown("Select Category", [
                  "Electronics",
                  "Fashion",
                  "Home",
                  "Toys",
                ]),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              icon: Icons.reviews,
              title: "Review Type",
              children: [
                Wrap(
                  spacing: 10,
                  children: reviewTypes.map((type) {
                    return FilterChip(
                      label: Text(type),
                      selected: selectedReviewTypes.contains(type),
                      onSelected: (selected) {
                        setState(() {
                          selected
                              ? selectedReviewTypes.add(type)
                              : selectedReviewTypes.remove(type);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              icon: Icons.monetization_on,
              title: "Commission & Limits",
              children: [
                _buildTextField("Product Commission"),
                _buildTextField("Sale Limit Per Day"),
                _buildTextField("Overall Sale Limit"),
                _buildTextField("Product Price"),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              icon: Icons.policy,
              title: "Product Policies",
              children: [
                _buildMultilineField("Field Instruction"),
                _buildMultilineField("Refund Conditions"),
                _buildMultilineField("Commission Conditions"),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              icon: Icons.image,
              title: "Product Image",
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Pick image
                  },
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text("Upload Image"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit logic here
                  }
                },
                child: const Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildMultilineField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    String? selectedValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        validator: (value) => value == null ? 'Please select' : null,
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}
