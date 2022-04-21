import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/helpdesk_admin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA9di8b37ur13Q4kATLvskxZmsrNoemtLg",
          appId: "1:755601590737:web:a7f85ea998c51dadbd78f0",
          messagingSenderId: "755601590737",
          projectId: "recursion-5dd66"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: HelpDeskAdmin(),
    );
  }
}
