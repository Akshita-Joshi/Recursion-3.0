import 'package:flutter/material.dart';
import 'globals.dart';

class Loader extends StatelessWidget {
  String? message;
  Loader({this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Container(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 3,
            valueColor: new AlwaysStoppedAnimation<Color>(primary!),
          ),
        ),
      )),
    );
  }
}
