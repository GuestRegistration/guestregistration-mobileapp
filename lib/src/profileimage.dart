import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import './Termsandcon.dart';
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'dart:io';

class Profileimage extends StatefulWidget {
 final String email,primaryguest;
 
   Profileimage({this.email,this.primaryguest});
  @override
  _ProfileimageState createState() => _ProfileimageState();
}

class _ProfileimageState extends State<Profileimage> {
    File img1;

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
    Future uploadimage() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("${widget.primaryguest}",);
    StorageUploadTask uploadTask = storageReference.putFile(img1);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
    //await uploadTask.onComplete;
    print('File Uploaded');
  }
/*
   void update_reservation() async {
       print("inside update_reservation");
    var email = "${widget.email}";
 print(email);
      Firestore.instance
        .collection("Reservation")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) => Firestore.instance
            .collection("users")
            .document("${doc.documentID.toString()}")
            .updateData(
                {
              'Reservation': FieldValue.arrayUnion([
                {
                  'Primary_guest': primary_guest.text,
                  'Additional_guest':addtional_guest.text,
                   
                }
              ]),
            }),
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Profile Image',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'This should be a large square picture of yourself.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white60,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment(-.88, 0),
                child: Text(
                  'Profile Image ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: InkResponse(
                        child: new Column(
                          children: <Widget>[
                            DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: [5, 5],
                              strokeWidth: 3.0,
                              radius: Radius.circular(12),
                              padding: EdgeInsets.all(6),
                              color: Colors.deepPurpleAccent,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  color: Colors.deepPurple[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    bottom: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: new Material(
                        color: Colors.transparent,
                        child: FloatingActionButton(
                          onPressed: () {
                            getImageGallery();
                          },
                          child: Icon(Icons.add),
                          foregroundColor: Colors.deepPurple[800],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 90,
                    bottom: 75,
                    child: Align(
                      alignment: Alignment.center,
                      child: new Material(
                        color: Colors.transparent,
                        child: Text(
                          'Tap to Upload an Image',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ),
                  ),
              
                ],
              ),

                      Center(
                child: img1 == null
                    ? new Text("Please select image")
                    : new Image.file(
                        img1,
                        width: 200.0,
                        height: 200.0,
                      ),
              ),
              //SizedBox(                height: 150              ),

                 SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.deepPurpleAccent,
                  onPressed: () {
                    uploadimage();
                   Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new Termsandcon()
                        )
                   );
                  },
                ),
              )
     
            
            ],
          ),
        ),
      ),
    );
  }
}