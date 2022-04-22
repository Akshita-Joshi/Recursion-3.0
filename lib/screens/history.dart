import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/cards/ticket.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
                if (map['status'] == 'solved') {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Ticket(
                      docid: snapshot.data!.docs[i].id,
                      name: map['name'],
                      hierarchy: map['hierarchy'],
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
                } else {
                  return Container();
                }
              });
        });
  }
}
