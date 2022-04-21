import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recursionhelpdesksystem/globals.dart';

class Ticket extends StatefulWidget {
  String? name;
  String? email;
  String? subject;
  String? message;
  String? attachment;
  String? profile;
  String? status;
  String? dept;
  String? priority;

  Ticket(
      {this.name,
      this.email,
      this.subject,
      this.message,
      this.attachment,
      this.profile,
      this.status,
      this.dept,
      this.priority});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: Colors.grey.shade100.withOpacity(0.6)),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Container(
                width: getWidth(context),
                child: Row(
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
                          child: widget.profile != null
                              ? Image.network(
                                  widget.profile!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
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
                            widget.name!,
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
                            widget.email!,
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
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: getWidth(context),
                child: Text(
                  widget.subject!,
                  style: TextStyle(fontFamily: 'Bold', fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: getWidth(context),
                child: Text(
                  widget.message!,
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.status!,
                        style: TextStyle(
                            fontFamily: 'Bold',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  widget.priority == 'High'
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              widget.priority!,
                              style: TextStyle(
                                  fontFamily: 'Bold',
                                  fontSize: 18,
                                  color: Colors.yellow),
                            ),
                          ),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ));
  }
}
