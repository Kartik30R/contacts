import 'package:contacts/provider/contact_provider.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceContactCard extends StatelessWidget {
  const DeviceContactCard({
    Key? key,
    required this.index,
    required this.contact,
  }) : super(key: key);

  final Contact contact;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        width: double.infinity,
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
                  color: Colors.black,
                ),
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
          trailing: IconButton(
            icon: Icon(Icons.add), 
            onPressed: () {
              final contactProvider =
                  Provider.of<ContactProvider>(context, listen: false);

              contactProvider.onsave(
                contact.displayName, 
                contact.emails.isNotEmpty ? contact.emails.first.address : '', 
                contact.phones.isNotEmpty ? contact.phones.first.number : '', 
                0, 
              );
            },
          ),
        ),
      ),
    );
  }
}
