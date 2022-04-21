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
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue as ',
              style: TextStyle(
                fontFamily: "MontserratB",
                fontSize: 36,
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
                child:  Container(
                    child:const Text(
                  '- Employee',
                  style: TextStyle(
                    fontFamily: "MontserratSB",
                    fontSize: 26,
                    color: Colors.black,
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
                  child: Text(
                '- HelpDesk',
                style: TextStyle(
                  fontFamily: "MontserratSB",
                  fontSize: 26,
                  color: Colors.black,
                ),
              )),
            ),
          ],
        ),
      )),
    );
  }
}
