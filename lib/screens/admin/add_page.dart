import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  final _refIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _accountController = TextEditingController();
  final _addressController = TextEditingController();

  String _selectedRole = "Admin";
  bool _obscurePassword = true;

  static const Color gradientStart = Color(0xFF2196F3);
  static const Color gradientEnd = Color(0xFF90CAF9);

  bool isValidEmail(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    // Listeners to rebuild on text change
    _refIdController.addListener(_update);
    _nameController.addListener(_update);
    _emailController.addListener(_update);
    _passwordController.addListener(_update);
    _phoneController.addListener(_update);
    _accountController.addListener(_update);
    _addressController.addListener(_update);
  }

  void _update() => setState(() {});

  @override
  void dispose() {
    _refIdController.removeListener(_update);
    _nameController.removeListener(_update);
    _emailController.removeListener(_update);
    _passwordController.removeListener(_update);
    _phoneController.removeListener(_update);
    _accountController.removeListener(_update);
    _addressController.removeListener(_update);

    _refIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _accountController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 8.h),

              _buildField(
                controller: _refIdController,
                label: "Reference ID",
                icon: Icons.badge_outlined,
                validator: (v) => v!.isEmpty ? "Reference ID is required" : null,
              ),
              SizedBox(height: 16.h),

              _buildField(
                controller: _nameController,
                label: "Name",
                icon: Icons.person_outline,
                validator: (v) => v!.isEmpty ? "Name is required" : null,
              ),
              SizedBox(height: 16.h),

              _buildField(
                controller: _emailController,
                label: "Email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty
                    ? "Email is required"
                    : (!isValidEmail(v) ? "Invalid email" : null),
              ),
              SizedBox(height: 16.h),

              _buildField(
                controller: _passwordController,
                label: "Password",
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blueAccent,
                    size: 20.sp,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (v) => v!.isEmpty
                    ? "Password is required"
                    : (v.length < 8 ? "Min 8 characters" : null),
              ),
              SizedBox(height: 16.h),

              _buildField(
                controller: _phoneController,
                label: "Phone Number",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
                validator: (v) => v!.isEmpty
                    ? "Phone number is required"
                    : (v.length < 11 ? "Must be 11 digits" : null),
              ),
              SizedBox(height: 16.h),

              _buildField(
                controller: _accountController,
                label: "Account Number",
                icon: Icons.account_balance_outlined,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16)
                ],
                validator: (v) => v!.isEmpty
                    ? "Account number is required"
                    : (v.length < 8 ? "Too short" : null),
              ),
              SizedBox(height: 16.h),

              _buildField(
                controller: _addressController,
                label: "Address",
                icon: Icons.location_on_outlined,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                validator: (v) => v!.isEmpty ? "Address is required" : null,
              ),
              SizedBox(height: 16.h),

              /// Dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4.r,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black54, size: 20.sp),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ).copyWith(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                  ),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                  value: _selectedRole,
                  items: const [
                    DropdownMenuItem(
                        value: "Admin",
                        child: Row(children: [
                          Icon(Icons.security, color: Colors.blueAccent, size: 20),
                          SizedBox(width: 8),
                          Text("Admin"),
                        ])),
                    DropdownMenuItem(
                        value: "Manager",
                        child: Row(children: [
                          Icon(Icons.people_alt_outlined, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Text("Manager"),
                        ])),
                    DropdownMenuItem(
                        value: "PMM",
                        child: Row(children: [
                          Icon(Icons.shopping_cart_outlined, color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Text("PMM"),
                        ])),
                    DropdownMenuItem(
                        value: "PM",
                        child: Row(children: [
                          Icon(Icons.person, color: Colors.purple, size: 20),
                          SizedBox(width: 8),
                          Text("PM"),
                        ])),
                  ],
                  onChanged: (value) => setState(() => _selectedRole = value!),
                ),
              ),
              SizedBox(height: 24.h),

              /// Create Account Button
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 180.w,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [gradientStart, gradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 10.r,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r)),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("User Created Successfully")),
                          );
                        }
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    int? maxLines = 1,
    int minLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4.r,
              offset: const Offset(0, 2))
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent, size: 20.sp),
          suffixIcon: suffixIcon ??
              (controller.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  controller.clear();
                  setState(() {});
                },
              )
                  : null),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black54, fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        ),
      ),
    );
  }
}
