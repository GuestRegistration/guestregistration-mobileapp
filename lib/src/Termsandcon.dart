import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:passwordless/src/property_list_db.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import './Reservation.dart';

class Termsandcon extends StatefulWidget {
   String email,primaryguest,propertiesname,city,dropdownValue,Propertyid,property_email,phone,staff,owner,address_line1,state;
 File img1;
   Termsandcon({this.img1,this.address_line1,this.state,this.email,this.primaryguest,this.propertiesname,this.city,this.dropdownValue,this.Propertyid,this.property_email,this.phone,this.owner,this.staff});

  @override
  _TermsandconState createState() => new _TermsandconState();
}

class _TermsandconState extends State<Termsandcon> {
  String _error = "";
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool _visible = false;
    final formKey = GlobalKey<FormState>();
  //bool _validate = false;
void initState() {
    print("${widget.email}".toString());
     print("${widget.propertiesname}".toString());
       print("${widget.property_email}".toString());
            print("${widget.img1}".toString());
              print("${widget.phone}".toString());
    print("${widget.staff}".toString());
      print("${widget.dropdownValue}".toString());
        print("${widget.owner}".toString());
    print("${widget.address_line1}".toString());
      print("${widget.city}".toString());
    print("${widget.state}".toString());




      
    super.initState();
  }

  bool ownercheck(List host, String value) {
    bool owner_flag = false;
    print(host);
    for (int i = 0; i < host.length; i++) {
      owner_flag = host[i]['role'].contains(value);
      print("owner_flag" + owner_flag.toString());
      if (owner_flag == true) {
        print("owner present");
        return owner_flag;
      }
    }
    return false;
  }

  addProperty() async {
    Random random = new Random();
    var randomNumber = random.nextInt(1000000) + 10;
    print("randomnumber" + randomNumber.toString());
    var email = "${widget.email}";
    var url;
    int i;
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((string) async {
      print('Firestore response111: , ${string.documents.length}');
      StorageReference storageReference;
      StorageUploadTask uploadTask;
      StorageTaskSnapshot downloadUrl;
      bool ownerpresent = false;
      dynamic host;
      int length;
      String value = "Owner";
      var parsed, host_data;

      string.documents.forEach((doc) async => {
            length = doc.data['host'].length,
            print("lengthhhhhhhhhhhhhhhh" + length.toString()),
            /*  if (length == 0) {
              update_user(randomNumber),
            } else {
              print("user have host value"),
            },*/
            host = doc.data['host'],
            ownerpresent = ownercheck(host, value),
            print("ownerpresent" + ownerpresent.toString()),
            print("dropdownValue"+"${widget.dropdownValue}"),
            if("${widget.dropdownValue}" == "Staff"){
                print("inside if"),
                   storageReference =
                    FirebaseStorage.instance.ref().child("${widget.propertiesname}"),
                uploadTask = storageReference.putFile(widget.img1),
                downloadUrl = (await uploadTask.onComplete),
                url = (await downloadUrl.ref.getDownloadURL()),
                print('URL Is $url'),
                print('File Uploaded'),
                Firestore.instance.runTransaction(
                  (Transaction transaction) async {
                    Firestore.instance
                        .collection('Properties')
                        .document()
                        .setData({
                      'Propertyid': randomNumber,
                      'Property_Name': "${widget.propertiesname}",
                      'Property_logo': url,
                      'email': "${widget.property_email}",
                      'phone': "${widget.phone}",
                       'terms': terms_con.text,
                      'Team': {
                        'staff': "${widget.staff}",
                        "owner": "${widget.email}"
                      },
            
                      'Reservation': {'listofreservation': "${widget.email}"},
                      'Reservation': {'guestform': "${widget.email}"},
                      'Address': {
                        'addressline1':"${widget.address_line1}",
                        'city': "${widget.city}",
                        'state': "${widget.state}"
                      }
                    });
                  },
                ).whenComplete(() => update_user(randomNumber))
              }
          
              else if (ownerpresent == true)
              {
                print("Firestore response222: ${doc.data.toString()}"),
                print("owner already set"),
                setState(() {
                  _error = "You have exceed the limit of adding property";
                  _visible = ownerpresent;
                }),
                print(_visible)
              }
            else
              {
                print("owner_flag false"),
                storageReference =
                    FirebaseStorage.instance.ref().child("${widget.propertiesname}"),
                uploadTask = storageReference.putFile(widget.img1),
                downloadUrl = (await uploadTask.onComplete),
                url = (await downloadUrl.ref.getDownloadURL()),
                print('URL Is $url'),
                print('File Uploaded'),
                Firestore.instance.runTransaction(
                  (Transaction transaction) async {
                    Firestore.instance
                        .collection('Properties')
                        .document()
                        .setData({
                      'Propertyid': randomNumber,
                      'Property_Name': "${widget.propertiesname}",
                      'Property_logo': url,
                      'email': "${widget.property_email}",
                      'phone': "${widget.phone}",
                      'terms': terms_con.text,
                      'Team' : {
                        'staff': "${widget.staff}",
                        "owner": "${widget.email}"
                      },
                     
                      'Reservation': {'listofreservation': "${widget.email}"},
                      'Reservation': {'guestform': "${widget.email}"},
                      'Address': {
                        'addressline1': "${widget.address_line1}",
                        'city': "${widget.city}",
                        'state': "${widget.state}",
                      }
                    });
                  },
                ).whenComplete(() => update_user(randomNumber))
              },
              
          });
    });
  }
  void update_user(randomNumber) async {
    var email = "${widget.email}";
    var firestoreid;
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
                //'host': [{'propertiesname': propertiesname.text, 'role': role.text}],
                {
              'host': FieldValue.arrayUnion([
                {
                  'propertiesname': "${widget.propertiesname}",
                  'city': "${widget.city}",
                  'role': "${widget.dropdownValue}",
                  'Propertyid': randomNumber,
                }
              ]),
            }),
            
      );
              scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Property Added Sucessfully"),                             
                                
                              ));
    }).whenComplete(() => navigate());
  }
void navigate(){
  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> Property_List_db_Screen(
                          email: "${widget.email}",
                        )
                      ));
}
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
    key: scaffoldkey,
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
              SizedBox(
                  height: 10,
                ),
                Text(
                  //'Terms & Conditions',
                    'Propperty Rules',
                  style: TextStyle(
                      fontSize: 29,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                  Text(
                  //'Terms & Conditions',
                    'Tell people what to expect',
                
                  style: TextStyle(
                      fontSize: 12,
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
                  hintText: 'Paste your property rules here'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                ),
                    SizedBox(
                  height: 40,),
                  Visibility(
                        child: Text(
                          _error,
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                        visible: _visible,
                      ),
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
               /*addProperty();
                    setState(() {
                                  _visible = false;
                                });
                                  scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Start Adding Property"),                             
                                
                              ));*/
                        if (_visible== false) {
                                  setState(() {
                                  _visible = false;
                                });
                                // No any error in validation
                                print(_visible);
                                //print(ownerpresent);
                               // formKey.currentState.save();
                                addProperty();
                                  scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Start Adding Property"),                             
                                
                              ));
                            
                                           
                              } else {
                                // validation error
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Failed to Add Property"),
                              ));
                           
                              }
                          
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
