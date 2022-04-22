import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/cards/ticket.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Tickets')
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, i) {
                        Map<String, dynamic> map = snapshot.data!.docs[i].data()
                            as Map<String, dynamic>;
                        if (map['email'] ==
                            FirebaseAuth.instance.currentUser!.email!) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Ticket(
                              name: map['name'],
                              profile: map['profile'],
                              status: map['status'],
                              email: map['email'],
                              dept: map['dept'],
                              priority: map['priority'],
                              subject: map['subject'],
                              attachment: map['attachment'],
                              message: map['message'],
                              //time: map['time'],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                }),
          ),
        ],
      ),
    );
  }
}
