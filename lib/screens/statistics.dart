import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

var sizss;

class _StatisticsState extends State<Statistics> {
  totalnumberusers() {
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      setState(() {
        sizss = value.docs.length;
        print(sizss);
      });
    });
  }

  var sizeee;
  totaltick() {
    FirebaseFirestore.instance.collection("Tickets").get().then((value) {
      setState(() {
        sizeee = value.docs.length;
      });
    });
  }

  var unsolved;
  totalunsolved() {
    FirebaseFirestore.instance
        .collection("Tickets")
        .where("status", isEqualTo: "unsolved")
        .get()
        .then((valuess) {
      setState(() {
        unsolved = valuess.docs.length + 1;
      });
    });
  }

  var solved;
  totalsolved() {
    FirebaseFirestore.instance
        .collection("Tickets")
        .where("status", isEqualTo: "resolved")
        .get()
        .then((values) {
      setState(() {
        solved = values.docs.length + 1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalunsolved();
    totaltick();
    totalnumberusers();
    totalsolved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 350),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        height: 150.0,
                        width: 300.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: new Center(
                              child: new Text(
                                "Total number of users are: $sizss",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Center(
                      child: Container(
                        height: 150.0,
                        width: 300.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: new Center(
                              child: new Text(
                                "Total number of Tickets: $sizeee",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                ),
                Row(
                  children: [
                    Center(
                      child: Container(
                        height: 150.0,
                        width: 300.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: new Center(
                              child: new Text(
                                "Total number of unsolved Tickets: $unsolved",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Center(
                      child: Container(
                        height: 150.0,
                        width: 300.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: new Center(
                              child: new Text(
                                "Total number of solved Tickets: $solved",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
