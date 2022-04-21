import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recursionhelpdesksystem/HelpDeskLogin.dart';
import 'package:recursionhelpdesksystem/Loader.dart';
import 'package:recursionhelpdesksystem/Register.dart';
import 'package:recursionhelpdesksystem/authenticate.dart';
import 'package:recursionhelpdesksystem/globals.dart';
import 'package:recursionhelpdesksystem/screens/home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Sign Up ",
                    style: TextStyle(
                      fontFamily: "Bold",
                      fontSize: 44, //44
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(height: height * 0.058), //50
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28), //28
                    child: ListView(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      //mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //--------------------------------
                        _label(emailOpacity, "Email"),
                        Container(
                          width: getWidth(context) * 0.3,
                          child: TextFormField(
                            controller: email,
                            style: _inputText(),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: _hintText(),
                                hintText: "Email"),
                            onChanged: (value) {
                              setState(() {
                                value != ''
                                    ? emailOpacity = 1
                                    : emailOpacity = 0;
                              });
                            },
                            onFieldSubmitted: (value) {
                              _callOnTop();
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.011), //10
                        //--------------------------------
                        _label(passOpacity, "Password"),
                        Container(
                          width: getWidth(context) * 0.3,
                          child: TextFormField(
                            controller: password,
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
                            //300
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  [
                    emailOpacity,
                    passOpacity,
                  ].every((element) => element == 1.0)
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
                                                  'Creating your account \nPlease wait.. ',
                                            )));
                                if (email.text.isNotEmpty &&
                                    password.text.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  createAccount(email.text, password.text)
                                      .then((user) async {
                                    if (user != null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      role == 'Employee'
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Register(),
                                              ))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Home(),
                                              ));
                                      Map<String, dynamic> user = {
                                        'role': role,
                                        'email': email.text,
                                        'password': password.text
                                      };
                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .set(user);

                                      print("Account Created Sucessful");
                                      await Fluttertoast.showToast(
                                          msg: 'Account Created Successfully',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: grey,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    } else {
                                      print("Login Failed");
                                      Fluttertoast.showToast(
                                          msg: 'Could not create account',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: grey,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SignUp()));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                } else {
                                  print("Please enter Fields");
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
        ));
  }
}
