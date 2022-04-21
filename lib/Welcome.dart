import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recursionhelpdesksystem/EmployeeAndHelpDesk.dart';
import 'globals.dart';

//this file has the welcome screen and the student or teacher screen
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            bottom: height * 0.07, //60
            child: Padding(
              padding: EdgeInsets.only(
                  top: height * 0.10,
                  left: height * 0.8,
                  bottom: height * 0.2), //28
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'HelpDesk',
                    style: TextStyle(
                      fontFamily: "ExtraBold",
                      fontSize: 40,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2, //30
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Authcheck.process =
                            "signup"; //sets the global variable to sign up and then UI directs to signup process
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeAndHelpDesk(),
                          ));
                    },
                    child: Container(
                      //this is the get started button

                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontFamily: "Bold",
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.035, //30
                  ),
                  //this is the login line and button
                  Row(
                    children: [
                      Text(
                        'Already a member?  ',
                        style: TextStyle(
                          fontFamily: "Medium",
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Authcheck.process = "login";
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeAndHelpDesk(),
                              ));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "SemiBold",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
