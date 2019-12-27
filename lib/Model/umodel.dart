import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';

class User {
 DocumentReference reference;
  String key;
  String name;
  String phone;
  String email;
 // final Host host;
  //List<Host> host;
   Map host;
  User({this.name, this.phone, this.email,
  this.host
  }); 


   /*factory User.fromJson(Map<String, dynamic> json) {
     var list = json['host'] as List;
     // print(list.runtimeType);
      List<Host> hostList = list.map((i) => Host.fromJson(i)).toList();
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      //host: json['${'user.host[0].propertiesname'}'],
      host:  hostList,
      //host: Host.fromJson(json['propertiesname']);
      //host: Host.fromJson(json['propertiesname']),);
      //host: Host.fromJson(json['propertiesname']),
      //host:  parseHost(json)
       
      );
  }*/
    User.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map["name"];
    email = map["email"];
    phone = map["phone"];
    host = map["host"];

  }

 static List<Host> parseHost(hostJson) {   
    var list = hostJson['host'] as List;
    List<Host> hostList =
        list.map((data) => Host.fromJson(data)).toList();
    return hostList;
  } 
  User.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
      /*: key = snapshot.key,
        name = snapshot.value["name"],
        email = snapshot.value["email"],
        phone = snapshot.value["phone"],
        host = snapshot.value["host"];*/
        //host=snapshot.value["host"];
       // propertiesname = snapshot.value["propertiesname"],
        //role = snapshot.value["role"]; 
  

  toJson() {
    return {
     'name': name,
      'email': email,
      'phone': phone,
      'host': host
    };
  }
   
}
 

class Host {
  String propertiesname, role,key;
  Host({this.propertiesname, this.role,this.key});
  //String get _propertiesname => propertiesname;
  //String get _role => role;
  factory Host.fromJson(Map<String, dynamic> json) {
    return new Host(
      propertiesname: json['propertiesname'] ,
       role: json['role'] ,       
       );
  }
  //print("${widget.propertiesname}");
  
  /* Host.fromSnapshot(DataSnapshot snapshot)
      : 
        propertiesname = snapshot.value["propertiesname"],
        role = snapshot.value["role"];    */
  toJson() {
    return {
     "propertiesname": propertiesname,
      "role": role
      
    };
  }
  }
