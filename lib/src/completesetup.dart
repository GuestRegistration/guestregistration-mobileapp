import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:passwordless/src/Termsandcon.dart';
import 'package:passwordless/src/property_list_db.dart';
import 'dart:math' as Math;

import 'package:path_provider/path_provider.dart';

class Completesetup extends StatefulWidget {
 final String addressline1, email, city, state;
  Completesetup({this.addressline1, this.email, this.city, this.state});
  @override
  _CompletesetupState createState() => new _CompletesetupState();
}

class _CompletesetupState extends State<Completesetup> {
  File img1;
  String link;
  String _error = "";
  //GlobalKey<FormState> _key = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  bool _validate = false;
  String name, email, mobile;

  void initState() {
    print("${widget.addressline1}".toString());
    if ("${widget.addressline1}" == "null" &&
        "${widget.city}" == "null" &&
        "${widget.state}" == "null") {
      print("addressline1111111111111" + "${widget.addressline1}".toString());
      print("inside if condition");
      /*  address_line1.addListener(() {
    final text = address_line1.text;
    address_line1.value = address_line1.value.copyWith(
      text: text,
      selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
  });*/
      addressline1.clear();
      city.clear();
      state.clear();
    } else {
      print("inside else condition");

      addressline1 = new TextEditingController(text: "${widget.addressline1}");
      city = new TextEditingController(text: "${widget.city}");

      state = new TextEditingController(text: "${widget.state}");
    }

    super.initState();
  }

  TextEditingController propertyemail = new TextEditingController();
  TextEditingController propertyname = new TextEditingController();
  TextEditingController propertyphone = new TextEditingController();
  TextEditingController propertystaff = new TextEditingController();
  TextEditingController addressline1 = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController state = new TextEditingController();
  String dropdownValue;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool _visible = false;

  void updateuser(randomNumber) async {
    var email = "${widget.email}";
    //var firestoreid;
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
            .updateData(
                //'host': [{'propertiesname': propertiesname.text, 'role': role.text}],
                {
              'host': FieldValue.arrayUnion([
                {
                  'propertiesname': propertyname.text,
                  'city': city.text,
                  'role': dropdownValue,
                  'Propertyid': randomNumber,
                }
              ]),
            }),
            
      );
              scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Property Added Sucessfully"),                             
                                
                              ));
    }).whenComplete(() => navigate());
  }
