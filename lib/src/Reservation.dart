import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passwordless/src/reservation_list_db.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


//import 'package:flutter_localizations/flutter_localizations.dart';

class Reservation extends StatefulWidget {
 final String propertyname,email,propertyid;
   Reservation({this.propertyname,this.email,this.propertyid});
  @override
  _ReservationState createState() => new _ReservationState();
}

var selectedDate = DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
var formatted = formatter.format(selectedDate);
var formatter2 = new DateFormat('yyyy-MM-dd');
var formatted2 = formatter2.format(selectedDate);

class _ReservationState extends State<Reservation> {
  String email;
    //String _error = "";
  //GlobalKey<FormState> _key = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  bool _validate = false;
  final TextEditingController _textControllerin = new TextEditingController();
  final TextEditingController _textControllerout = new TextEditingController();
  TextEditingController guestname = new TextEditingController();
  TextEditingController primaryguest = new TextEditingController();
  TextEditingController addtionalguest = new TextEditingController();
  TextEditingController bookingchannel = new TextEditingController();
  TextEditingController numberofguest = new TextEditingController();

final scaffoldkey = GlobalKey<ScaffoldState>();
  bool _visible = false;

  Future _selectDatecheckin(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));

    var formatted1 = formatter.format(picked);
    // var formatted3 = formatter2.format(picked);

    if (formatted1 != null && formatted1 != formatted)
      setState(() {
        print('formatted1' + formatted1);
        formatted = formatted1;
        _textControllerin.text = formatted;
        // report();

        // selectedDate=formatted1 as DateTime;
      });
  }

  Future _selectDatecheckout(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));

    var formatted3 = formatter2.format(picked);

    if (formatted3 != null && formatted3 != formatted2)
      setState(() {
        print('formatted3' + formatted3);
        formatted2 = formatted3;
        _textControllerout.text = formatted2;
        // report();

        // selectedDate=formatted1 as DateTime;
      });
  }
 void updateuserreservation(resevationid) async {
       print("inside update_user_reservation"+resevationid.toString());
    var email = "${widget.email}";
     
 print(email);

  var propertyid = int.parse("${widget.propertyid}");
   print("propertyid"+propertyid.toString());
      Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) => Firestore.instance
            .collection("users")
            .document("${doc.documentID.toString()}")
            .updateData(
                {
              'Reservation': FieldValue.arrayUnion([
                {
                  'Primary_guest': primaryguest.text,
                  'property_id': propertyid,
                  'resevation_id':resevationid,
                }
              ]),
            }),
      );
    });
  }
   void addReservation() {
       Random random = new Random();
    var resevationid = random.nextInt(100000000) + 10;
    print("resevation_id" + resevationid.toString());
      print("inside addReservation");
        var propertyid1 = int.parse("${widget.propertyid}");
   print("propertyid"+propertyid1.toString());
        try {
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          Firestore.instance.collection('Reservation').document().setData({
            'Name': guestname.text,
             'Primary_guest': primaryguest.text,   
            //'Additional_guest': addtional_guest.text,
            'Booking_channel':bookingchannel.text,
            'CheckIn_date': _textControllerin.text,
            'Checkout_date':_textControllerout.text,
            'No_of_guest' :numberofguest.text,
            'iD_verification':"ID_verification",
            'payment' : "payment",
             'property_id': propertyid1,
             'resevation_id':resevationid,
          }, //merge: true
           
           );
        },
      ).whenComplete(() => updateuserreservation(resevationid));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Color(0xff151232),
   key: scaffoldkey,
      body: Center(
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.only(left: 10, right: 10),
            child:  new Form(
                  autovalidate: _validate,
                  key: formKey,
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    new LinearPercentIndicator(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 1.0),
                  // MainAxisAlignment alignment = MainAxisAlignment.start,
                  //animateFromLastPercent: true,
                  //width: MediaQuery.of(context).size.width - 0,
                  //animation: true,
                  lineHeight: 25.0,
                  //animationDuration: 30000,
                  //addAutomaticKeepAlive: true,
                  //clipLinearGradient: false,
                  percent: 0.7,
                  //linearStrokeCap: LinearStrokeCap.values[2],
                  progressColor: Color(
                    0xffF43669,
                  ),
                  backgroundColor: Color(0xff151232),
                  // progressColor: Colors.greenAccent,
                ),
                SizedBox(
                    height: 32.0,
                  ),
                  Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      "${widget.propertyname}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0XffA2A0AE),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      'Reservation',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                   Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      'Name on booking',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0Xff5E577D),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(

                     alignment: Alignment(-.100, 0),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                         controller: guestname,
                          validator: (value) {
                              if (value.isEmpty) {
                                 return "Please enter Name of the Guest";
                              }
                              return null;
                            },
                                 decoration: InputDecoration(
                               hintText: 'e.g. Joe blogg',
                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
           
                  ),
                      
                     Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      'Primary guests',
                      style: TextStyle(
                        fontSize: 13,
                          color: Color(0Xff5E577D),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  
                  Align(
                   alignment: Alignment(-.100, 0),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                             validator: validateEmail,
                              onSaved: (String val) {
                                email = val;
                              },
                          controller: primaryguest,
                                 decoration: InputDecoration(
                               hintText: 'e.g. John@gmail.com',
                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    
                  ), 
                  /*  Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      'Additional guests',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0Xff5E577D),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                    Align(
                   alignment: Alignment(-.100, 0),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                            controller: addtional_guest,
                                 decoration: InputDecoration(
                            hintText: 'e.g. Alex@gmail.com',

                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    
                  ),*/
          
                  Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      'Number of guests',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0Xff5E577D),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                       Align(
                   alignment: Alignment(-.100, 0),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                            controller: numberofguest,
                             keyboardType: TextInputType.number,
                            autofocus: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                 return "Please enter No of Guest";
                              }
                              return null;
                            },
                                 decoration: InputDecoration(
                                                hintText: 'e.g. 2',

                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    
                  ),
                  
                  SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment(-.88, 0),
                    child: Text(
                      'Booking Channel',
                      style: TextStyle(
                          fontSize: 13,
                         color: Color(0Xff5E577D),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                        Align(
                   alignment: Alignment(-.100, 0),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                            controller: bookingchannel,
                             validator: (value) {
                              if (value.isEmpty) {
                                 return "Please enter the Booking channel";
                              }
                              return null;
                            },
                                 decoration: InputDecoration(
                                                 hintText: 'e.g. airbnb',
                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    
                  ),
                
                  SizedBox(
                    height: 15.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Align(
                        // alignment: Alignment(-.80, 0),
                        child: Text(
                          'Check-in date',
                          style: TextStyle(
                            fontSize: 13,
                             color: Color(0Xff5E577D),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                        // alignment: Alignment(.88, 0),
                        child: Text(
                          'Check-out date',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0Xff5E577D),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Align(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            new Container(
                              width: 130,
                              child: new TextFormField(
                                controller: _textControllerin,
                              
                               validator: (value) {
                              if (value.isEmpty) {
                                 return "Please Select the Check in date";
                              }
                              return null;
                            },
                                decoration: InputDecoration(
                                  //fillColor: Colors.white.withOpacity(0.6),
                                     fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'MM/DD/YY',
                                ),
                                onTap: () {
                                  _selectDatecheckin(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 130,
                            child: new TextFormField(
                                controller: _textControllerout,
                                validator: (value) {
                              if (value.isEmpty) {
                                 return "Please Select the Check Out date";
                              }
                              return null;
                            },
                              decoration: InputDecoration(
                              //  fillColor: Colors.white.withOpacity(0.6),
                                 fillColor: Colors.white,
                                filled: true,
                                hintText: 'MM/DD/YY',
                                //labelText: 'Number of guests',
                              ),
                              onTap: () {
                                _selectDatecheckout(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                   SizedBox(
                    height: 60.0,
                    width: 10.0,
                    child: new RaisedButton(
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                        if (formKey.currentState.validate()) {
                                  setState(() {
                                  _visible = false;
                                });
                                // No any error in validation
                                print(_visible);
                                //print(ownerpresent);
                                formKey.currentState.save();
                             
                               addReservation();
                         scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Start Adding Reservation"),                             
                                
                              ));
                         Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new ReservationLisdbScreen(
                                email:"${widget.email}",
                                propertyname :  "${widget.propertyname}",
                                propertyid:"${widget.propertyid}",
                            )),
                      );
                                           
                              } else {
                                // validation error
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Failed to Add Reservation"),
                              ));
                              setState(() {
                                  _validate = true;
                                });
                              }
                   
                    /*  Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Profileimage(
                                email:"${widget.email}",
                                primaryguest:primary_guest.text,
                            )),
                      );*/
                    },
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Please Enter a  Valid Email Address';
  else
    return null;
}