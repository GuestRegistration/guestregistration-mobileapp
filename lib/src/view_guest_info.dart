import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passwordless/src/Address_screen.dart';



class Viewguestinfo extends StatefulWidget {
  final String resevationid;

  // List list;
  Viewguestinfo({this.resevationid});
  @override
  _ViewguestinfoState createState() => new _ViewguestinfoState();
}

class _ViewguestinfoState extends State<Viewguestinfo> {
  var resevationid;

  void initState() {
    super.initState();
    print("${widget.resevationid}");
    resevationid = "${widget.resevationid}";
    // getguestinfo();
  }

  Future<QuerySnapshot> getguestinfo() async {
    var resevationid = int.parse("${widget.resevationid}");
    Future<QuerySnapshot> reservationdata = Firestore.instance
        .collection("Reservation")
        .where("resevation_id", isEqualTo: resevationid)
        .getDocuments();
    return reservationdata;
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
                             child: new Text("${widget.list[i]['Booking_channel']} ${widget.list[i]['CheckIn_date']} "'to'" ${widget.list[i]['Checkout_date']}",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                    
                                    Container(
                                      width: 550.0,
                                      height:50.0,

                                                                      child: GestureDetector(
                                                                                                                                              child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text('✒️ Name on Booking')),
                                                                   
                                                                   onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                        builder: (BuildContext context) => new FirstScreen(
                                             
                                            )))
                                                                      ),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                  "${widget.list[i]['Name']}",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          
                                    Container(
                                      width: 550.0,
                                      height:50.0,

                                                                      child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text('\u{1F465} Number Guest')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                    "${widget.list[i]['No_of_guest']}",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          
                                    Container(
                                      width: 550.0,
                                     height:50.0,

                                                                      child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text('🔑 CheckIn date')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                    "${widget.list[i]['CheckIn_date']}",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          
                                    Container(
                                      width: 550.0,
                                      height:50.0,

                                                                      child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text('🚪 Checkout date')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                    "${widget.list[i]['Checkout_date']}",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          
                                    Container(
                                      width: 550.0,
                                      height:50.0,

                                                                      child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text(' 💳 Payment')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text('💵'
                                                    "${widget.list[i]['payment']}",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          
                                    Container(
                                      width: 550.0,
                                      height:50.0,

                                                                      child: Card
                                      (
                                         semanticContainer: true,
                                              child: Text(' 📄 Signed Document')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Center(
                                                                                            child: Container(
                                      child: Image.network("${widget.list[i]['signature']}",width: 100.0,height: 100.0,),

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
