
class User {
  String key;
  //final List<Host> host;
 // String uid;
  String nameformlogin, phone, email;
  String verifiedphone, idverification;
  var list;
  User({
   // this.key,
    this.nameformlogin,
    this.phone,
    this.email
    //this.verifiedphone,
    //this.idverification,
    //this.host,
    //this.reservation
  });

    factory User.fromJson(Map<String, dynamic> json) {
    var list = json['host'] as List;
      //print(list.runtimeType);
      List<Host> hostList = list.map((i) => Host.fromJson(i)).toList();

    return new User(
        nameformlogin: json["nameformlogin"],
        phone: json["phone"],
        email: json["email"],
     //   verifiedphone: json["verifiedphone"],
      //  idverification: json["idverification"],
        //   reservation: User_Reservation.fromJson(json["reservation"]),
        //host: Host.fromJson(json["host"]
       // host: hostList
        );
  }
 
  toJson() {
    return {
        'name': nameformlogin,
        'county':phone,
        'email': email,
      //  'verifiedphone':verifiedphone,
       // 'idverification':idverification,
      //  'host':host
    };
      }
}
class Host {
  String propertiesname, role;
  Host({this.propertiesname, this.role});
  factory Host.fromJson(Map<String, dynamic> json) {
    return new Host(propertiesname: json['propertiesname'], role: json['role']);
  }
}
/*class User {
  String key;
  String nameformlogin, country, email;
  String verifiedphone, idverification;
  //Host host;
  final List<Host> host;
  // User_Reservation reservation;
  User({
    this.key,
    this.nameformlogin,
    this.country,
    this.email,
    this.verifiedphone,
    this.idverification,
    this.host,
    //this.reservation
  });
  //print("${widget.nameformlogin}");
  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['host'] as List;
    print(list.runtimeType);
    List<Host> hostList = list.map((i) => Host.fromJson(i)).toList();

    return new User(
        nameformlogin: json["nameformlogin"],
        country: json["country"],
        email: json["email"],
        verifiedphone: json["verifiedphone"],
        idverification: json["idverification"],
        //   reservation: User_Reservation.fromJson(json["reservation"]),
        //host: Host.fromJson(json["host"]
        host: hostList);
  }
  //String get name1 => nameformlogin;
  User.fromSnapshot(DataSnapshot snapshot)
      : //key = snapshot.key,
        nameformlogin = snapshot.value["name"],
        country = snapshot.value["country"],
        email = snapshot.value["email"],
      //  verifiedphone = snapshot.value["verifiedphone"],
        //idverification = snapshot.value["idverification"],
        host = snapshot.value["hostList"];
  toJson() {
    return {
      "name": nameformlogin,
      "country": country,
      "email": email,
      "verifiedphone": verifiedphone,
      "idverification": idverification,
      // "reservation": reservation,
      "host": host,
    };
  }
}*/

/*
 User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        //email = snapshot.value["${widget.email}"],
        //print("${data.email}");
        //email = "${data.email}",
        phone = snapshot.value["phone"];

  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
 */
/*class Host  {
  User_Property user_property;
  Host({this.user_property});
  factory Host.fromJson(Map<String, dynamic> json) {
    return new Host(
        user_property: User_Property.fromJson(json["user_property"]));
  }
}

class User_Property {
String propertiesname, role;
  User_Property({this.propertiesname, this.role});
  factory User_Property.fromJson(Map<String, dynamic> json) {
    return new User_Property(
        propertiesname: json['propertiesname'], role: json['role']);
  }
}*/

/*class User_Reservation {
  bool primary_guest, additional;
  User_Reservation({this.primary_guest, this.additional});
  factory User_Reservation.fromJson(Map<String, dynamic> json) {
    return new User_Reservation(
        primary_guest: json['primary_guest'], additional: json['additional']);
  }
}*/

/*import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String name;
  String phone;
  String email;

  //final Regist


erPage email;
  // In the constructor, require a Todo.
  //User(String s, {this.name, this.phone, this.email});
  //final RegisterPage email;
  //LoginPage({this.email});
  User(this.name, this.phone, this.email);

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        email = snapshot.value["email"],
        //email = ${email},
        phone = snapshot.value["phone"];

  toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}*/
 
