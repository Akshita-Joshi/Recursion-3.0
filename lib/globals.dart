import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color? primary = Color(0xFF0CED7F);
Color? secondary = Color(0xFF06371F);

double getHeight(context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

double getWidth(context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

//this file contains all the global variables
FirebaseFirestore firestore = FirebaseFirestore.instance;
var currentName;
var currentYear;

class Drawerclass {
  static bool showMenu = false;
}

class Authcheck {
  static String process = 'login';
}

final grey = const Color(0xFFe0e3e3).withOpacity(0.5);

double? height;
double? width;
void media(BuildContext context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
}

const String _heroAddTodo = 'add-todo-hero';
const String _heroDoubt = 'doubt';
TextEditingController message = TextEditingController();
TextEditingController messageTitle = TextEditingController();
TextEditingController messageDescription = TextEditingController();
String? type;
String? role;
String? imageUrl;
String? docId;
const String? meetlink = "https://meet.google.com/wax-ncmq-eim";
String? to;
int? id;

TextEditingController nameController = TextEditingController();
TextEditingController yearController = TextEditingController();
TextEditingController divController = TextEditingController();
TextEditingController branchController = TextEditingController();
TextEditingController rollController = TextEditingController();

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

TextEditingController nameControllerT = TextEditingController();
TextEditingController fyControllerT = TextEditingController();
TextEditingController syControllerT = TextEditingController();
TextEditingController tyControllerT = TextEditingController();
TextEditingController btechControllerT = TextEditingController();
TextEditingController seqControllerT = TextEditingController();
int? degree;
String? currentUser;
