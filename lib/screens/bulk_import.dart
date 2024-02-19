import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:provider/provider.dart';
import 'package:contacts/provider/contact_provider.dart'; 

class BulkUpload extends StatefulWidget {
  const BulkUpload({Key? key}) : super(key: key);

  @override
  State<BulkUpload> createState() => _BulkUploadState();
}

class _BulkUploadState extends State<BulkUpload> {
  List<List<dynamic>> _data = [];
  String? filePath;

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: (){ for (int i = 1; i < _data.length; i++) {
                contactProvider.onsave(
                  _data[i][0].toString(),
                  _data[i][2].toString(),
                  _data[i][1].toString(),
                  0, 
                );
              }}, child: Text('save'))],
        title: const Text(
          "Bulk Upload",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Upload File"),
            onPressed: () async {
              await _pickFile();
              for (int i = 1; i < _data.length; i++) {
                contactProvider.onsave(
                  _data[i][0].toString(),
                  _data[i][2].toString(),
                  _data[i][1].toString(),
                  0,
                );
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, index) {
                return Card(
                  margin: const EdgeInsets.all(3),
                  color: index == 0 ? Colors.amber : Colors.white,
                  child: ListTile(
                    leading: Text(
                      _data[index][0].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: index == 0 ? 18 : 15,
                        fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                        color: index == 0 ? Colors.red : Colors.black,
                      ),
                    ),
                    title: Text(
                      _data[index][1].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: index == 0 ? 18 : 15,
                        fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                        color: index == 0 ? Colors.red : Colors.black,
                      ),
                    ),
                    trailing: Text(
                      _data[index][2].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: index == 0 ? 18 : 15,
                        fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                        color: index == 0 ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });
  }
}
