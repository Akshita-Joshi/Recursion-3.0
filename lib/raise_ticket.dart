import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:recursionhelpdesksystem/backendticket.dart';
import 'package:recursionhelpdesksystem/controllers.dart';
import 'package:recursionhelpdesksystem/filepixk.dart';
import 'package:recursionhelpdesksystem/helpdesk_admin.dart';
import 'package:recursionhelpdesksystem/main.dart';
import 'package:recursionhelpdesksystem/screens/home.dart';

class Tickets extends StatefulWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = "Ask for Quote";
  String dropdownValue1 = "Low";
  bool priority = false;
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 80, 0, 0),
                  child: RichText(
                    text: const TextSpan(
                      text: "Ticket",
                      style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: 36,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 800,
              padding: EdgeInsets.symmetric(
                vertical: 80.0,
                horizontal: 60.0,
              ),
              child: _buildForm(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 0.0),
              child: Container(
                alignment: Alignment(0.75, 0.5),
                child: ElevatedButton(
                  onPressed: () async {
                    await sendTicketInfo(
                        "1",
                        Name.text,
                        dropdownValue.toString(),
                        Subject.text,
                        priority,
                        //dropdownValue1.toString(),
                        _email.text,
                        time.text);
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HelpDeskAdmin()));
                      print('All validations passed!');
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'ProductSansBold',
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 180, 180, 180),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  Form _buildForm() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//Department
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: const TextSpan(
                          text: "Department",
                          style: TextStyle(
                            fontFamily: 'ProductSans',
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      elevation: 16,
                      dropdownColor: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18.0),
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Support Department',
                        'Ask for Quote',
                        'Improvements Department'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(40)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Icon(
                          Iconsax.profile_2user,
                          color: Colors.grey.shade400,
                        )),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //width: getWidth(context) * 0.1,
                        child: Text(
                          FirebaseAuth.instance.currentUser!.displayName!
                              .toString(),
                          style: TextStyle(
                            fontFamily: 'Bold',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        //width: getWidth(context) * 0.1,
                        child: Text(
                          FirebaseAuth.instance.currentUser!.email!.toString(),
                          style: TextStyle(
                            fontFamily: 'Medium',
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

//Name
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: Name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '\u26A0 First Name cannot be empty';
                    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                        .hasMatch(value)) {
                      return '\u26A0 Enter valid First Name';
                    } else if (value.length < 2) {
                      return '\u26A0 First Name must be at least 2 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16, //16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

//email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _email,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(value)) {
                      return 'Please enter a valid email Address';
                    }

                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                  style: const TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16, //16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),*/

//Subject
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: Subject,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '\u26A0 Subject cannot be empty';
                    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                        .hasMatch(value)) {
                      return '\u26A0 Enter Subject';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                    ),
                    labelText: "Subject",
                    labelStyle: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

//message
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: Message,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '\u26A0 Message cannot be empty';
                    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                        .hasMatch(value)) {
                      return '\u26A0 Enter Message';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                    ),
                    labelText: "message",
                    labelStyle: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

//Attachment
              /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      constraints: BoxConstraints(
                        minWidth: 400,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Future<void> addSubmission() async {
                            final _storage = FirebaseStorage.instance;

                            await Permission.storage.request();
                            var permissionStatus =
                                await Permission.storage.status;
                            if (permissionStatus.isGranted) {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'doc'],
                              );
                              PlatformFile pdf;
                              var fileName =
                                  result!.paths.toString().split('/').last;
                              if (result != null) {
                                setState(() {
                                  var submitting = true;
                                });
                                var snapshot = await _storage
                                    .ref()
                                    .child(
                                        '$fileName-${FirebaseAuth.instance.currentUser!.uid}')
                                    .putFile(File(result.files.first.path!));
                                var downloadUrl =
                                    await snapshot.ref.getDownloadURL();
                                Map<String, dynamic> map = {
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  'file': downloadUrl.toString(),
                                  'filename': fileName.toString()
                                };
                                try {
                                  await FirebaseFirestore.instance
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set(map);
                                  setState(() {});
                                } catch (e) {
                                  setState(() {});
                                }
                              }
                            }
                          }
                        },
                        child: null,
                      )
                      // ElevatedButton(
                      //   child: Text("Pick File Attachment"),
                      //   onPressed: () async {
                      //     final result = await FilePicker.platform.pickFiles();
                      //     if (result == null) return;
                      //     final file = result.files.first;
                      //     //openFile(file);

                      //     print('Name: ${file.name}');
                      //     print('Bytes: ${file.bytes}');
                      //     print('Size: ${file.size}');
                      //     print('Extension: ${file.extension}');
                      //     print('Path: ${file.path}');

                      //     final newFile = await saveFilePermanently(file);

                      //     print('From Path: ${file.path!}');
                      //     print('To Path: ${newFile.path}');
                      //   },
                      // ),
                      )),*/
              SizedBox(
                height: height * 0.02,
              ),

//time
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: time,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return '\u26A0 Time cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(width: 10.0, color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                    ),
                    labelText: "Time",
                    hintText: "Time in hours",
                    hintStyle: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16, //16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16, //16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                height: height * 0.02,
              ),

//Priority
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: const TextSpan(
                        text: "Priority",
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                  ),
                ),*/
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1)),
                          child: Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                                side: BorderSide.none,
                                checkColor: Colors.lightBlue,
                                shape: CircleBorder(),
                                activeColor: Colors.lightBlue,
                                value: priority,
                                onChanged: (value) {
                                  setState(() {
                                    priority = value!;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Set high priority',
                          style: TextStyle(fontFamily: 'Medium', fontSize: 16),
                        )
                      ],
                    ))
                //       padding: const EdgeInsets.all(8.0),
                //       child: DropdownButton<String>(
                //         value: dropdownValue1,
                //         elevation: 16,
                //         dropdownColor: Colors.grey[300],
                //         borderRadius: BorderRadius.circular(18.0),
                //         style:
                //             const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             dropdownValue1 = newValue!;
                //           });
                //         },
                //         items: <String>['High', 'Low']
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ],
                // ),
              ]),
              SizedBox(
                height: height * 0.02,
              ),
            ]),
      ),
    );
  }
}
