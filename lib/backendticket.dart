import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recursionhelpdesksystem/controllers.dart';

sendTicketInfo(String id, String name, String department, String subject,
    bool priority, String emailaddress, String time) {
  var ticketsinfo = {
    "id": id,
    "name": FirebaseAuth.instance.currentUser!.displayName,
    "dept": department,
    "message": Message.text,
    "subject": subject,
    "status": 'unsolved',
    "priority": priority,
    "email": FirebaseAuth.instance.currentUser!.email,
    "time": time,
    'profile': null,
    'attachment': null,
    'hierarchy': 'Clerk'
  };
  FirebaseFirestore.instance.collection("Tickets").add(ticketsinfo);
}

updateTicketInfo(bool ifpermission, String id, String name, String department,
    String subject, String priority, String email, String time) {
  if (ifpermission) {
    var ticketsinfo = {
      "id": id,
      "name": name,
      "department": department,
      "subject": subject,
      "priority": priority,
      "Email": email,
      "Time": time,
    };
    FirebaseFirestore.instance
        .collection("TicketInfo")
        .doc("id")
        .update(ticketsinfo);
  }
}