void navigate(){
  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> PropertyListdbScreen(
                          email: "${widget.email}",
                        )
                      ));
}
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

  Future uploadFile() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(propertyname.text);
    StorageUploadTask uploadTask = storageReference.putFile(img1);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        img1 = fileURL;
      });
    });
  }

  Future uploadimage() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(propertyname.text);
    StorageUploadTask uploadTask = storageReference.putFile(img1);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
    //await uploadTask.onComplete;
    print('File Uploaded');
  }

  bool ownercheck(List host, String value) {
    bool ownerflag = false;
    print(host);
    for (int i = 0; i < host.length; i++) {
      ownerflag = host[i]['role'].contains(value);
      print("owner_flag" + ownerflag.toString());
      if (ownerflag == true) {
        print("owner present");
        return ownerflag;
      }
    }
    return false;
  }

  addProperty() async {
    Random random = new Random();
    var randomNumber = random.nextInt(1000000) + 10;
    print("randomnumber" + randomNumber.toString());
    var email = "${widget.email}";
    var url;
    
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .then((string) async {
      print('Firestore response111: , ${string.documents.length}');
      StorageReference storageReference;
      StorageUploadTask uploadTask;
      StorageTaskSnapshot downloadUrl;
      bool ownerpresent = false;
      dynamic host;
      int length;
      String value = "Owner";
    

      string.documents.forEach((doc) async => {
            length = doc.data['host'].length,
            print("lengthhhhhhhhhhhhhhhh" + length.toString()),
            /*  if (length == 0) {
              update_user(randomNumber),
            } else {
              print("user have host value"),
            },*/
            host = doc.data['host'],
            ownerpresent = ownercheck(host, value),
            print("ownerpresent" + ownerpresent.toString()),
            print("dropdownValue"+dropdownValue),
            if(dropdownValue == "Staff"){
                print("inside if"),
                   storageReference =
                    FirebaseStorage.instance.ref().child(propertyname.text),
                uploadTask = storageReference.putFile(img1),
                downloadUrl = (await uploadTask.onComplete),
                url = (await downloadUrl.ref.getDownloadURL()),
                print('URL Is $url'),
                print('File Uploaded'),
                Firestore.instance.runTransaction(
                  (Transaction transaction) async {
                    Firestore.instance
                        .collection('Properties')
                        .document()
                        .setData({
                      'Propertyid': randomNumber,
                      'Property_Name': propertyname.text,
                      'Property_logo': url,
                      'email': propertyemail.text,
                      'phone': propertyphone.text,
                      'Team': {
                        'staff': propertystaff.text,
                        "owner": "${widget.email}"
                      },
                      /* 'Team': FieldValue.arrayUnion([
                      {
                        'staff': property_staff.text,
                        'owner': "${widget.email}",
                        
                      }
                       ]),*/
                      'Reservation': {'listofreservation': "${widget.email}"},
                      'Reservation': {'guestform': "${widget.email}"},
                      'Address': {
                        'addressline1': addressline1.text,
                        'city': city.text,
                        'state': state.text
                      }
                    });
                  },
                ).whenComplete(() => updateuser(randomNumber))
              }
          
              else if (ownerpresent == true)
              {
                print("Firestore response222: ${doc.data.toString()}"),
                print("owner already set"),
                setState(() {
                  _error = "You have exceed the limit of adding property";
                  _visible = ownerpresent;
                }),
                print(_visible)
              }
            else
              {
                print("owner_flag false"),
                storageReference =
                    FirebaseStorage.instance.ref().child(propertyname.text),
                uploadTask = storageReference.putFile(img1),
                downloadUrl = (await uploadTask.onComplete),
                url = (await downloadUrl.ref.getDownloadURL()),
                print('URL Is $url'),
                print('File Uploaded'),
                Firestore.instance.runTransaction(
                  (Transaction transaction) async {
                    Firestore.instance
                        .collection('Properties')
                        .document()
                        .setData({
                      'Propertyid': randomNumber,
                      'Property_Name': propertyname.text,
                      'Property_logo': url,
                      'email': propertyemail.text,
                      'phone': propertyphone.text,
                      'Team': {
                        'staff': propertystaff.text,
                        "owner": "${widget.email}"
                      },
                      /* 'Team': FieldValue.arrayUnion([
                      {
                        'staff': property_staff.text,
                        'owner': "${widget.email}",
                        
                      }
                       ]),*/
                      'Reservation': {'listofreservation': "${widget.email}"},
                      'Reservation': {'guestform': "${widget.email}"},
                      'Address': {
                        'addressline1': addressline1.text,
                        'city': city.text,
                        'state': state.text
                      }
                    });
                  },
                ).whenComplete(() => updateuser(randomNumber))
              },
              
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        //backgroundColor: Colors.white,
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              child: SingleChildScrollView(
                child: new Form(
                  autovalidate: _validate,
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Text(
                            "Add your Property",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0,fontWeight: FontWeight.bold),
                          ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                        //     widthFactor: left
                        child: Container(
                          // color: Color(0xffD6C9F5),
                          child: Text(
                            "Name",
                            style:
                                TextStyle(color:Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                         //     color: Color(0xffD6C9F5),
                         color: Colors.white,
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: propertyname,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            validator: (value) {
                              if (value.isEmpty) {
                            
                                return "please enter Property name ";
                              }
                              return null;
                            },
                            
                            decoration: InputDecoration(
                              hintText: 'Name',
                              //prefixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.all(20),
                              // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                        //     widthFactor: left
                        child: Container(
                          // color: Color(0xffD6C9F5),
                          child: Text(
                            "Email address",
                            style:
                                TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                                 color: Colors.white,
                              //color: Color(0xffD6C9F5),
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: propertyemail,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            validator: validateEmail,
                            onSaved: (String val) {
                              email = val;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              //prefixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.all(20),

                              // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: img1 == null
                            ? new Text("Please select image",style:  TextStyle(color: Colors.red, fontSize: 15.0),)
                            : new Image.file(
                                img1,
                                width: 100.0,
                                height: 100.0,
                              ),
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 100.0,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            onPressed: getImageGallery,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            onPressed: getImageCamera,
                          ),
                          Expanded(
                            child: Container(
                              
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                        //     widthFactor: left
                        child: Container(
                          // color: Color(0xffD6C9F5),
                          child: Text(
                            "Phone",
                            style:
                                TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                              //color: Color(0xffD6C9F5),
                                 color: Colors.white,
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            validator: validateMobile,
                            onSaved: (String val) {
                              mobile = val;
                            },
                            controller: propertyphone,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              contentPadding: EdgeInsets.all(20),
                                          ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                                    child: Container(
                           child: Text(
                            "Staff Email",
                            style:
                                TextStyle( color: Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                        //     color: Color(0xffD6C9F5),
                           color: Colors.white,
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: propertystaff,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            validator: validateEmail,
                            onSaved: (String val) {
                              email = val;
                            },
                            decoration: InputDecoration(
                              hintText: 'Staff Email',
                              contentPadding: EdgeInsets.all(20),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(

                        width: 186.0,
                        
                        child: Container(
                                                  child: DropdownButtonFormField<String>(
                            value: dropdownValue,
                            
                            hint: Text('Please choose role', style:
                                  TextStyle(color: Colors.white, fontSize: 15.0),),
                            decoration: InputDecoration(
                               
                                contentPadding: const EdgeInsets.all(0.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                isDense: true),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['Owner', 'Staff'].map((role) {
                              return DropdownMenuItem(
                                child: new Text(role,style:
                                  TextStyle( color: Colors.pink, fontSize: 15.0),),
                                value: role,
                              );
                            }).toList(),
                            validator: (String value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of business';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
   SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                        //     widthFactor: left
                        child: Container(
                          // color: Color(0xffD6C9F5),
                          child: Text(
                            "Address ",
                            style:
                                TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                             // color: Color(0xffD6C9F5),
                             color: Colors.white,
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            //     initialValue: "${widget.addressline1}",
                            validator: (value) {
                              if (value.isEmpty) {
                              //  print(value.length);
                                return "please enter Property Address ";
                              }
                              return null;
                            },
                            controller: addressline1,
                            keyboardType: TextInputType.text,
                            autofocus: false,

                            decoration: InputDecoration(
                              hintText: 'Address',
                              //prefixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.all(20),

                              // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                        //     widthFactor: left
                        child: Container(
                          // color: Color(0xffD6C9F5),
                          child: Text(
                            "City",
                            style:
                                TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                              //color: Color(0xffD6C9F5),
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            controller: city,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            validator: (value) {
                              if (value.isEmpty) {
                            //    print(value.length);
                                return "please enter Property City ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'City',
                              //prefixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.all(20),

                                    ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment(-.85, 0),
                        //     widthFactor: left
                        child: Container(
                          // color: Color(0xffD6C9F5),
                          child: Text(
                            "State",
                            style:
                                TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment(-.100, 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(12.0)),
                          child: TextFormField(
                            // initialValue: "${widget.state}",
                            controller: state,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            validator: (value) {
                              if (value.isEmpty) {
                             //   print(value.length);
                                return "please enter Property State ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'State',
                              //prefixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.all(20),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 10.0,
                      ),
                      Visibility(
                        child: Text(
                          _error,
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                        visible: _visible,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      new SizedBox(
                        width: 300.0,
                        height: 60.0,
                        child: new RaisedButton(
                          child: const Text(
//                            'Complete setup',
                          'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Color(0xff6839ed),
                          onPressed: () {
              
                                if (formKey.currentState.validate()&&img1!=null) {
                                  setState(() {
                                  _visible = false;
                                });
                                // No any error in validation
                                print(_visible);
                                //print(ownerpresent);
                                formKey.currentState.save();
                                /* addProperty();
                                  scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Start Adding Property"),                             
                                
                              ));*/
                                Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> Termsandcon(
                          email: "${widget.email}",
                           propertiesname: propertyname.text,
                          city: city.text,
                          dropdownValue: dropdownValue,
                          img1 : img1,
                      propertyemail: propertyemail.text,
                      phone: propertyphone.text,
                      staff: propertystaff.text,
                       owner: "${widget.email}",
                       addressline1:addressline1.text,
                               state: state.text,
                         
                      )));
                                           
                              } else {
                                // validation error
                                scaffoldkey.currentState.showSnackBar(SnackBar(
                                content: Text("Failed to Add Property"),
                              ));
                              setState(() {
                                  _validate = true;
                                });
                              }
                            if (img1 == null) {
                            setState(() {
                              _error = "Must Select Your Property Image";
                              _visible = true;
                            });
                          }
                   
                          },
                        ),
                      ),
                      //   SizedBox(height: 60.0,),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

String validateMobile(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Mobile is Required";
  } else if (value.length != 10) {
    return "Mobile number must 10 digits";
  } else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
