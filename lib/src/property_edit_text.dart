import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:passwordless/src/property_list_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'dart:async';

class EditProperty extends StatefulWidget {
  final String addressline1,
      propertyname,
      propertyid,
      email,
      terms,
      state,
      city,
      useremail;
  final String propertylogo;
  EditProperty(
      {this.addressline1,
      this.propertyname,
      this.email,
      this.propertyid,
      this.propertylogo,
      this.terms,
      this.city,
      this.state,
      this.useremail});

  @override
  _EditPropertyState createState() => new _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  // @override
  File img1, img2;

  var imageFile;
  String dropdownValue;

  TextEditingController addressline1 = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController terms = new TextEditingController();
  TextEditingController propertyname = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController state = new TextEditingController();

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);
    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    // Img.Image smallerImg = Img.copyResize(image, 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(image, quality: 85));
    setState(() {
      img1 = compressImg;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);
    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    // Img.Image smallerImg = Img.copyResize(image, 500);
    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(image, quality: 85));
    setState(() {
      img1 = compressImg;
    });
  }

  @override


  void initState() {
    //controllerId = new TextEditingController(text: widget.list[widget.index]['id']);
    addressline1 = new TextEditingController(text: widget.addressline1);
    email = new TextEditingController(text: widget.email);
    terms = new TextEditingController(text: widget.terms);
    propertyname = new TextEditingController(text: widget.propertyname);
    city = new TextEditingController(text: widget.city);
    state = new TextEditingController(text: widget.state);

    print(addressline1);
    print(widget.propertylogo);
    super.initState();
  }

  void updateproperty() async {
    print("inside update_Property");
    var url;
    StorageReference storageReference;
    StorageUploadTask uploadTask;
    //StorageTaskSnapshot downloadUrl;
    var propertyid = "${widget.propertyid}";
    var propertyid1 = int.parse(propertyid);
    print(propertyid);
    Firestore.instance
        .collection("Properties")
        .where("Propertyid", isEqualTo: propertyid1)
        .getDocuments()
        .then((string) async {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach((doc) async => {
            if (img1 == null)
              {
                print("img not change"),
                Firestore.instance
                    .collection("Properties")
                    .document("${doc.documentID.toString()}")
                    .updateData({
                  'Address': {
                    'addressline1': addressline1.text,
                    'city': city.text,
                    'state': state.text
                  },
                  //'Property_logo':widget.Property_logo,
                  'email': email.text,
                  //'Property_Name': propertyname.text,
                  'terms': terms.text,
                  // '':
                }).whenComplete(() {
                  print('Field Uodated');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => PropertyListdbScreen(
                                email: "${widget.useremail}",
                                // property_id:"${widget.property_id}",
                              )));
                }),
              }
            else
              {
                /*FirebaseStorage.instance.ref().child("2020"),
        print(img1),
        print("${widget.propertyname}"),
                uploadTask = storageReference.putFile(img1),
                downloadUrl = (await uploadTask.onComplete),
                url = (downloadUrl.ref.getDownloadURL()),
                print('URL Is $url'),
                print('File Uploaded'),*/

                storageReference =
                    FirebaseStorage.instance.ref().child(propertyname.text),
                uploadTask = storageReference.putFile(img1),
                url = await (await uploadTask.onComplete).ref.getDownloadURL(),
                url = url.toString(),
                print(url),
                print(img1),
                Firestore.instance
                    .collection("Properties")
                    .document("${doc.documentID.toString()}")
                    .updateData({
                  'Address': {
                    'addressline1': addressline1.text,
                    'city': city.text,
                    'state': state.text
                  },
                  'Property_logo': url,
                  'email': email.text,
                  //'Property_Name': propertyname.text,
                  'terms': terms.text,
                  // '':
                }).whenComplete(() {
                  print('Field Uodated');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => PropertyListdbScreen(
                                email: "${widget.useremail}",
                                // property_id:"${widget.property_id}",
                              )));
                }),
              },
          });
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
               /* new TextField(
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
                ),*/
                SizedBox(
                  height: 10.0,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: img1 == null
                            ? //new Image.network("${widget.Property_logo}", width: 150.0, height: 150.0,)
                            Center(
                                child: CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage:
                                      NetworkImage("${widget.propertylogo}"),
                                  backgroundColor: Colors.transparent,
                                ),
                              )
                            // ? new Image.file(img1,width: 150.0,height: 150.0,)
                            : new Image.file(
                                img1,
                                width: 150.0,
                                height: 150.0,
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Modify image ",
                            style: new TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                            color: Colors.black38,
                            onPressed: getImageGallery,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                            color: Colors.black38,
                            onPressed: getImageCamera,
                          ),
                          /* RaisedButton(
                  child: Icon(Icons.image),
                  onPressed: dispImage,
                ),*/
                          Expanded(
                            child: Container(),
                          ),
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
                      onPressed: () {
                        updateproperty();
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
