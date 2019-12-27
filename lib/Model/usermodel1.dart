/*class User {
  
  String key;
  String nameformlogin, country, email;
  String verifiedphone, idverification;
  //Host host;
  final List host;
    var list1;
  //User_Reservation reservation;
  User(User user, {
   //  this.key,
      this.nameformlogin,
      this.country,
      this.email,
      this.verifiedphone,
      this.idverification,
      this.host,
      //this.reservation
      });

  //User.fromJson(jsonResponse);
      //print("${widget.nameformlogin}");
         //    list1 = parsedJson['host'];

  factory User.fromJson(Map<String, dynamic> parsedJson) {
       var list = parsedJson['host'] as List;
    print(list.runtimeType);
    List<Host> hostList = list.map((i) => Host.fromJson(i)).toList();
    return new User(
        nameformlogin: parsedJson["nameformlogin"],
        country: parsedJson["country"],
        email: parsedJson["email"],
        verifiedphone: parsedJson["verifiedphone"],
        idverification: parsedJson["idverification"],
        host: hostList);
       
  }
 
}
 class Host{
 
String propertiesname, role;
  Host({this.propertiesname, this.role});
  factory Host.fromJson(Map<String, dynamic> parsedJson) {
  
    return new Host(
        propertiesname: parsedJson['propertiesname'], role: parsedJson['role']);
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
