import 'package:contacts/data&models/contact.dart';
import 'package:flutter/material.dart';

Widget getRow(int index, BuildContext context, bool select,List contacts) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      height: 120,
      width: double.infinity,
      child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index % 2 == 0 ? const Color.fromARGB(255, 203, 184, 255) : Color.fromARGB(255, 255, 180, 202),
            ),
            child: Center(
              child: Text(
                contacts[index].name[0].toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20,color: Colors.black),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contacts[index].name.toUpperCase(),
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Color.fromARGB(255, 203, 184, 255) 
                            : Color.fromARGB(255, 255, 180, 202),
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(select? Department.values[0].toString():
                      Department.values[contacts[index].depindex].name,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
                    )),
                Text( select? contacts[index].phones.first:contacts[index].contact),
                Text(select? contacts[index].emails.first :contacts[index].email),
               
              ],
            ),
          ),
          ),
    ),
  );
}
