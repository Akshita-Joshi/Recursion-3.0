import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recursionhelpdesksystem/authenticate.dart';
import 'package:recursionhelpdesksystem/globals.dart';
import 'package:recursionhelpdesksystem/screens/accounts.dart';
import 'package:recursionhelpdesksystem/screens/history.dart';
import 'package:recursionhelpdesksystem/screens/home.dart';
import 'package:recursionhelpdesksystem/screens/statistics.dart';

class HelpDeskAdmin extends StatefulWidget {
  const HelpDeskAdmin({Key? key}) : super(key: key);

  @override
  State<HelpDeskAdmin> createState() => _HelpDeskAdminState();
}

class _HelpDeskAdminState extends State<HelpDeskAdmin> {
  bool? option = true;
  List<bool> options = [true, false, false, false];
  int? current_index = 0;
  List<Widget> screens = [Home(), History(), Accounts(), Statistics()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: 
          ),
        ),
      ),*/
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade50,
            width: getWidth(context) * 0.2,
            child: Expanded(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Row(
                    children: [
                      /*Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: primary),
                            child: Center(
                              child: Text(
                                'H',
                                style: TextStyle(
                                    fontFamily: 'Bold',
                                    color: secondary,
                                    fontSize: 20),
                              ),
                            ),
                          ),*/
                      SizedBox(
                        width: 16,
                      ),
                      const Text(
                        'Helpdesk',
                        style: TextStyle(
                            fontFamily: 'ExtraBold',
                            fontSize: 24,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                /*SizedBox(
                  height: 10,
                ),*/
                Container(
                  height: 2,
                  width: getWidth(context),
                  color: Colors.grey.shade100,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                options[current_index!] = false;
                                current_index = 0;
                                options[current_index!] = true;
                              });
                            },
                            child: SideBarOption(
                                selected: options[0],
                                icon: Iconsax.home_1,
                                title: 'Home'),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                options[current_index!] = false;
                                current_index = 1;
                                options[current_index!] = true;
                              });
                            },
                            child: SideBarOption(
                                selected: options[1],
                                icon: Iconsax.timer,
                                title: 'History'),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                options[current_index!] = false;
                                current_index = 2;
                                options[current_index!] = true;
                              });
                            },
                            child: SideBarOption(
                                selected: options[2],
                                icon: Iconsax.people,
                                title: 'Accounts'),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                options[current_index!] = false;
                                current_index = 3;
                                options[current_index!] = true;
                              });
                            },
                            child: SideBarOption(
                                selected: options[3],
                                icon: Iconsax.chart_1,
                                title: 'Statistics'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Positioned(
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(70)),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  width: getWidth(context) * 0.08,
                                  child: Text(
                                    FirebaseAuth
                                        .instance.currentUser!.displayName!,
                                    style: TextStyle(
                                      fontFamily: 'Bold',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      logOut(context);
                                    },
                                    child: Icon(Iconsax.logout_1))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Container(
              width: 2,
              height: getHeight(context),
              color: Colors.grey.shade100,
            ),
          ),
          Container(
            width: getWidth(context) * 0.79,
            child: Expanded(
                child: Padding(
                    padding: EdgeInsets.all(48.0),
                    child: screens[current_index!])),
          ),
        ],
      ),
    );
  }
}

class SideBarOption extends StatefulWidget {
  bool? selected;
  String? title;
  IconData? icon;
  SideBarOption({this.selected, this.title, this.icon});

  @override
  State<SideBarOption> createState() => _SideBarOptionState();
}

class _SideBarOptionState extends State<SideBarOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: widget.selected!
                ? Colors.grey.shade100.withOpacity(0.8)
                : Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color:
                    !widget.selected! ? Colors.black.withOpacity(0.4) : primary,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                widget.title!,
                style: TextStyle(
                    fontFamily: widget.selected! ? 'Bold' : 'Medium',
                    fontSize: 14,
                    color: widget.selected!
                        ? Colors.black
                        : Colors.black.withOpacity(0.4)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
