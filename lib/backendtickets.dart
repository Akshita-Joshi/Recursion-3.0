import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recursionhelpdesksystem/globals.dart';

sendTicketInfo(String id, String name, String department, String subject,
    String priority, String emailaddress) {
  var ticketsinfo = {
    "id": id,
    "name": name,
    "department": department,
    "subject": subject,
    "priority": priority,
    "Email": emailaddress
  };
  FirebaseFirestore.instance.collection("TicketInfo").add(ticketsinfo);
}

updateTicketInfo(bool ifpermission, String id, String name, String department,
    String subject, String priority, String email) {
  if (ifpermission) {
    var ticketsinfo = {
      "id": id,
      "name": name,
      "department": department,
      "subject": subject,
      "priority": priority,
      "Email": email,
    };
    FirebaseFirestore.instance
        .collection("TicketInfo")
        .doc("id")
        .update(ticketsinfo);
  }
}

hierarchy(String position) async {
  FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
        "position": position,
      });
  FirebaseFirestore.instance
      .collection("Hierarchy")
      .doc(position)
      .collection("list")
      .add({
    "Position": position,
    "Username": FirebaseAuth.instance.currentUser!.email,
  });

  var number = FirebaseFirestore.instance
      .collection("Hierarchy")
      .doc(position)
      .collection("list")
      .get()
      .then((value) {
    print(value.docs.length);
  });
}
