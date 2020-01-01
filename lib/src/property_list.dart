import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:guestregistration/property_update.dart';
import 'package:passwordless/Model/property_model.dart';

import 'completesetup.dart';


class PropertyListScreen extends StatefulWidget {
  //final Map<String, dynamic> product;
  final String address, email;
  final List list;
  PropertyListScreen({this.address, this.email, this.list});
  @override
  _PropertyListScreenState createState() => new _PropertyListScreenState();
}

FirebaseDatabase database = new FirebaseDatabase();
//DatabaseReference _propertyRef;
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

Property property;
List<Property> properties = List();
DatabaseReference propertyRef;

String propertyaddress;

var addresssplit = [];
String delimiter = ',';

String phone = "9787591660";
final TextEditingController addresscontroller =
    TextEditingController(text: propertyaddress);
String addressline1, city, state;

class _PropertyListScreenState extends State<PropertyListScreen> {
  getUsers() {
    return Firestore.instance.collection("users").snapshots();
  }

 
  /*getproperty() {
    var email = "${widget.email}";
    var firestoredata;
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach((doc) =>
                  {
            if ("${doc.data['host'].toString()}" == null)
              print("no product under this user")
            else
              print("Firestore response222: ${doc.data['host']['role'].toString()}")
          });

     });
  }*/

  List list;
  void initState() {
    propertyaddress = "${widget.address}";
    addresssplit = propertyaddress.split(delimiter);
    print(addresssplit);
    addressline1 = addresssplit[0];
    city = addresssplit[1];
    state = addresssplit[2];
    print(addressline1);
    print(city);
    print(state);
    //getproperty();

    super.initState();
    //  final FirebaseDatabase database = FirebaseDatabase.instance;
    //propertyRef = database.reference().child('Property');
    // propertyRef.onChildAdded.listen(_onEntryAdded);
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Text(
              "Current Listing",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      title: Text(addressline1),
                      subtitle: Text(state),
                      leading: Icon(Icons.location_on),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                )),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Completesetup(
                          city: city,
                          state: state,
                          email: "${widget.email}",
                          addressline1: addressline1,
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            //),
            //  ),
            //  ),
          ],
        ));
  }
}

class PropertyList extends StatefulWidget {
  final String email;
  final List list;
  PropertyList({this.email, this.list});

  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Text(
              "Your Listings",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      title: Text(addressline1),
                      subtitle: Text(state),
                      leading: Icon(Icons.location_on),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                )),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Completesetup(
                          city: city,
                          state: state,
                          email: "${widget.email}",
                          addressline1: addressline1,
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            //),
            //  ),
            //  ),
          ],
        ));
    /*   return new ListView.builder(
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (context, i) {
          return new Container(

            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Views(
                        list: widget.list,
                        index: i,
                      ))),
              child: new Card(
                child: new ListTile(
                  title: new  Text("${widget.list[i]['product_name']}",style: new TextStyle(fontSize: 18.0,color:Colors.blue,fontWeight: FontWeight.bold),),
              
              leading:
                                  CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[i]['img_name']}"),
                      backgroundColor: Colors.transparent,
                    ),
                  
              
                    //leading: new Image.network("http://fluttertest.000webhostapp.com/upload/${list[i]['img_name']}", width: 100.0, height: 100.0,),
                   subtitle: new Text("Stock : ${widget.list[i]['product_stock']}"),
                ),
              ),
            ),
          );
        },
      );*/
  }
}
/*
class Property {
//String<Address> _address;
  String address;

  //Property({this.address});
  String key;
  String _propertyname;
  String _propertylogo;
  String _email;
  String _phone;
//  String _address;
  String _team;
  String _reservation;
  String _guestform;

  Property(
      this.key,
      this._propertyname,
      this._propertylogo,
      this._email,
      this._phone,
      this.address,
      this._team,
      this._reservation,
      this._guestform);


  Property.fromSnapshot(DataSnapshot snapshot)
      : //{
        key = snapshot.key,
        _propertyname = snapshot.value['propertyname'],
        _propertylogo = snapshot.value['propertylogo'],
        _email = snapshot.value['email'],
        _phone = snapshot.value['phone'],
        address = snapshot.value['property_address'],
        _team = snapshot.value['team'],
        _reservation = snapshot.value['reservation'],
        _guestform = snapshot.value['guestform'];

  toJson() {
    return {
      "name": _propertyname,
      "propertylogo": _propertylogo,
      "email": _email,
      "phone": _phone,
      "address": property_address,
      "team": _team,
      "reservation": _reservation,
      "guestform": _guestform,
    };
  }
  //}
}
*/
/*class Address {
  String address_line1, city, state, id;
  Address({
    this.address_line1,
    this.city,
    this.state,
  });
  Address.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        address_line1 = snapshot.value["address_line1"],
        city = snapshot.value["city"],
        state = snapshot.value["state"];

  toJson() {
    return {
      "address_line1": address_line1,
      "city": city,
      "state": state,
    };
  }*/
/*factory Address.fromJson(Map<String, dynamic> json) {
    return new Address(
        address_line1: json['address_line1'],
        city: json['city'],
        state:json['state']);
        
  }*/
//}
