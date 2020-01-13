import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passwordless/src/view_guest_info.dart';
//import 'package:advanced_share/advanced_share.dart';
import 'package:share/share.dart';

import 'basic_view_guest_info.dart';

class ReservationLisdbScreen extends StatefulWidget {
  final String email, propertyname, propertyid;

  // List list;
  ReservationLisdbScreen(
      {this.email, this.propertyname, this.propertyid});
  @override
  _ReservationLisdbScreenState createState() =>
      new _ReservationLisdbScreenState();
}

class _ReservationLisdbScreenState
    extends State<ReservationLisdbScreen> {
  int i = 0;
  List host = List();
  Future<QuerySnapshot> _listFuture;
  Future<QuerySnapshot> future;

  Future<QuerySnapshot> getreservation() async {
    var propertyid1 = int.parse("${widget.propertyid}");
    Future<QuerySnapshot> reservation = Firestore.instance
        .collection("Reservation")
        .where("property_id", isEqualTo: propertyid1)
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

 void checkcompletereservation(docid) async {

    print("docid"+docid); 
    print("inside checkcompletereservation");
    Firestore.instance
        .collection("ReservationSubmission")
        .where("Basic_Reservation_ID", isEqualTo: docid)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      if (string.documents.length == 0) {
        print("inside if");
           Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Basicviewguestinfo (
                                              //resevationid: "${document.documentID}",
                                              resevationid: docid,
                                             propertyname:"${widget.propertyname}",
                                          );
                                        },
                                      ),
                                    );
        } 
        else {
          print("inside else");
          Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Viewguestinfo(
                                            //  resevationid: "${document.documentID}",
                                            resevationid: docid,
                                                                       );
                                        },
                                      ),
                                    );
        }
            /*if(string.documents.length){

            }
            else{

            } */  
    });
  }
  final scaffoldKey = new GlobalKey<ScaffoldState>();

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
              ( context, snapshot) {
               // print("docid"+snapshot.data.documents.documentID);
                 /*   return FutureBuilder(
                future: Firestore.instance
                    .collection("ReservationSubmission")
                    .where("Basic_Reservation_ID", isEqualTo: snapshot.data.documents.documentID)
                    .getDocuments(),
                builder: (BuildContext context, snapshot1) {*/
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

         /*   print("snapshot1"+snapshot1.data);
               print("snapshot1length"+snapshot1.data.length);   
               print("snapshot1hasdata"+snapshot1.hasData.toString());*/

            /*if(snapshot1.hasData){
              pr
            }*/
         return new ListView(
                children: snapshot.data.documents.map<Widget>((document) {
                  Text("hai",style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 55.0),);
              return new Container(
                height: 200.0,
                  child: Card(
                semanticContainer: true,
                clipBehavior: Clip.none,
                elevation: 10,
                margin: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    new Flexible(
                        child: Column(
                      children: <Widget>[
                        new ListTile(
                          
                          title: new Text("${document['Name']}",  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),),
                          subtitle: new Row(
                            children: <Widget>[
                                SizedBox(width: 10.0,),
                              Icon(Icons.store_mall_directory,
                          color: Colors.black45,
                              ),
                          //     Icon(Icons.inbox),
                            SizedBox(width: 10.0,),
                              Text(
                                "${document['CheckIn_date']}",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                              //Icon(Icons.domain),

                              SizedBox(width: 10.0,),
                               Icon(Icons.local_convenience_store, color: Colors.black45,),
                                  SizedBox(width: 10.0,),
                              Text("${document['Checkout_date']}",  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),),
                                      SizedBox(width: 1.0,),
                            ],
                          ),

                          //trailing:new Text("${document['Checkout_date']}"),
                          // subtitle: new Text("${document.documentID}"),
                        ),
                        // Card(
                        //  color: Colors.black,

                        // Wrap children in a Padding widget in order to give padding.
                        /*child: Padding(
                             padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                            left: 64.0,
                          ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    checkcompletereservation(document.documentID);
                                 /*   if ("${document.documentID}" == null) {
                                      print("inside if");
                                  
                                    } else {
                                       print("inside else");
                                      
                                    }*/
                                    /* Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Viewguestinfo(
                                            //resevationid:"${document['resevation_id']}",


                                              resevationid: "${document.documentID}",
                                             
                                          );
                                        },
                                      ),
                                    );*/
                                    // });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
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
                                  onPressed: () {
                                    var documentid = "${document.documentID}";
                                    var url =
                                        'https://fluttertest.000webhostapp.com/JavaScript/Read%20Data/index.html?Reservation=$documentid';
                                    print(documentid);
                                    Share.share(url,
                                        subject: 'Your Guest app Signin');
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            )
                          ],
                        ),
                        //  )
                        // ),
                      ],
                    )),
                       SizedBox(
                              height: 25.0,
                            ),
                  ],
                ),
             
              )
              );
            }).toList());
          },
       // );} 
         ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  //EventSummary(this.event);
  final DocumentSnapshot list;
 final String email;
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
                                          return Viewguestinfo(
                                            resevationid:"${widget.list['propertiesname']}",
                                                     
                                             
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
