import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Save Contact',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.xmark,
              )),
          actions: [
            Consumer<ContactProvider>(
                builder: (context, value, child) => IconButton(
                      onPressed: () {
                        //
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        String email = emailController.text.trim();
                        int depindex = selDepartment.index;

                        if (name.isEmpty || contact.isEmpty || email.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content:
                                    Text("Please fill in all required fields."),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          value.onsave(name, email, contact, depindex);
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.check,
                        weight: 10,
                        size: 30,
                      ),
                    ))
          ]),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 246, 246, 246),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contactController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Ensure row takes minimum space
                          children: [
                            Text(
                              "Mobile",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 8, // Adjust width between text and icon
                            ),
                            Icon(Icons.arrow_drop_up_rounded),
                            Container(
                              height: 54,
                              width: 1,
                              color: const Color.fromARGB(255, 209, 209, 209),
                            )
                          ],
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 246, 246, 246),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Phone',
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Ensure row takes minimum space
                          children: [
                            Text(
                              "Work",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.arrow_drop_up_rounded),
                            Container(
                              height: 54,
                              width: 1,
                              color: const Color.fromARGB(255, 209, 209, 209),
                            )
                          ],
                        ),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 246, 246, 246),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Email',
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color.fromARGB(255, 246, 246, 246),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selDepartment,
                        items: Department.values
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ))
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
