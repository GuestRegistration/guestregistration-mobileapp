import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passwordless/src/property_list.dart';
import 'dart:typed_data'; 
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
 
File img1,img2;
 
 var imageFile;
 String dropdownValue;
class EditProperty extends StatefulWidget {
   
  final String addressline1,propertyname,property_id,email,Property_logo,terms,state,city;

  EditProperty({this.addressline1,this.propertyname,this.email,this.property_id,this.Property_logo,this.terms,this.city,this.state});

  @override
  _EditPropertyState createState() => new _EditPropertyState();
}
 
class _EditPropertyState extends State<EditProperty> {
 // @override  
 

  TextEditingController addressline1 = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController  terms = new TextEditingController();
  TextEditingController  propertyname = new TextEditingController();
  TextEditingController  city = new TextEditingController();
    TextEditingController  state = new TextEditingController();

   Future getImageGallery() async{
  
   imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  final tempDir =await getTemporaryDirectory();
  final path = tempDir.path;
  int rand= new Math.Random().nextInt(100000);
  Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
  //Img.Image smallerImg = Img.copyResize(image, 500);
 
  var compressImg= new File("$path/image_$rand.jpg")
    ..writeAsBytesSync(Img.encodeJpg(image, quality: 85));
 
  setState(() {
     
      img1 = compressImg;
    });
}
 
Future getImageCamera() async{
  var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
  final tempDir =await getTemporaryDirectory();
  final path = tempDir.path;
  int rand= new Math.Random().nextInt(100000);
  Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
 // Img.Image smallerImg = Img.copyResize(image, 500);
   var compressImg= new File("$path/image_$rand.jpg")
  ..writeAsBytesSync(Img.encodeJpg(image, quality: 85));
   
  setState(() {
     
      img1 = compressImg;
      
    });
}



       
 
  @override
  var product_image;
   var p_img;
   
  void initState() {
    //controllerId = new TextEditingController(text: widget.list[widget.index]['id']);
   addressline1 = new TextEditingController(text: widget.addressline1);
    email = new TextEditingController(text: widget.email);
    terms = new TextEditingController(text: widget.terms);
    propertyname = new TextEditingController(text: widget.propertyname);
    city = new TextEditingController(text: widget.city);
    state = new TextEditingController(text: widget.state);


//print(widget.Property_logo);
    super.initState();
     
  }
   void update_property() async {
       print("inside update_Property");
    var propertyid = "${widget.property_id}";
              var property_id = int.parse(propertyid);
              print(property_id);
      Firestore.instance
        .collection("Properties")
        .where("Propertyid", isEqualTo: property_id)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) => Firestore.instance
            .collection("Properties")
            .document("${doc.documentID.toString()}")
            .updateData(
                
                {
                  
              'Address': FieldValue.arrayUnion([
                {
                    'addressline1':addressline1.text,
                    'city':city.text,
                    'state':state.text
                }
              ]),
                'email':email.text,
                'Property_Name':propertyname.text,
              'terms':terms.text,
             // '':
            }),
      );
    });
  }
  Widget build(BuildContext context) {
   return new Scaffold(
     backgroundColor: Colors.white,
 
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
               /*TextField(
  decoration: InputDecoration(
  hintText: "Enter your name!",
  hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.blue),
  enabledBorder: new OutlineInputBorder(
      borderSide: new BorderSide(color: Colors.blue)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange),
  ),
  ),
) */
  SizedBox(
                  height: 10.0,
                ),
                  
                  new TextField(
                  controller: addressline1,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.location_on),
                    labelText: "Update Address",
                    fillColor: Colors.white,
                   
                     enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  //  ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                    new TextField(
                  controller: email,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.email),
                    labelText: "Update Email",
                    fillColor: Colors.white,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                   new TextField(
                  controller: terms,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.rv_hookup),
                    //labelText: "Enter product_price",
                      labelText: "Update House Rules",

                    fillColor: Colors.white,
                   enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),

                new TextField(
                  controller: propertyname,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.storage),
                    labelText: "Updata Name",
                    fillColor: Colors.white,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                     // borderSide: new BorderSide(),
                      borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),  
                    ),
                  ),
                ),
                
                SizedBox(
                  height: 10.0,
                ),
     
                     SingleChildScrollView(
              child: Column(
                
          children: <Widget>[
           Center(
              child: img1==null // &&
 
             ? new Image.network("${widget.Property_logo}", width: 150.0, height: 150.0,)

             // ? new Image.file(img1,width: 150.0,height: 150.0,)
              : new Image.file(img1,width: 150.0,height: 150.0,),
           ),
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                    Text("Modify image ",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.image,color: Colors.black,),
                  color: Colors.black38,
                  onPressed: getImageGallery,
                ),
                   IconButton(
                  icon: Icon(Icons.camera_alt,color: Colors.black,),
                    color: Colors.black38,
                  onPressed: getImageCamera,
                ),
               /* RaisedButton(
                  child: Icon(Icons.image),
                  onPressed: dispImage,
                ),*/
                Expanded(child: Container(),),
                 

              ],

            ),
                   
          ],
        ),
      ),
            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
             
                
                 RaisedButton(
                  child: Text("Update Property"),
                  color: Colors.blueAccent,
                  onPressed:(){
                  update_property();
                  }, 
                ),
              ],
            ),
                ],
            ),
          ],
         ),   
      ),
   );
 }

}