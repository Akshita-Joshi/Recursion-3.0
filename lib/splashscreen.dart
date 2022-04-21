import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recursionhelpdesksystem/EmployeeScreen.dart';
import 'package:recursionhelpdesksystem/Welcome.dart';
import 'package:recursionhelpdesksystem/globals.dart';
import 'package:recursionhelpdesksystem/helpdesk_admin.dart';
import 'package:recursionhelpdesksystem/screens/home.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 4;
  var userMap;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    if (FirebaseAuthWeb.instance.currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuthWeb.instance.currentUser!.uid)
            .get()
            .then((value) async {
          setState(() {
            role = value.get('role');
            userMap = value.data();
            currentName = value.get('name');
          });
        });
      } catch (e) {
        try {
          await FirebaseFirestore.instance
              .collection("HelpDesk")
              .doc(FirebaseAuthWeb.instance.currentUser!.uid)
              .get()
              .then((value) {
            setState(() {
              role = value.get("role");
              userMap = value.data();
            });
          });
        } catch (e) {
          print("Error loading user");
        }
      }
      var _duration = Duration(seconds: splashDelay);
      return Timer(_duration, navigationPageloggedIn);
    } else {
      var _duration = Duration(seconds: splashDelay);
      return Timer(_duration, navigationPage);
    }
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Welcome()));
  }

  void navigationPageloggedIn() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      if (role == 'Employee') {
        return EmployeeScreen();
      } else {
        return HelpDeskAdmin();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    media(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          minHeight: 2,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
