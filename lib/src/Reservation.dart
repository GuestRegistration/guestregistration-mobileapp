import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passwordless/src/reservation_list_db.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'profileimage.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';

class Reservation extends StatefulWidget {
  String propertyname,email,property_id;
   Reservation({this.propertyname,this.email,this.property_id});
  @override
  _ReservationState createState() => new _ReservationState();
}

var selectedDate = DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
var formatted = formatter.format(selectedDate);
var formatter2 = new DateFormat('yyyy-MM-dd');
var formatted2 = formatter2.format(selectedDate);

class _ReservationState extends State<Reservation> {
  final TextEditingController _textControllerin = new TextEditingController();
  final TextEditingController _textControllerout = new TextEditingController();
  TextEditingController guest_name = new TextEditingController();
  TextEditingController primary_guest = new TextEditingController();
  TextEditingController addtional_guest = new TextEditingController();
  TextEditingController booking_channel = new TextEditingController();
  TextEditingController number_of_guest = new TextEditingController();


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
 void update_user_reservation() async {
       print("inside update_user_reservation");
    var email = "${widget.email}";
 print(email);

  var property_id = int.parse("${widget.property_id}");
   print("propertyid"+property_id.toString());
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
                  'Primary_guest': primary_guest.text,
                  'property_id': property_id,
              //      'CheckIn_date': _textControllerin.text,
               //'Checkout_date':_textControllerout.text,
                  //'Additional_guest':addtional_guest.text,
                }
              ]),
            }),
      );
    });
  }
   void addReservation() {
      print("inside addReservation");
        var property_id = int.parse("${widget.property_id}");
   print("propertyid"+property_id.toString());
        try {
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          Firestore.instance.collection('Reservation').document().setData({
            'Name': guest_name.text,
             'Primary_guest': primary_guest.text,   
            //'Additional_guest': addtional_guest.text,
            'Booking_channel':booking_channel.text,
            'CheckIn_date': _textControllerin.text,
            'Checkout_date':_textControllerout.text,
            'No_of_guest' :number_of_guest.text,
            'iD_verification':"ID_verification",
            'payment' : "payment",
             'property_id': property_id,
          }, //merge: true
           
            
           );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Color(0xff151232),
   
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
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
                        fontSize: 20,
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
                       controller: guest_name,
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
                        controller: primary_guest,
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
                          controller: number_of_guest,
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
                          controller: booking_channel,
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
                            fontSize: 15,
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
                            fontSize: 15,
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
                              decoration: InputDecoration(
                                //fillColor: Colors.white.withOpacity(0.6),
                                   fillColor: Colors.white,
                                filled: true,
                                hintText: '11/16/19',
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
                            decoration: InputDecoration(
                            //  fillColor: Colors.white.withOpacity(0.6),
                               fillColor: Colors.white,
                              filled: true,
                              hintText: '11/16/19',
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
                     addReservation();
                    update_user_reservation(); 
                       Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new Reservation_List_db_Screen(
                              email:"${widget.email}",
                              property_name :  "${widget.propertyname}",
                              property_id:"${widget.property_id}",
                          )),
                    );
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
    );
  }
}
