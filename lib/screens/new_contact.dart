import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contacts/data&models/contact.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Department selDepartment = Department.Other;

  int selectedIndex = -1;

   final String apiUrl = 'https://stage.app.studiovity.com/api/v1/contactbook/get?projectId=65b499e8728d714f44927da7';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MzkxNmQ4Zjk2NDI4M2Y4YjhlZWRkMzIiLCJpYXQiOjE3MDY1NzgyNjMsImV4cCI6MTcxMTc2MjI2MywidHlwZSI6ImFjY2VzcyJ9.mjGkZpYdEYzf4YKQRoL7-9tdfbteyv0Nc6qAcOBnF7E';

  Future<void> _saveContact() async {
    String name = nameController.text.trim();
    String contact = contactController.text.trim();
    String email = emailController.text.trim();
    int depindex = selDepartment.index;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'contact': contact,
          'email': email,
          'department': depindex,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success, you may want to show a success message
        print('Contact saved successfully');
        Navigator.pop(context);
      } else {
        // Handle errors, you may want to show an error message
        print('Failed to save contact. Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Exception while saving contact: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contactController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    hintText: 'Contact Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: 'email Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
              ),
              DropdownButton(
                value: selDepartment,
                items: Department.values
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category.name.toUpperCase())))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selDepartment = value as Department;
                  });
                },
              ),
              const SizedBox(height: 10),
              Consumer<ContactProvider>(
                builder: (ctx, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //
                          String name = nameController.text.trim();
                          String contact = contactController.text.trim();
                          String email = emailController.text.trim();
                          int depindex = selDepartment.index;
          
                          value.onsave(name, email, contact, depindex);
                          _saveContact();
                          Navigator.pop(context);
                        },
                        child: const Text('Save')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}