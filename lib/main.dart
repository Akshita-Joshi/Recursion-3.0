import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "HelpDesk",
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return Center(
            child: Container(
              child: Text("Loading..."),
            ),
          );
        };
        return widget!;
      },
      home: Scaffold(
          body: Container(
        child: Text("home"),
      )),
    );
  }
}
