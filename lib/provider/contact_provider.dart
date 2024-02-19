import 'dart:convert';
import 'dart:io';
import 'package:contacts/data&models/contact.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider extends ChangeNotifier {
  late SharedPreferences sp;
  int selectedIndex = -1;
  List<ContactModel> contacts = [];

  int getLength() {
    return contacts.length;
  }

  void update(int index, String name, String contact, String email, int depindex) {
    contacts[index].name = name;
    contacts[index].contact = contact;
    contacts[index].email = email;
    contacts[index].depindex = depindex;
    saveIntoSp();
    notifyListeners();
  }

  Future<void> onsave(String name, String email, String phone, int depindex) async {
    print('run');
    contacts.add(ContactModel(
        name: name, contact: phone, email: email, depindex: depindex));
    saveIntoSp();
    final String apiUrl =
        'https://stage.app.studiovity.com/api/v1/contactbook/get?projectId=65b499e8728d714f44927da7';
    final String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MzkxNmQ4Zjk2NDI4M2Y4YjhlZWRkMzIiLCJpYXQiOjE3MDY1NzgyNjMsImV4cCI6MTcxMTc2MjI2MywidHlwZSI6ImFjY2VzcyJ9.mjGkZpYdEYzf4YKQRoL7-9tdfbteyv0Nc6qAcOBnF7E';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'contact': phone,
          'email': email,
          'department': depindex,
        }),
      );

      if (response.statusCode == 200) {
        print('Contact saved successfully');
      } else {
        print('Failed to save contact. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Exception while saving contact: $error');
    }
    notifyListeners();
  }

  void onremove(int index) {
    if (index >= 0) {
      contacts.removeAt(index);
      saveIntoSp();
    } else {
      return;
    }
    notifyListeners();
  }

  Future<void> getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
    notifyListeners();
  }

  void saveIntoSp() {
    List<String> contactListString =
        contacts.map((contact) => jsonEncode(contact.toJson())).toList();
    sp.setStringList('myData', contactListString);
    notifyListeners();
  }

  void readFromSp() {
    List<String>? contactListString = sp.getStringList('myData');
    if (contactListString != null) {
      contacts = contactListString
          .map((contact) => ContactModel.fromJson(json.decode(contact)))
          .toList();
      notifyListeners();
    }


    
  }

//  void pickFile(BuildContext context) async {
//     List<List<dynamic>> _data = [];
//     String? filePath;

//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);

//     // if no file is picked
//     if (result == null) return;
//     // we will log the name, size and path of the
//     // first picked file (if multiple are selected)
//     print(result.files.first.name);
//     filePath = result.files.first.path!;

//     final input = File(filePath!).openRead();
//     final fields = await input
//         .transform(utf8.decoder)
//         .transform(const CsvToListConverter())
//         .toList();
//     print(fields);

//     for (var field in fields) {
//       if (field.length >= 3) {
//         String name = field[0];
//         String contact = field[1].toString();
//         String email = field[2];
//         int depindex = Department.Other.index;
//         if (field.length > 3) {
//           String department = field[3].toString();
//           depindex = Department.values.indexWhere((e) => e.toString().split('.')[1] == department);
//           if (depindex == -1) {
//             depindex = Department.Other.index;
//           }
//         }
        
//         onsave(name, email, contact, depindex);
//         print('saved');
//       }
//     }
//     notifyListeners();
//   }
}
