import 'package:flutter/material.dart';

class AdminCreateUserPage extends StatelessWidget {
  const AdminCreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fill user details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            TextField(decoration: const InputDecoration(labelText: "Name")),
            TextField(decoration: const InputDecoration(labelText: "Email")),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Role"),
              items: const [
                DropdownMenuItem(value: "admin", child: Text("Admin")),
                DropdownMenuItem(value: "manager", child: Text("Manager")),
                DropdownMenuItem(value: "pmm", child: Text("PMM")),
                DropdownMenuItem(value: "pm", child: Text("PM")),
              ],
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: call provider/api to create user
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User Created (Dummy)")),
                );
              },
              child: const Text("Create User"),
            ),
          ],
        ),
      ),
    );
  }
}
