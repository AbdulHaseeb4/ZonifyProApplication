import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/user_provider.dart';

class AdminCreateUserPage extends ConsumerStatefulWidget {
  const AdminCreateUserPage({super.key});

  @override
  ConsumerState<AdminCreateUserPage> createState() =>
      _AdminCreateUserPageState();
}

class _AdminCreateUserPageState extends ConsumerState<AdminCreateUserPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();

  String? _selectedRole;
  final List<String> _roles = ["admin", "manager", "pmm", "pm"];

  @override
  Widget build(BuildContext context) {
    final userService = ref.watch(userServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create User")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Name", _nameController),
              _buildTextField("Email", _emailController),
              _buildTextField(
                "Password",
                _passwordController,
                isPassword: true,
              ),
              _buildTextField("Gender", _genderController),
              _buildTextField("Address", _addressController),
              _buildTextField("City", _cityController),
              _buildTextField("Country", _countryController),
              _buildTextField("Phone", _phoneController),
              _buildTextField("Bank Name", _bankNameController),
              _buildTextField("Account Number", _accountNumberController),

              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: "Select Role"),
                items: _roles
                    .map(
                      (role) => DropdownMenuItem(
                        value: role,
                        child: Text(role.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val),
                validator: (val) => val == null ? "Please select a role" : null,
              ),

              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await userService.createUser(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        gender: _genderController.text.trim(),
                        address: _addressController.text.trim(),
                        city: _cityController.text.trim(),
                        country: _countryController.text.trim(),
                        phone: _phoneController.text.trim(),
                        bankName: _bankNameController.text.trim(),
                        accountNumber: _accountNumberController.text.trim(),
                        role: _selectedRole!,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("✅ User Created Successfully"),
                        ),
                      );

                      Navigator.pop(context); // go back
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("❌ Error: $e")));
                    }
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Create User"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (val) => val == null || val.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
