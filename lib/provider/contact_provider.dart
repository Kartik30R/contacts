import 'dart:convert';
import 'dart:io';

import 'package:contacts/data&models/contact.dart';
import 'package:contacts/data&models/lists.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider extends ChangeNotifier {
  late SharedPreferences sp;
  int selectedIndex = -1;

  int getLength() {
    return contacts.length;
  }

  void update(
      int index, String name, String contact, String email, int depindex) {
    contacts[index].name = name;
    contacts[index].contact = contact;
    contacts[index].email = email;
    contacts[index].depindex = depindex;
    saveIntoSp();
    notifyListeners();
  }

  Future<void> onsave(
      String name, String email, String phone, int depindex) async {
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

  Future<void> getCsv() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    List<List<dynamic>> rows = [];
    List<dynamic> headerRow = ["number", "email", "name", "department"];
    rows.add(headerRow);

    for (int i = 0; i < contacts.length; i++) {
      List<dynamic> row = [
        contacts[i].name,
        Department.values[contacts[i].depindex].toString(),
        contacts[i].contact,
        contacts[i].email,
      ];
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      String dir = directory.path;
      print("dir $dir");
      String filePath = "$dir/filename.csv";
      File file = File(filePath);

      await file.writeAsString(csv);
      print("CSV file saved at: $filePath");
    } else {
      print("Error: Unable to access external storage directory.");
    }

    notifyListeners();
  }
}
