import 'package:contacts/data&models/contact.dart';
import 'package:contacts/data&models/lists.dart';
import 'package:contacts/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Contact', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {Navigator.pop(context);},
              icon: Icon(
                FontAwesomeIcons.xmark,
              )),
          actions: [
            Consumer<ContactProvider>(
                builder: (context, value, child) => IconButton(
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
                      icon: Icon(
                        Icons.check,
                        weight: 10,
                        size: 30,
                      ),
                    ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                                  .min, 
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
                                  width: 8, 
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
                                  .min, 
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
