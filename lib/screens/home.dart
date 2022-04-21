import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/cards/ticket.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Tickets').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, i) {
                Map<String, dynamic> map =
                    snapshot.data!.docs[i].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Ticket(
                    name: map['name'],
                    profile: map['profile'],
                    status: map['status'],
                    email: map['email'],
                    message: map['message'],
                    priority: map['priority'],
                    subject: map['subject'],
                    attachment: map['attachment'],
                    //time: map['time'],
                  ),
                );
              });
        });
  }
}
