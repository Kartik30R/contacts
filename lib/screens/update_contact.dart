import 'package:contacts/data&models/contact.dart';
import 'package:contacts/data&models/lists.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class updateContact extends StatefulWidget {
  const updateContact({required this.index, super.key});
  final int index;

  @override
  State<updateContact> createState() => _updateContactState();
}

// ignore: camel_case_types
class _updateContactState extends State<updateContact> {

@override
void initState() {
  super.initState();
  nameController = TextEditingController(text: contacts[widget.index].name);
  contactController = TextEditingController(text: contacts[widget.index].contact);
  emailController = TextEditingController(text: contacts[widget.index].email);
  selDepartment = Department.values[contacts[widget.index].depindex];
}


  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Department selDepartment = Department.Other;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
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
                  hintText: ' Number',
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
                  hintText: 'email ',
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
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        String email = emailController.text.trim();
                        int depindex = selDepartment.index;
        
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          value.update(
                              widget.index, name, contact, email, depindex);
                        }
                        
                        Navigator.pop(context,   );
                        //
                      },
                      child: const Text('Update')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
