import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/Login.dart';
import 'package:recursionhelpdesksystem/Signup.dart';
import 'package:recursionhelpdesksystem/globals.dart';

class EmployeeAndHelpDesk extends StatefulWidget {
  const EmployeeAndHelpDesk({Key? key}) : super(key: key);

  @override
  State<EmployeeAndHelpDesk> createState() => _EmployeeAndHelpDeskState();
}

class _EmployeeAndHelpDeskState extends State<EmployeeAndHelpDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
                Text(
                  'Continue as -',
                  style: TextStyle(
                    fontFamily: "Bold",
                    fontSize: 26,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                    radius: 320,
                    splashColor: Colors.black.withOpacity(0.2),
                    onTap: () {
                      setState(() {
                        role = 'Employee';
                      });
                      Authcheck.process == 'signup'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ));
                    },
                    child: Container(
                        width: getWidth(context) * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black.withOpacity(0.8)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: const Text(
                              'Employee',
                              style: TextStyle(
                                fontFamily: "SemiBold",
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))),
                SizedBox(
                  height: 12,
                ),
                InkWell(
                  radius: 320,
                  splashColor: Colors.black.withOpacity(0.2),
                  onTap: () {
                    setState(() {
                      role = 'Helpdesk';
                    });
                    Authcheck.process == 'signup'
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                  },
                  child: Container(
                      width: getWidth(context) * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black.withOpacity(0.8)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            'HelpDesk Admin',
                            style: TextStyle(
                              fontFamily: "SemiBold",
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
