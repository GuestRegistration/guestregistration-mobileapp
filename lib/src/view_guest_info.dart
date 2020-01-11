import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import '../../../../Downloads/flutter/.pub-cache/hosted/pub.dartlang.org/cloud_firestore-0.13.0+1/lib/cloud_firestore.dart';
import 'view_guest_presonal_info.dart';

class Viewguestinfo extends StatefulWidget {
  final String resevationid;

  // List list;
  Viewguestinfo({this.resevationid});
  @override
  _ViewguestinfoState createState() => new _ViewguestinfoState();
}

class _ViewguestinfoState extends State<Viewguestinfo> {
  var resevationid;
  var image;
  void initState() {
    super.initState();
    print("${widget.resevationid}");
    resevationid = "${widget.resevationid}";
  
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: new FutureBuilder(
          // future: getguestinfo(),
          future: Firestore.instance
              .collection("Reservation")
              .document(resevationid)
              .get(),
          //   builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          builder: (BuildContext context, snapshot) {
              return FutureBuilder(
                future: Firestore.instance.collection("ReservationSubmission").where("Basic_Reservation_ID", isEqualTo: resevationid)
        .getDocuments(),
         builder: (BuildContext context, snapshot1) {
           print("haiiiiiiiiiiiiiii");
           print("length"+snapshot1.data.documents.length.toString());

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
                 if (snapshot1.data.documents.length == 0) {
                    image = "";
        /*      return new Center(
                child: Text(
                  "Loading....",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              );*/
            }

            else{
               image = "${snapshot1.data.documents[0]['signature']}";
            }
            return new Container(
              //  children: snapshot.data.map<Widget>((document) {
              child: new Container(
                //  height: 200.0,
                  child: SingleChildScrollView(
                                      child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.none,
                      elevation: 10,
                      margin: EdgeInsets.all(15),
                      child: Column(
                       mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                                                    height: 10.0,
                                                  ),
                            Container(
                              child: new Text(
                                "${snapshot.data['Booking_channel']} ${snapshot.data['CheckIn_date']} "
                                'to'
                                " ${snapshot.data['Checkout_date']}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                        //  new Flexible(
                            //  child: Column(
                         //   children: <Widget>[
                               
                                                                 Container(
                                        height: 110.0,
                                        width: 550.0,
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          elevation: 10,
                                          margin: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                                
                                                             Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: GestureDetector(
                                                child: Card(
                                                    semanticContainer: true,
                                                    child: Text(
                                                        '✒️ Name on Booking')),
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            new Viewguestpersonalinfo(
                                                              primary_guest_uid:
                                                                  "${snapshot1.data.documents[0]['primary_guest_uid']}",
                                                            )))),
                                          ),
                                              
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 120.0,
                                                  ),
                                                  Container(
                                                    child: new Text(
                                                      "${snapshot.data['Name']}",
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                 
                                         Container(
                                      height: 110.0,
                                      width: 550.0,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 10,
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 550.0,
                                              height: 50.0,
                                              child: Card(
                                                  semanticContainer: true,
                                                child: Text(
                                                      '\u{1F465} Number Guest')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    "${snapshot.data['No_of_guest']}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                             
                                   Container(
                                      height: 110.0,
                                      width: 550.0,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 10,
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 550.0,
                                              height: 50.0,
                                              child: Card(
                                                  semanticContainer: true,
                                                  child: Text('🔑 CheckIn date')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    "${snapshot.data['CheckIn_date']}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 112.0,
                                      width: 550.0,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 10,
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 550.0,
                                              height: 50.0,
                                              child: Card(
                                                  semanticContainer: true,
                                                  child:
                                                      Text('🚪 Checkout date')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    "${snapshot.data['Checkout_date']}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 102.0,
                                      width: 550.0,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 10,
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 550.0,
                                              height:50.0,
                                              child: Card(
                                                  semanticContainer: true,
                                                  child: Text(' 💳 Payment')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    '💵'
                                                    "${snapshot.data['payment']}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // height: 112.0,
                                      width: 550.0,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        elevation: 10,
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 550.0,
                                              height: 50.0,
                                              child: Card(
                                                  semanticContainer: true,
                                                  child: Text(
                                                      ' 📄 Signed Document')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                //SizedBox(width: 120.0,
                                                                                           
                                                Center(
                                                  child: Container(

                                                      child: 
                                                      image != ""
                            ? Image.network(image,
                                                      //"${snapshot1.data.documents[0]['signature']}",
                                                      width: 100.0,
                                                      height: 100.0,
                                                    )
                            :  new Text("Guest user not yet checked in",style:  TextStyle(color: Colors.red, fontSize: 15.0),)
                     // ),
                      
                                                      /*
                                                      Image.network(image,
                                                      //"${snapshot1.data.documents[0]['signature']}",
                                                      width: 100.0,
                                                      height: 100.0,
                                                    ),*/


 
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                          //  ],
                        //  ),
                        //  ),
                        ],
                      ),
                    ),
                  )),
              // }).toList());
            );
               }
        );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  final List list;
  final String resevationid;
  ItemList({this.list, this.resevationid});

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
                height: MediaQuery.of(context).size.height - 50,
                child: SingleChildScrollView(
                  child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      //elevation: 10,
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: new Text(
                              "${widget.list[i]['Booking_channel']} ${widget.list[i]['CheckIn_date']} "
                              'to'
                              " ${widget.list[i]['Checkout_date']}",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          new ListTile(
                            title: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 110.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: GestureDetector(
                                                child: Card(
                                                    semanticContainer: true,
                                                    child: Text(
                                                        '✒️ Name on Booking')),
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            new Viewguestpersonalinfo(
                                                              primary_guest_uid:
                                                                  "${widget.resevationid}",
                                                            )))),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 120.0,
                                              ),
                                              Container(
                                                child: new Text(
                                                  "${widget.list[i]['Name']}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /* Container(
                                     height: 110.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          
                                    Container(
                                      width: 550.0,
                                      height:50.0,

                                                                      child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text('✒️ Primary Guest')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                    "${widget.list[i]['Primary_guest']}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                               
                                            ),
                                        ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
                                  Container(
                                    height: 110.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: Card(
                                                semanticContainer: true,
                                                child: Text(
                                                    '\u{1F465} Number Guest')),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 120.0,
                                              ),
                                              Container(
                                                child: new Text(
                                                  "${widget.list[i]['No_of_guest']}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 110.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: Card(
                                                semanticContainer: true,
                                                child: Text('🔑 CheckIn date')),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 120.0,
                                              ),
                                              Container(
                                                child: new Text(
                                                  "${widget.list[i]['CheckIn_date']}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 112.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: Card(
                                                semanticContainer: true,
                                                child:
                                                    Text('🚪 Checkout date')),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 120.0,
                                              ),
                                              Container(
                                                child: new Text(
                                                  "${widget.list[i]['Checkout_date']}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 112.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: Card(
                                                semanticContainer: true,
                                                child: Text(' 💳 Payment')),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 120.0,
                                              ),
                                              Container(
                                                child: new Text(
                                                  '💵'
                                                  "${widget.list[i]['payment']}",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // height: 112.0,
                                    width: 550.0,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 10,
                                      margin: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 550.0,
                                            height: 50.0,
                                            child: Card(
                                                semanticContainer: true,
                                                child: Text(
                                                    ' 📄 Signed Document')),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 120.0,
                                              ),
                                              Center(
                                                child: Container(
                                                  child: Image.network(
                                                    "${widget.list[i]['signature']}",
                                                    width: 100.0,
                                                    height: 100.0,
                                                  ),

                                                  /*  child:  Container(
                                                 child:  Center(
                                                                                                  child: CircleAvatar(
                                                //radius: 100.0,
                                                backgroundImage:
                                                      NetworkImage("${widget.list[i]['signature']}"),
                                                backgroundColor: Colors.transparent,
                                            ),
                                                 )
                                                   
                                                ),*/
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            // ),
          ),
        );
      },
    );
  }
}
