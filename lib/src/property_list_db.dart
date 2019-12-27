import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:passwordless/src/Reservation.dart';
import 'package:passwordless/src/reservation_list_db.dart';

class Property_List_db_Screen extends StatefulWidget {
  String email;

  // List list;
  Property_List_db_Screen({this.email});
  @override
  _Property_List_db_ScreenState createState() =>
      new _Property_List_db_ScreenState();
}

class _Property_List_db_ScreenState extends State<Property_List_db_Screen> {
  List host = List();
    Future<QuerySnapshot> _listFuture;
  Future<QuerySnapshot> future;
    void refresh() {
    print("inside refresh");
       Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> Property_List_db_Screen(
                          email: "${widget.email}",
                        )
                      ));
  }
   Future<QuerySnapshot> getproperty() async {
    // await Future.delayed(Duration(seconds: 5));
// setState(() {       

    var email = "${widget.email}";
   // List<List> host = List();
    print("emailllllll" + email);
     Future<QuerySnapshot> user =  Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();

return user;
 //});
     
  }

  var email;
  void initState()  {
    super.initState();
   future= getproperty(); 
    //getproperty();
    email = "${widget.email}";
    print("${widget.email}");
      _listFuture = getproperty();
//Navigator.pop(context);
//refresh();
 /*setState(() {
      //_listFuture = updateAndGetList();
       refresh();
    });*/
  }
  void refreshList() {
    // reload
    setState(() {
       _listFuture = getproperty();
    
    });
  }
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*return RefreshIndicator(
          child: Scaffold(*/
          return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: FutureBuilder(
              /*future: Firestore.instance
                  .collection("users")
                  //.where("email", isEqualTo: "${widget.email}")
                  .where("email", isEqualTo: email)
                  .getDocuments(),*/
                  future: _listFuture,
              builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                 switch (snapshot.connectionState) {
             case ConnectionState.waiting: return new Text('Loading....');
             default:
                // print("snapshotdata"+snapshot.data.documents[0].data['host'].toString());
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.hasData) {
                  if (snapshot.data != null) {                 
                      
                    return snapshot.hasData
                        ? new ItemList(
                            //  list: host,
                            list: snapshot.data.documents[0].data['host'],
                            email: "${widget.email}",
                            //list: snapshot.data['host'],
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
              
            )),
      ); //onRefresh: refreshList,
    //);
  }
}

class ItemList extends StatefulWidget {
  final List list;
  String email;
  ItemList({this.list, this.email});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
 
  void initState() {
 
    super.initState();
    print("LIStttttttttttt" + "${widget.list}".toString());
/*    setState(() {
      build(context);
});*/
  }

  /*
   
    */
  void refresh() {
    print("inside refresh");
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new Property_List_db_Screen(),
    ));
  }

  void delete_property(propertyid,i) {
    print("inside delete_property function");
    print("propertyname" + propertyid);
    var propertyid1 = int.parse(propertyid);
    Firestore.instance
        .collection("Properties")
        .where("Propertyid", isEqualTo: propertyid1)
        .getDocuments()
        .then((string) {
      print('Firestore response: , ${string.documents.length}');
      string.documents.forEach(
        (doc) => Firestore.instance
            .collection("Properties")
            .document("${doc.documentID.toString()}")
            .delete()
            .whenComplete(() {
              /*  setState(() {
              widget.list.removeAt(i);
            });*/
       //     Navigator.pop(context);

                              Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> Property_List_db_Screen(
                          email: "${widget.email}",
                        )
                      ));
                          
            
          print('Field Deleted in property table');
        }),
      );
    });
  }

  void delete_user_property(propertyname,city,role,propertyid) async {
    var email = "${widget.email}";
        var propertyid1 = int.parse(propertyid);
        print(propertyid1);
    print("inside delete_user_property function");
    print("propertyname" + propertyname);
    print("city" + city);
    print("role" + role);
    print("propertyid" + propertyid.toString());
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
            .updateData({
          'host': FieldValue.arrayRemove([
            {
              'propertiesname': propertyname,
              'city': city,
              'role': role,
              'Propertyid': propertyid1,
            }
          ]),
        }).whenComplete(() {
          // refresh();
          print('Field Deleted');

        }),
      );
      var string1 = string.documents[0].data;
      //    print("String"+string1.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: widget.list == null ? 0 : widget.list.length,
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
                    title: new Text(
                        "Properties name : ${widget.list[i]['propertiesname']}"
                            .toString()),
                    subtitle:
                        new Text("City : ${widget.list[i]['city']}".toString()),
                    trailing:
                        new Text("role : ${widget.list[i]['role']}".toString()),
                        //  new Text("role : ${widget.list[i]['Propertyid']}".toString()),
                    /* new IconButton(icon: new Icon(Icons.menu),
            onPressed: (){},
          ),     */
                    leading: new IconButton(
                      icon: new Icon(Icons.delete),
                      onPressed: () {
                        //  setState(() {
  delete_user_property("${widget.list[i]['propertiesname']}","${widget.list[i]['city']}","${widget.list[i]['role']}","${widget.list[i]['Propertyid']}");
                       delete_property("${widget.list[i]['Propertyid']}",i);
                        // });
                      },
                    ),
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
                                    'Add Reservation',
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
                                                "${widget.list[i]['propertiesname']}"
                                                    .toString(),
                                                    property_id:"${widget.list[i]['Propertyid']}",
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
                                    'View Guests',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  color: Color(0xff6839ed),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Property_List_db_Screen(
                                              //    email:email
                                              );
                                        },
                                      ),
                                    );
                                    // });
                                  },
                                ),
                              ),
                            ),
                           
                          ])
                          
                          ))
                    ],
                  ),
                       Align(
                             // alignment: Alignment(0, -.500),
                              child: new SizedBox(
                                height: 60.0,
                                child: new RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(12.0),
                                  ),
                                  child: const Text(
                                    'View Reservation',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  color: Color(0xff6839ed),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Reservation_List_db_Screen(
                                              email:"${widget.email}",
                              property_name : "${widget.list[i]['propertiesname']}",
                              property_id: "${widget.list[i]['Propertyid']}",
                                              );
                                        },
                                      ),
                                    );
                                    // });
                                  },
                                ),
                              ),
                            ),
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
