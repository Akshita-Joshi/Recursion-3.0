import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recursionhelpdesksystem/EmployeeScreen.dart';
import 'package:recursionhelpdesksystem/dashboard.dart';
import 'package:recursionhelpdesksystem/helpdesk_admin.dart';
import 'package:recursionhelpdesksystem/raise_ticket.dart';
import 'package:recursionhelpdesksystem/screens/home.dart';
import 'Loader.dart';
import 'authenticate.dart';
import 'Firebase.dart';
import 'globals.dart';

var currentName;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  double emailOpacity = 0.0;
  double passOpacity = 0.0;

  static TextStyle _hintText() {
    return TextStyle(
        fontFamily: "Medium",
        fontSize: 24, //24
        color: Colors.black.withOpacity(0.3));
  }

  static TextStyle _inputText() {
    return TextStyle(
        fontFamily: "Medium",
        fontSize: 24, //24
        color: Colors.black);
  }

  static AnimatedOpacity _label(double value, String text) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 120),
      opacity: value,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "Medium",
              fontSize: 14, //14
              color: Colors.black.withOpacity(0.3)),
        ),
      ),
    );
  }

  final ScrollController _scrollController = ScrollController();
  void _callOnTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: getWidth(context) * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade100),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30), //56
                /*InkWell(
                  customBorder: new CircleBorder(),
                  splashColor: Colors.black.withOpacity(0.2),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: height * 0.035, //30
                      width: width * 0.076, //30
                      child: Center(child: Icon(Icons.arrow_back))),
                ),*/
                /*SizedBox(
                  height: height * 0.058, //50
                ),*/
                Text(
                  "Login ",
                  style: TextStyle(
                    fontFamily: "Bold",
                    fontSize: 44, //44
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 50), //50
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.071), //28
                  child: ListView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //field1("Email", _email),
                      //--------------------------------
                      _label(
                        emailOpacity,
                        "Email",
                      ),
                      TextFormField(
                        controller: _email,
                        style: _inputText(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: _hintText(),
                          hintText: "Email",
                        ),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? emailOpacity = 1 : emailOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      SizedBox(height: height * 0.011), //10
                      //field2("Password", _password),
                      //--------------------------------
                      _label(passOpacity, "Password"),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        style: _inputText(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: _hintText(),
                            hintText: "Password"),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? passOpacity = 1 : passOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      /*SizedBox(height: height * 0.011), //10

                      SizedBox(
                        height: height / 2 - (height * 0.35), //300
                      )*/
                    ],
                  ),
                ),
                (_email.text.isNotEmpty && _password.text.isNotEmpty)
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black.withOpacity(0.8)),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Loader(
                                            message:
                                                'Please wait while we \nlog you in..',
                                          )));
                              if (_email.text.isNotEmpty &&
                                  _password.text.isNotEmpty) {
                                logIn(_email.text, _password.text)
                                    .then((user) async {
                                  if (user != null) {
                                    getUser();
                                    var userMap;
                                    var teacherMap;
                                    role == 'Employee'
                                        ? await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get()
                                            .then((value) {
                                            print(value.data());
                                            print(value.data()!['name']);
                                            currentUser = value.data()!['name'];
                                            setState(() {
                                              userMap = value.data()!;
                                              currentName = value.get('name');
                                              heirarchy =
                                                  value.data()!['position'];
                                            });
                                          })
                                        : await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get()
                                            .then((value) {
                                            print(value.data());
                                            print(value.data()!['name']);
                                            currentUser = value.data()!['name'];
                                            heirarchy =
                                                value.data()!['position'];
                                            setState(() {
                                              teacherMap = value.data()!;
                                              //currentName = value.get('name');
                                            });
                                          });

                                    print("Login Successful");
                                    Fluttertoast.showToast(
                                        msg: 'Logged In successfully',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: grey,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    role == 'Employee'
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => EmployeeScreen(),
                                            ))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HelpDeskAdmin()));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    print("Login Failed");
                                    Fluttertoast.showToast(
                                        msg: 'Login Failed',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: grey,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Login()));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              } else {
                                print("Please fill form correctly");
                              }
                            },
                            child: Text(
                              ' Next ',
                              style: TextStyle(
                                fontFamily: "Bold",
                                fontSize: 24, //24
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
