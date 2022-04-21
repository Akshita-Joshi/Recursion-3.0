import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyA9di8b37ur13Q4kATLvskxZmsrNoemtLg", appId: "1:755601590737:web:8d3787aa243e6517bd78f0", messagingSenderId: "755601590737", projectId: "recursion-5dd66")
  );
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
      home: SplashScreen()
    );
  }
}
