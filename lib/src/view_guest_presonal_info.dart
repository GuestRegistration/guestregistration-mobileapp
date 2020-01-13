import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Viewguestpersonalinfo extends StatefulWidget {
  final String primaryguestuid;

  // List list;
  Viewguestpersonalinfo({this.primaryguestuid});
  @override
  _ViewguestpersonalinfoState createState() => new _ViewguestpersonalinfoState();
}

class _ViewguestpersonalinfoState extends State<Viewguestpersonalinfo> {
  var primaryguestuid, image;

  void initState() {
    super.initState();
    print("${widget.primaryguestuid}");
    primaryguestuid = "${widget.primaryguestuid}";
    
    // getguestinfo();
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[              
              FutureBuilder(
                future:Firestore.instance.collection("users").document(primaryguestuid).get(),
              
                        builder: (BuildContext context, snapshot) {
     
             //future: Firestore.instance.collection("ReservationSubmission").where("Basic_Reservation_ID", isEqualTo: resevationid).getDocuments();
            print("snapshot" + snapshot.toString());
            print("snapshotdata" + snapshot.data.toString());
            print("snapshothas" + snapshot.hasData.toString());
         //print("snapshotdata_CheckIn_date" +snapshot.data['email'].toString());

         /*   if (!snapshot.hasData) {
              return new Center(
                child: Text(
                  "Loading....",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              );
            }*/
         //   print("lengthhhhh of snapshot.data.length "+snapshot.data.length);
           //  print("lengthhhhh of snapshot.data.documents.length "+snapshot.data.documents.length);
            //if (snapshot.data.length == 0) {
          /*    print("view guest personal info");
            if(snapshot.hasData == false){
            print("inside if");
                    image = "";
            }
            else{
                print("inside else");
               image = "${snapshot.data['idverification']}";
            }*/
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
                                                  child: Text('🔑 Full Name')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    "${snapshot.data['name']}",
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
                                                      '\u{1F465} Email ')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    "${snapshot.data['email']}",
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
                                                  child: Text(' 💳 Phone Number')),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 120.0,
                                                ),
                                                Container(
                                                  child: new Text(
                                                    '💵'
                                                    "${snapshot.data['phone']}",
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
                                                      ' 📄 Identity document')),
                                            ),
                                            
                                                Column(
                                              children: <Widget>[
                                                //SizedBox(width: 120.0,
                                                                                           
                                                Center(
                                                  child: Container(

                                                      child: 
                                                      image != ""
                                                ? Image.network(
                                                 // image,
                                                      "${snapshot.data['idverification']}",
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
              
                        ],
                      ),
                    ),
                  )),
              // }).toList());
            );
               }
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*class ItemList extends StatefulWidget {
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
                                                  "${widget.list[0]['name']}",
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
                                              child: Text('🔑 email')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                    "${widget.list[0]['email']}",
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
                                              child: Text('🚪 phone')),
                                    ),
                                    
                                          Column(children: <Widget>[
                                              SizedBox(width: 120.0,),
                                             Container(
                                               
                                                child: new Text(
                                                    "${widget.list[0]['phone']}",
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
                                      child: Image.network("${widget.list[0]['idverification']}",width: 100.0,height: 100.0,),

                                                    
                                          
                                                 
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
}*/
