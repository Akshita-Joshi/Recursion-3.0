import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recursionhelpdesksystem/cards/ticket.dart';
import 'package:recursionhelpdesksystem/globals.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

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
                final DateTime dateTimeFromServerTimeStamp =
                    (map['timestamp'] as Timestamp).toDate();
                print('datetime--${dateTimeFromServerTimeStamp}');
                final day1 =
                    dateTimeFromServerTimeStamp; /* DateTime(
                    int.parse(
                        dateTimeFromServerTimeStamp.toString().substring(0, 4)),
                    int.parse(
                        dateTimeFromServerTimeStamp.toString().substring(5, 7)),
                    int.parse(dateTimeFromServerTimeStamp
                        .toString()
                        .substring(8, 10)));*/
                print('datetime--${day1}');
                final day2 = DateTime.now();
                final difference = daysBetween(day1, day2);
                print('datetime--${difference}');
                if (heirarchy == map['hierarchy'] &&
                    map['status'] == 'unsolved') {
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
