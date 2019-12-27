import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import './Reservation.dart';

class Termsandcon extends StatefulWidget {
   String email,primaryguest;
 
   Termsandcon({this.email,this.primaryguest});

  @override
  _TermsandconState createState() => new _TermsandconState();
}

class _TermsandconState extends State<Termsandcon> {

  void update_property_terms() async {
       print("inside update_user_reservation");
    var email = "${widget.email}";
 print(email);
      Firestore.instance
        .collection("Properties")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) => Firestore.instance
            .collection("Properties")
            .document("${doc.documentID.toString()}")
            .updateData(
                {
              'Terms&con':terms_con.text
            }),
      );
    });
  }
       TextEditingController terms_con = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
  //    backgroundColor: Colors.deepPurple,
       body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  new LinearPercentIndicator(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                maskFilter: MaskFilter.blur(BlurStyle.solid, 1.0),
                animateFromLastPercent: true,
                
                lineHeight: 25.0,
                //animationDuration: 30000,
                //addAutomaticKeepAlive: true,
                clipLinearGradient: false,
                percent: 0.7,
                //linearStrokeCap: LinearStrokeCap.values[2],
                progressColor: Color(
                  0xffF43669,
                ),
                backgroundColor: Color(0xff151232),
                // progressColor: Colors.greenAccent,
              ),
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 30,
                ),
                Text(
                  'Upload the Terms & conditions that you guests will have to sign in.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0XffD6C9F8),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                new TextField(
                  controller: terms_con,
                  decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Paste your terms and conditions here...'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                ),
                    SizedBox(
                  height: 40,),
                
                Align(
                  alignment: Alignment(.88, 0),
                  child:      SizedBox(
                  height: 70,
                
               child:  new RaisedButton(
                  child: Text(
                    'Complete Setup',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    //update_property_terms();
                   Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new Reservation()
                        ),
                   );
                  }
                 ),),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
