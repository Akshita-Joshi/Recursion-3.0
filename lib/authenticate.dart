import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/EmployeeAndHelpDesk.dart';
import 'package:recursionhelpdesksystem/globals.dart';
// import 'package:virya/firebase.dart';
// import 'package:virya/globals.dart';
// import 'package:virya/welcomeandother.dart';



Future<User?> createAccount(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Account Created Successful");
      return user;
    } else {
      print("Account Creation Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    // ignore: unnecessary_null_comparison
    if (user != null) {
      print("Login Successful");
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmployeeAndHelpDesk()),
      );
    });
  } catch (e) {
    print("error");
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
Map<String, dynamic>? userMap;

void addUserData() async {
  if (nameController.text.isNotEmpty &&
      branchController.text.isNotEmpty &&
      divController.text.isNotEmpty &&
      yearController.text.isNotEmpty &&
      rollController.text.isNotEmpty) {
    print(message.text);
    id = Random().nextInt(100000);

    Map<String, dynamic> userData = {
      'email': email.text,
      "name": nameController.text,
      'role': "Employee",
      'degree': degree,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      "status": "Unavailable",
      "timestamp": FieldValue.serverTimestamp().toString(),
      "time": DateTime.now().hour,
         };

    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .update(userData);
  } else {
    print('Enter Some Text');
  }
}

void helpdesk() async {
  if (nameControllerT.text.isNotEmpty && role!.isNotEmpty) {
    Map<String, dynamic> helpdesk = {
      'email': email.text,
      "name": nameControllerT.text,
      'role': "Helpdesk",
      
      'degree':degree,
      'uid': _auth.currentUser!.uid
    };

    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .set(helpdesk);
  } else {
    print('Enter Some Text');
  }
}
