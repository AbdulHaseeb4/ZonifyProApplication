import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../core/dashboard_wrapper.dart';
import '../../../layout/base_layout.dart';
import '../../../providers/user_provider.dart';

class AdminCreateUserPage extends ConsumerStatefulWidget {
  const AdminCreateUserPage({super.key});

  @override
  ConsumerState<AdminCreateUserPage> createState() =>
      _AdminCreateUserPageState();
}

class _AdminCreateUserPageState extends ConsumerState<AdminCreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();

  String? _selectedRole;
  String? _selectedGender;
  bool _obscurePassword = true;

  /// Roles list
  final List<({String value, String label, IconData icon, Color color})>
  _roles = [
    (
      value: "admin",
      label: "Admin",
      icon: Icons.admin_panel_settings_outlined,
      color: Colors.red,
    ),
    (
      value: "manager",
      label: "Manager",
      icon: Icons.manage_accounts_outlined,
      color: Colors.blue,
    ),
    (
      value: "pmm",
      label: "PMM",
      icon: Icons.analytics_outlined,
      color: Colors.green,
    ),
    (
      value: "pm",
      label: "PM",
      icon: Icons.assignment_ind_outlined,
      color: Colors.purple,
    ),
  ];

  final List<({String value, String label, IconData icon, Color color})>
  _genders = [
    (
      value: "Male",
      label: "Male",
      icon: Icons.male_outlined,
      color: Colors.blue,
    ),
    (
      value: "Female",
      label: "Female",
      icon: Icons.female_outlined,
      color: Colors.pink,
    ),
    (
      value: "Other",
      label: "Other",
      icon: Icons.transgender_outlined,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final userService = ref.watch(userServiceProvider);

    return DashboardWrapper(
      defaultRole: "admin",
      child: BaseLayout(
        title: "Create User",
        child: Stack(
          children: [
            // 🎨 Background Egg Shapes
            Positioned(
              top: -150,
              right: -180,
              child: Container(
                width: 420,
                height: 420,
                decoration: const BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -160,
              left: -160,
              child: Container(
                width: 400,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // 📝 Main Card
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 1100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Create New User",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          _buildCardField(
                            "Name",
                            _nameController,
                            Icons.person_outline,
                          ),
                          _buildCardField(
                            "Email",
                            _emailController,
                            Icons.email_outlined,
                          ),
                          _buildCardField(
                            "Password",
                            _passwordController,
                            Icons.lock_outline,
                            isPassword: true,
                          ),
                          _buildModernDropdown(
                            label: "Gender *",
                            value: _selectedGender,
                            data: _genders,
                            onChanged: (val) =>
                                setState(() => _selectedGender = val),
                            validator: (val) =>
                                val == null ? "⚠ Please select gender" : null,
                            defaultIcon: Icons.wc_outlined, // ✅ different icon
                          ),
                          _buildCardField(
                            "Address",
                            _addressController,
                            Icons.home_outlined,
                          ),
                          _buildCardField(
                            "City",
                            _cityController,
                            Icons.location_city_outlined,
                          ),
                          _buildCardField(
                            "Country",
                            _countryController,
                            Icons.public_outlined,
                          ),
                          _buildCardField(
                            "Phone",
                            _phoneController,
                            Icons.phone_outlined,
                          ),
                          _buildCardField(
                            "Bank Name",
                            _bankNameController,
                            Icons.account_balance_outlined,
                          ),
                          _buildCardField(
                            "Account Number",
                            _accountNumberController,
                            Icons.credit_card_outlined,
                          ),
                          _buildModernDropdown(
                            label: "Select Role *",
                            value: _selectedRole,
                            data: _roles,
                            onChanged: (val) =>
                                setState(() => _selectedRole = val),
                            validator: (val) =>
                                val == null ? "⚠ Please select a role" : null,
                            defaultIcon: Icons.security_outlined,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // 🌈 Create User Button
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFBBDEFB), Color(0xFF64B5F6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await userService.createUser(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  gender: _selectedGender ?? "",
                                  address: _addressController.text.trim(),
                                  city: _cityController.text.trim(),
                                  country: _countryController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  bankName: _bankNameController.text.trim(),
                                  accountNumber: _accountNumberController.text
                                      .trim(),
                                  role: _selectedRole!,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "✅ User Created Successfully",
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("❌ Error: $e")),
                                );
                              }
                            } else {
                              setState(() {
                                _autoValidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 14,
                            ),
                            child: Text(
                              "Create User",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card-like TextField
  Widget _buildCardField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
  }) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          decoration: InputDecoration(
            labelText: "$label *",
            floatingLabelStyle: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.lightBlue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            prefixIcon: Icon(icon, size: 18, color: Colors.lightBlue),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  )
                : null,
          ),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          validator: (val) =>
              val == null || val.isEmpty ? "⚠ $label is required" : null,
        ),
      ),
    );
  }

  /// Modern Dropdown with DropdownButton2
  Widget _buildModernDropdown({
    required String label,
    required String? value,
    required List<({String value, String label, IconData icon, Color color})>
    data,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
    required IconData defaultIcon,
  }) {
    return SizedBox(
      width: 280,
      child: DropdownButtonFormField2<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelStyle: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.lightBlue, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
        hint: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 10), // ✅ spacing
              child: Icon(
                defaultIcon,
                color: Colors.lightBlue,
                size: 18,
              ), // ✅ blue
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        items: data.map((item) {
          return DropdownMenuItem<String>(
            value: item.value,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 10,
                  ), // ✅ spacing
                  child: Icon(item.icon, color: item.color, size: 18),
                ),
                Text(
                  item.label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        validator: validator,
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          elevation: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor: MaterialStatePropertyAll(Color(0xFFE3F2FD)),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
        ),
      ),
    );
  }
}
