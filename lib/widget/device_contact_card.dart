import 'package:contacts/data&models/contact.dart';
import 'package:contacts/data&models/lists.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';


class DeviceContactCard extends StatelessWidget {
  const DeviceContactCard({super.key, required this.index, required this.contact});
  

  final Contact contact ;
  final index;
  @override
  Widget build(BuildContext context) {
  _save(int index) {
  if (index >= 0 && index < DeviceContacts.length) {
    contacts.add(ContactModel(
      name: DeviceContacts[index].displayName ?? 'Unknown',
      contact: DeviceContacts[index].phones?.first.number ?? 'No phone',
      email: DeviceContacts[index].emails?.first.address ?? 'No email',
      depindex: 0,
    ));
  }
}


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        // height: 80,
        width: double.infinity,
        child: InkWell(
          onTap: () => _save(index),
          child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: index % 2 == 0
                    ? const Color.fromARGB(255, 203, 184, 255)
                    : Color.fromARGB(255, 255, 180, 202),
              ),
              child: Center(
                child: Text(
                  contact.displayName.isNotEmpty
                      ? contact.displayName.substring(0, 1).toUpperCase()
                      : '?',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
            ),
            title: Text(contact.displayName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (contact.phones.isNotEmpty)
                  Text(contact.phones.first.number),
                if (contact.emails.isNotEmpty)
                  Text(contact.emails.first.address),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
