import 'package:flutter/material.dart';
import 'package:passwordless/guest_contact.dart'; 
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async' show Future, StreamSubscription;
import 'package:cloud_firestore/cloud_firestore.dart';

class Guest_checkin extends StatefulWidget {
  String email,existingemail;
  Guest_checkin({this.email,this.existingemail});
  @override
  _Guest_checkinState createState() => _Guest_checkinState();
}

class _Guest_checkinState extends State<Guest_checkin>  {
  

  void initState() {
    super.initState();
    //getUsers();
   //   createUser(); 
    getdata();
   
  }
 



  Future getdata() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("users").getDocuments();
    print(qn.documents.toList());
    return qn.documents;
  }


  void dispose() {
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151232),
      body: Container(
        //  color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
           
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new LinearPercentIndicator(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    maskFilter: MaskFilter.blur(BlurStyle.solid, 1.0),
                    animateFromLastPercent: true,
                    lineHeight: 25.0,
                    percent: 0.5,
                    progressColor: Color(
                      0xffF43669,
                    ),
                    backgroundColor: Color(0xff151232),
                    // progressColor: Colors.greenAccent,
                  ),

                  // const Text("You are not currently signed in."),
                  new SizedBox(
                    height: 1.0,
                  ),
                  /*CircleAvatar(
                    backgroundImage: ,
                  )*/

                  Text(
                    "Time to checkIn",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                          Text(
                    "Hey! Looking forward to hosting you soon",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                      Text(
                    "Please fill in this form before you arrive so that you ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                      Text(
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cilium dolore eu fugiat nulla pariatur.",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                      ],
                    ),
                  ),
      new SizedBox(
                    width: 300.0,
                    height: 60.0,
                    child: new RaisedButton(
                      child: const Text(
                        'Check-In',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xff6839ed),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Guest_contact(
                                email: "${widget.existingemail}",
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            
          ),
        ),
      ),
    );
  }
}
