import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'Address_screen.dart';
import 'package:passwordless/Model/umodel.dart';
import 'dart:async' show Future;
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  final String email,existingemail;
  LoginPage({this.email,this.existingemail});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  User user;
  Host host;
  List<Host> temphost;
  List<User> users = List();
  List<Host> hosts;
  DatabaseReference userRef;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email1;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController propertiesname = new TextEditingController();
  TextEditingController role = new TextEditingController();

  var hostProperty, hostrole;
  List host1;

  void initState() {
    super.initState();
    //getUsers();
   //   createUser(); 
    getdata();
    hosts = List();
    email1 = "${widget.existingemail}";
 print(email1);
    WidgetsBinding.instance.addObserver(this);
  }
  getData() async {
    return Firestore.instance.collection('users').snapshots();
  }

     
 void addUser() async {
      final FirebaseAuth auth = FirebaseAuth.instance;

        final FirebaseUser user1 = await auth.currentUser();
        
    final email1 = user1.email;
     final uid = user1.uid;
     print("uidddddddddddddd"+uid);
    var emailid = "${widget.existingemail}";
    print("email"+emailid);
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: emailid)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) =>   
            print("data available"),
      );
      if (string.documents.length == 0) {
          try {
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          Firestore.instance.collection('users').document(uid).setData({
            'name': name.text,
            'email': email1.toLowerCase(),   
            'phone': phone.text,
            //'host': [{'propertiesname': propertiesname.text, 'role': role.text}],
            'host': [],
          },            
           );

        },
      );
    } catch (e) {
      print(e.toString());
    }
        } 
        else {
          print("data alreadyexists");
        }
    });
  }
    

  /*addUser() {
   // host = Host(propertiesname: propertiesname.text, role: role.text);
    // host1.add(host);
   //  User user1 = User(name: name.text, phone: phone.text, email: email.text);
    print("propertiesname" + propertiesname.text);
    print("propertiesname" + role.text);
    print("emaillllllllllll" +email1);
    // host=Host(propertiesname: propertiesname.text,role: role.text);
    try {
      Firestore.instance.runTransaction(
        (Transaction transaction) async {
          Firestore.instance.collection('users').document().setData({
            'name': name.text,
            'email': email1,   
            'phone': phone.text,
            'host': [{'propertiesname': propertiesname.text, 'role': role.text}],

          }, merge: true
          
          
            
           );
         
          //setData({'name': user.name,'email':"${widget.email}" ,'phone':user.phone,'host': {'propertiesname':  host.propertiesname, 'role': host.role }});
          //  // setData({ 'name': 'lax', 'email': 'lax@gmail.com','phone':'8838972257','host': { 'propertiesname': "common", 'role': "staff" }});

          //
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }*/


  Future getdata() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("users").getDocuments();
    print(qn.documents.toList());
    return qn.documents;
  }


  void dispose() {
    super.dispose();
  }

  /*Map<String, dynamic> handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      // print("Hosts"+hosts[0].toString());
      form.save();
      hosts.add(host);
      print("host data");
      form.reset();
      //  userRef.push().set(user.toJson());

    }
    //return null;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151232),
      body: Container(
        //  color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              // ),
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
                  Text(
                    "Create your profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0),
                  ),
                  Text(
                    "We'll use this information to do x,y and also z",
                    style: TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                  ),

                  Align(
                    alignment: Alignment(-.85, 0),
                    //     widthFactor: left
                    child: Container(
                      // color: Color(0xffD6C9F5),
                      child: Text(
                        "Full Name",
                        style:
                            TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                      ),
                    ),
                  ),
                  //  Text("Full Name", textAlign: TextAlign.start, style: TextStyle(color: Color(0xffD6C9F5),fontSize: 15.0),),
                  /*  Visibility(
                    child: Align(
                      alignment: Alignment(-.100, 0),
                      child: Container(
                        alignment: Alignment.center,
                        // height: 60.0,
                        width: MediaQuery.of(context).size.width - 100,
                        //width: 300.0,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                            // initialValue: "",
                            //  user.name,
                            //controller: email.text,
                            // initialValue: "${widget.email}",
                            controller: email,
                            // onSaved: (val) => user.name = val,
                            onSaved: (val) => user.email = val,
                            // validator: (val) => val == "" ? val : null,
                            decoration: InputDecoration(
                              hintText: "email",
                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    ),
                    //visible: false,
                    visible: true,
                  ),*/
                  Align(
                    alignment: Alignment(-.100, 0),
                    child: Container(
                      alignment: Alignment.center,
                      // height: 60.0,
                      width: MediaQuery.of(context).size.width - 100,
                      //width: 300.0,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(12.0)),
                      child: new TextFormField(
                          controller: name,
                          // onSaved: (val) => user.name = val,
                          //validator: (val) => val == "" ? val : null,
                          decoration: InputDecoration(
                            hintText: "Joe Bloggs",
                            contentPadding: EdgeInsets.all(20),
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.85, 0),
                    //     widthFactor: left
                    child: Container(
                      // color: Color(0xffD6C9F5),
                      child: Text(
                        "Phone No",
                        style:
                            TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-.100, 0),
                    child: Container(
                      alignment: Alignment.center,
                      // width: 60.0,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(12.0)),
                      child: new TextFormField(
                          // initialValue: "",
                          controller: phone,
                          //keyboardType: TextInputType.emailAddress,
                          keyboardType: TextInputType.phone,
                          maxLength: 12,
                          autofocus: false,
                          // initialValue: "",
                          //onSaved: (val) => user.phone = val,
                          //validator: (val) => val == "" ? val : null,
                          decoration: InputDecoration(
                            hintText: "e.g. +44 7911 123456",
                            fillColor: Color(0xffC8C3D4),
                            contentPadding: EdgeInsets.all(20),
                          )),
                    ),
                  ),
                 /* Visibility(
                    child: Align(
                      alignment: Alignment(-.100, 0),
                      child: Container(
                        alignment: Alignment.center,
                        // width: 60.0,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                            autofocus: false,
                            controller: propertiesname,
                            //initialValue: "",
                            //    onSaved: (val) => host.propertiesname = val ,
                            //validator: (val) => val == "" ? val : null,
                            decoration: InputDecoration(
                              hintText: "propertiesname",
                              fillColor: Color(0xffC8C3D4),
                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    child: Align(
                      alignment: Alignment(-.100, 0),
                      child: Container(
                        alignment: Alignment.center,
                        // width: 60.0,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(12.0)),
                        child: new TextFormField(
                            autofocus: false,
                            //  initialValue: "",
                            controller: role,
                            //  onSaved: (val) => "${user.host[0].role = val}",
                            // onSaved: (val) => host.role = val,
                            //   validator: (val) => val == "" ? val : null,
                            decoration: InputDecoration(
                              hintText: "role",
                              fillColor: Color(0xffC8C3D4),
                              contentPadding: EdgeInsets.all(20),
                            )),
                      ),
                    ),
                  ),*/
                  Align(
                    alignment: Alignment(-.85, 0),
                    //     widthFactor: left
                    child: Container(
                      child: Text(
                        "By creating an account, you agree to our Terms of Services and privacy Policy ",
                        style:
                            TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                      ),
                    ),
                  ),

                  new SizedBox(
                    width: 300.0,
                    height: 60.0,
                    child: new RaisedButton(
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Color(0xff6839ed),
                      onPressed: () {
                         addUser();             
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FirstScreen(
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
      ),
    );
  }
}
/*
class User {
  String email;
  //LoginPage({this.email});
  String key;
  String name;
  String phone;

  User(this.name, this.phone, this.email);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        //email = snapshot.value["${widget.email}"],
        //print("${data.email}");
        //email = "${data.email}",
        phone = snapshot.value["phone"];

  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}*/
/*
class User {
  String key;
  String name;
  String phone;
  String email;

  //final RegisterPage email;
  // In the constructor, require a Todo.
  //User(String s, {this.name, this.phone, this.email});
  //final RegisterPage email;
  //LoginPage({this.email});
  User(this.name, this.phone, this.email);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        email = snapshot.value["email"],
        //email = ${email},
        phone = snapshot.value["phone"];

  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
} */
