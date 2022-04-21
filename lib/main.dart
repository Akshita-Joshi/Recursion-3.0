import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/ticket.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA9di8b37ur13Q4kATLvskxZmsrNoemtLg",
          appId: "1:755601590737:web:8d3787aa243e6517bd78f0",
          messagingSenderId: "755601590737",
          projectId: "recursion-5dd66"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tickets(),
    );
  }
}
