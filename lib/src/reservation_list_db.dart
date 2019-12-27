import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:passwordless/src/Reservation.dart';
//import 'package:advanced_share/advanced_share.dart';
import 'package:share/share.dart';

class Reservation_List_db_Screen extends StatefulWidget {
  String email, property_name, property_id;

  // List list;
  Reservation_List_db_Screen(
      {this.email, this.property_name, this.property_id});
  @override
  _Reservation_List_db_ScreenState createState() =>
      new _Reservation_List_db_ScreenState();
}

class _Reservation_List_db_ScreenState
    extends State<Reservation_List_db_Screen> {
  int i = 0;
  List host = List();
  Future<QuerySnapshot> _listFuture;
  Future<QuerySnapshot> future;

  Future<QuerySnapshot> getreservation() async {
    var property_id = int.parse("${widget.property_id}");
    Future<QuerySnapshot> reservation = Firestore.instance
        .collection("Reservation")
        .where("property_id", isEqualTo: property_id)
        .getDocuments();

    return reservation;
  }

  var subtitle;
  var email;
  void initState() {
    super.initState();
    future = getreservation();
    //getproperty();
    email = "${widget.email}";
    print("${widget.email}");
    // print("propertyiddddddddddd"+"${widget.property_id}");
    _listFuture = getreservation();
  }

  void refreshList() {
    // reload
    setState(() {
      _listFuture = getreservation();
    });
  }

  void dispose() {
    super.dispose();
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  void handleResponse(response, {String appName}) {
    if (response == 0) {
      print("failed.");
    } else if (response == 1) {
      print("success");
    } else if (response == 2) {
      print("application isn't installed");
      if (appName != null) {
        scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("${appName} isn't installed."),
          duration: new Duration(seconds: 4),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return RefreshIndicator(
          child: Scaffold(*/
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: new FutureBuilder(
          future: _listFuture,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return new Center(
                child: Text(
                  "Loading....",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              );
            }
            //print(snapshot.data.documents[0]['documentID'].toString());
            //  print(snapshot.data.documentChanges.length);
            /*for(i=0;i<snapshot.data.documentChanges.length;i++){
            print("i"+i.toString());
          }*/
            /* if(snapshot.data == null&&!snapshot.hasData) {
           return new Center(
             child:  Text("No Reservation Available", style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),),
           );      
         
         }*/

            return new ListView(
                children: snapshot.data.documents.map<Widget>((document) {
              /*  for(int i=0;i<snapshot.data.documents.length;i++){
                subtitle = new Text("docid ${snapshot.data.documents[i].documentID}");
                print(subtitle);
                print(snapshot.data.documentChanges.length);
                //print(snapshot.data.documentChanges.getId());
                  //return subtitle;
                          }*/
              return new Container(
                  child: Row(
                children: <Widget>[
                  new Flexible(
                      child: Column(
                    children: <Widget>[
                      new ListTile(
                        title: new Text("Name: ${document['Name']}"),
                        //subtitle: new Text("CheckIn: ${document['CheckIn_date']}"),
                        trailing:
                            new Text("Checkout: ${document['Checkout_date']}"),
                        subtitle: new Text("${document.documentID}"),
                        //subtitle: new Text("${snapshot.data.documents[0]['documentID']}"),
                        //// subtitle: subtitle,
                      ),
                      Align(
                        alignment: Alignment(0, -.500),
                        child: new SizedBox(
                          height: 60.0,
                          child: new RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Share link',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            color: Color(0xff6839ed),
                            onPressed: () {
                              var documentid = "${document.documentID}";
                              var url =
                                  'https://fluttertest.000webhostapp.com/JavaScript/Read%20Data/index.html?Reservation=$documentid';
                              print(documentid);
                              Share.share(url, subject: 'Your Guest app Signin');
                             /* void generic() {
                                print("inside share function");
                                var documentid;
                                documentid = "${document.documentID}";
                                print(documentid);
                                var url =
                                    'https://fluttertest.000webhostapp.com/JavaScript/Read%20Data/index.html?documentid=$documentid';
                                //  var url = "https://fluttertest.000webhostapp.com/JavaScript/Read%20Data/index.html";
                             
                                Share.share(url, subject: 'your url is');
                                generic();
                              }*/
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ));
            }).toList());
          },
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  //EventSummary(this.event);
  final DocumentSnapshot list;
  String email;
  ItemList({this.list, this.email});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  void initState() {
    super.initState();
    print("LISttttttttttt" + "${widget.list.data}".toString());
    print("LIStttttttttttof name" + "${widget.list['Name']}".toString());
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      //itemCount: widget.list == null ? 0 : widget.list.length,
      itemCount: 2,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            //child:   Flexible(
            child: SingleChildScrollView(
              child: new Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new ListTile(
                    title: new Text("Name : ${widget.list['Name']}"),
                    subtitle:
                        new Text("CheckIn: ${widget.list['CheckIn_date']}"),
                    trailing:
                        new Text("Checkout: ${widget.list['Checkout_date']}"),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Card(
                              child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                            Align(
                              alignment: Alignment(0, -.500),
                              child: new SizedBox(
                                height: 60.0,
                                child: new RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(12.0),
                                  ),
                                  child: const Text(
                                    'View info',
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  color: Color(0xffEDE7FF),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Reservation(
                                            propertyname:
                                                "${widget.list['propertiesname']}"
                                                    .toString(),
                                            email: "${widget.email}",
                                          );
                                        },
                                      ),
                                    );
                                    // });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Align(
                              alignment: Alignment(0, -.500),
                              child: new SizedBox(
                                height: 60.0,
                                child: new RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(12.0),
                                  ),
                                  child: const Text(
                                    'Share link',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  color: Color(0xff6839ed),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ])))
                    ],
                  )
                ],
              )),
            ),
            // ),
          ),
        );
      },
    );
  }
}
