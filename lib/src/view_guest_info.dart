import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:passwordless/src/Reservation.dart';
import 'package:passwordless/src/reservation_list_db.dart';

class View_guest_info extends StatefulWidget {
  String resevation_id;

  // List list;
  View_guest_info({this.resevation_id});
  @override
  _View_guest_infoState createState() => new _View_guest_infoState();
}

class _View_guest_infoState extends State<View_guest_info> {
  var resevation_id;

  void initState() {
    super.initState();
    print("${widget.resevation_id}");
    resevation_id = "${widget.resevation_id}";
    // getguestinfo();
  }

  Future<QuerySnapshot> getguestinfo() async {
    var resevation_id = int.parse("${widget.resevation_id}");
    Future<QuerySnapshot> reservation_data = Firestore.instance
        .collection("Reservation")
        .where("resevation_id", isEqualTo: resevation_id)
        .getDocuments();
    return reservation_data;
  }

  Future<QuerySnapshot> getguestinfo1() async {
    var resevation_id = int.parse("${widget.resevation_id}");
    Future<QuerySnapshot> reservation_data = Firestore.instance
        .collection("Reservation")
        .where("resevation_id", isEqualTo: resevation_id)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) => print('Firestore response111: , ${doc.data}'),
      );
    });
    return reservation_data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getguestinfo(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading....');
                  default:
                    print(
                        "snapshotdata" + snapshot.data.documents[0].toString());
                    if (snapshot.hasError) print(snapshot.error);
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return snapshot.hasData
                            ? new ItemList(
                                list: snapshot.data.documents,
                              )
                            : new Center(
                                child: new CircularProgressIndicator(),
                              );
                      }
                    } else {
                      return new CircularProgressIndicator();
                    }
                    return null;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;

  ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  void initState() {
    super.initState();
    print("LIStttttttttttt" + widget.list[0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return new Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            //child:   Flexible(
            child: SingleChildScrollView(
              child: Container(
                //  height: 300.0,
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    //elevation: 10,
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new ListTile(
                            title: Column(
                              children: <Widget>[
                                Container(
                                  height: 100.0,
                                                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 10,
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        new Text("Name on Booking"),
                                        new Text(
                                          "${widget.list[i]['Name']}".toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                               Container(
                                  height: 100.0,
                                                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 10,
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        new Text("Primary Guest"),
                                        new Text(
                                          "${widget.list[i]['Primary_guest']}".toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                      Container(
                                  height: 100.0,
                                                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 10,
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        new Text("CheckOut date"),
                                        new Text(
                                          "${widget.list[i]['Checkout_date']}".toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100.0,
                                   child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 10,
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      children: <Widget>[
                                        new Text("CheckIn date"),
                                        new Text(
                                          "${widget.list[i]['CheckIn_date']}".toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          /*  subtitle: new Column(
                              children: <Widget>[
                                new Text(
                                  "Name :${widget.list[i]['Name']}".toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            )*/
                            ),
                      ],
                    )),
              ),
            ),
            // ),
          ),
        );
      },
    );
  }
}
