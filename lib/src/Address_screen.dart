import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordless/src/load_animation_screen.dart';
import 'package:passwordless/src/property_list_db.dart';
import '../completesetup.dart';
import './login_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

import 'app.dart';
import 'auth_screen.dart';

/*API KEYS
key1: AIzaSyDGBcJl3WG1pR5aFI6RBCHJU1U-F7rIYTs
key2: AIzaSyBVJQTw5T6EmaDJMEXovigbFsvxPrbZWLA
key3: AIzaSyA0YNOEX-iYZQTRL6G3VBBCikiHZFzkHiE
 

 */

class FirstScreen extends StatefulWidget {
  String address;
  String email;
  FirstScreen({this.address, this.email});
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String email;
  void initState() {
    super.initState();
    getFirebaseUser();
    email = "${widget.email}";
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> getFirebaseUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    print("userrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr999" + user.toString());
    return user != null ? user : null;
  }

  void _signOut() async {
    FirebaseAuth.instance.signOut();
    var user1;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user);
    SystemNavigator.pop();
  }

  Future<List> searchProperty(pattern) async {
    List<String> list = List();
    int i;
    final response = await http.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' +
            pattern +
            '&key= AIzaSyBVJQTw5T6EmaDJMEXovigbFsvxPrbZWLA&offset=8',
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print('response.body:' + (response.body));
      // var rest = result["predictions"] as List;
      if (result['status'] == "OK") {
        print("lengthhhhhhhhhhhhhh" + result.length.toString());
        for (i = 0; i < result.length; i++)
        //for(i=0;i<5;i++)
        {
          print("haiiiiiiiiiiiiiiiiiiiiii" +
              result['predictions'][i]['description']);
          list.add(result['predictions'][i]['description']);
          //list.insert(i, result['predictions'][i]['description']);
          print(list);
        }
        //print("list"+list.toString());
        return list;
        //return null;
      } else {
        print("status is not ok");
      }
      //await Future.delayed(Duration(seconds: 2));

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Property');
    }
  }

  @override
  final TextEditingController pattern = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151232),
      body: Container(
        //  color:  Color(0xff151232),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              new LinearPercentIndicator(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                maskFilter: MaskFilter.blur(BlurStyle.solid, 1.0),
                // MainAxisAlignment alignment = MainAxisAlignment.start,
                animateFromLastPercent: true,
                width: MediaQuery.of(context).size.width - 0,
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
              Text(
                "Add your listing",
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
                    "Address",
                    style: TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-.100, 0),
                child: Container(
                    //alignment: Alignment.center,
                    // height: 60.0,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(12.0)),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        //controller: this.propertyController,
                        controller: this.pattern,
                        decoration: InputDecoration(
                            //border: OutlineInputBorder()
                            ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await searchProperty(pattern);
                        //return await suggestion = result;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        //pattern.text = suggestion;
                        print("suggestion" + suggestion);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnimationScreen(
                                address: suggestion, email: email)));
                      },
                    )),
              ),
              Row(children: <Widget>[
                Flexible(
                  //child: Card(
                  child: new Row(
                    children: <Widget>[
                      /* Align(
                 //   alignment: Alignment(0, -.500),
                    child: new SizedBox(
                      //width: 100.0,
                      height: 60.0,
                      child: new RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                        ),
                        child: const Text(
                        //  'Add Property',
                         'Signout',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        color: Color(0xff6839ed),
                        onPressed: () {
                          _signOut();
                           
                          // });
                        },
                      ),
                    ),
                  ),*/

                      Align(
                        //   alignment: Alignment(0, -.500),
                        child: new SizedBox(
                          //width: 100.0,
                          height: 60.0,
                          child: new RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Add Property',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            color: Color(0xff6839ed),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Completesetup(
                                        email: "${widget.email}");
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      new SizedBox(
                        width: 32.0,
                      ),
                      Align(
                        // alignment: Alignment(0, -.500),
                        child: new SizedBox(
                          width: 150.0,
                          height: 60.0,
                          child: new RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'View',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            color: Color(0xff6839ed),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Property_List_db_Screen(
                                        email: email);
                                  },
                                ),
                              );
                              // });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  //),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
