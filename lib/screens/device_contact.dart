import 'package:contacts/data&models/contact.dart';
import 'package:contacts/data&models/lists.dart';
import 'package:contacts/provider/device_contact_provider.dart';
import 'package:contacts/widget/device_contact_card.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceContact extends StatefulWidget {
  const DeviceContact( {Key? key}) : super(key: key);

  @override
  State<DeviceContact> createState() => _DeviceContactState();
}

class _DeviceContactState extends State<DeviceContact> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 222, 222),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contact List"),
      ),
      body: Container(
        height: double.infinity,
        child: Consumer<DeviceContactsProvider>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getContacts(),
            builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No contacts found.'),
                );
              } else {
                // DeviceContacts=snapshot.data!;
                return 
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Contact contact = snapshot.data![index];
                      return DeviceContactCard(index: index, contact: contact, );
                    },
                  );
                
              }
            },
          ),
        ),
      ),
    );
  }
}
