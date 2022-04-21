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
const String CAPTCHA_SITE_KEY = "6Lf9aY4fAAAAAJ8LafezMcqlNX4wCLzOqWACcQ3A";

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
              padding: EdgeInsets.only(top: height * 0.10, left: height*0.8, bottom: height*0.2), //28
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                      height: height * 0.090, //50
                      width: width *0.08, //56
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontFamily: "MontserratSB",
                            fontSize: width * 0.015, //20
                            color: Colors.white,
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
                          fontFamily: "Montserrat",
                          fontSize: width * 0.015, //18
                          color: Colors.black,
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
                            fontFamily: "MontserratB",
                            fontSize: width * 0.015, //20
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
          ,
          
        ],
      )),
    );
  }
}