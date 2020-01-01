
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'property_edit_text.dart';

class PropertyEdit extends StatefulWidget {
final  String email,propertyid;

  // List list;
  PropertyEdit({this.email,this.propertyid});
  @override
  _PropertyEditState createState() =>
      new _PropertyEditState();
}

class _PropertyEditState extends State<PropertyEdit> {
  List host = List();
    Future<QuerySnapshot> _listFuture;
  Future<QuerySnapshot> future;
  
 void refreshList() {
    // reload
    setState(() {
       _listFuture = getproperty();
    
    });
  }



    Future<QuerySnapshot> getproperty() async {
     var propertyid = "${widget.propertyid}";
              var propertyid1 = int.parse(propertyid);
     print("${widget.propertyid}");
     Future<QuerySnapshot> property =  Firestore.instance
        .collection("Properties")
        .where("Propertyid", isEqualTo: propertyid1)
        .getDocuments();
 
return property;
  
     
  }

  var email;
  
  void initState()  {
    print(widget.email);
    super.initState();
   future= getproperty(); 
      _listFuture = getproperty();

  }
 
  void dispose() {
    super.dispose();
  }

  @override
     Widget build(BuildContext context) {
     return Scaffold(
     backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: new Container(
          height: 1000.0,
          child: new Center(
              // height: 100.0,
              //width: 150.0,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            
              Expanded(
                child: FutureBuilder(
                  future: _listFuture,
                 builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
         return new ListView(
                children: snapshot.data.documents.map<Widget>((document) {
            
              return new Container(
               // height: 200.0,
                  child: SingleChildScrollView(
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
                        Container(
                          child:Text(  "${document['Property_Name']}",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),)
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
                                                child: 
                                                Column(children: <Widget>[
                                                   Text('✒️ Address')],)),
                                                                 
                                                                        
                                      ),
                                      
                                            Column(children: <Widget>[
                                                SizedBox(width: 120.0,),
                                               Container(
                                                 
                                                  child: new Text(
                                              "${document.data['Address']['addressline1']}",
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
                                    //  height: 110.0,
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
                                                child: Text('✒️ Email')),
                                                                 
                                                                        
                                      ),
                                      
                                            Column(children: <Widget>[
                                                SizedBox(width: 120.0,),
                                               Container(
                                                 
                                                  child: new Text(
                                              "${document['email']}",
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
                                                child: Text('✒️ House Rules')),
                                                                 
                                                                        
                                      ),
                                      
                                            Column(children: <Widget>[
                                                SizedBox(width: 120.0,),
                                               Container(
                                                 
                                                  child: new Text(
                                              "${document['terms']}",
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
                                     /*  Container(
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
                                                child: Text('✒️ Address')),
                                                                 
                                                                        
                                      ),
                                      
                                            Column(children: <Widget>[
                                                SizedBox(width: 120.0,),
                                               Container(
                                                 
                                                  child: new Text(
                                              "${document.data['Address']['addressline1']}",
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
                                      //height: 110.0,
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
                                                child: Text('Profile Image')),
                                                                 
                                                                        
                                      ),
                                      
                                            Column(children: <Widget>[
                                                SizedBox(width: 120.0,),
                                               Container(
                                               child:  Center(
                                                                                                child: CircleAvatar(
                                              radius: 100.0,
                                              backgroundImage:
                                                    NetworkImage("${document.data['Property_logo']}"),
                                              backgroundColor: Colors.transparent,
                                            ),
                                               )
                                                 //child: Image.network("${document.data['Property_logo']}",width: 100.0,height: 100.0,),

                                              ),
                                          ],
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      'Edit Property',
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                    color: Color(0xffEDE7FF),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EditProperty(
                                              addressline1: "${document.data['Address']['addressline1']}",
                                              propertyname: "${document['Property_Name']}",
                                              propertyid:"${document['Propertyid']}",
                                              email: "${document['email']}",
                                              propertylogo:document.data['Property_logo'],
                                           // Property_logo: img1,
                                              terms : "${document['terms']}",
                                              city: "${document.data['Address']['city']}",
                                              state: "${document.data['Address']['state']}",
                                              useremail:"${widget.email}",

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
                         
                    ],
                ),
             
              ),
                  )
              );
            }).toList());
          },
                ),
              ),
            ],
          ))),
    );
  }
}
/* 
class ItemList extends StatefulWidget {
   List list;
final  String email;
  ItemList({this.list, this.email});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
 
  void initState() {
 
    super.initState();
    print("LIStttttttttttt" + "${widget.list}".toString());
 
  }
 
 
  @override
    Widget build(BuildContext context) {
    return new Flexible(
        child: Column(
      children: <Widget>[
        Expanded(
            child: SizedBox(
          height: 500.0,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            itemCount: widget.list == null ? 0 : widget.list.length,
            itemBuilder: (context, i) {
              return new Container(
                child: new SingleChildScrollView(
                  child: new GestureDetector(
                    child: Container(
                      height: 200.0,
                                          child: new Card(
                          semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                margin: EdgeInsets.all(15),
                      child: new Column(
                        children: <Widget>[
                              new ListTile(
                          title: Row(children: <Widget>[
                            new Text(
                              "Name :${widget.list[i]['Property_Name']}"
                                  .toString(),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black),),
                                     new Text(
                              "Name :${widget.list[i]['phone']}"
                                  .toString(),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black),),
                           ],) ,
                          subtitle:  new Text("City :${widget.list[i]['email']}".toString(),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.black),),

                        
                        ),
     
                        ],
                      )),
                    ),
                                       
                  ),
                ),
              );
              // );
            },
          ),
        )),
      ],
    )
    );
  }
 
} */
 /*builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    print("snapshot.data"+ snapshot.data.documents[0].data);
                    return snapshot.hasData                    
                        ? 
                                ItemList(
                                  //list:  snapshot.data.documents[0].data['Address'],
                                  list: snapshot.data.documents[0].data,
                                )
                             
                        : new Center(
                            child: CircularProgressIndicator(),
                          );
                  },*/