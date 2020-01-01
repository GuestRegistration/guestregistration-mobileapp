
class Property {
//String<Address> _address;
  //String address;

  //Property({this.address});
  //String id;

  String propertyname;
  String propertylogo;
  String email;
  //Address address;
  String phone;
  Team team;
  Property_Reservation reservation;
  Guestform guestform;
  Property(
      { //this.key,
      this.propertyname,
      this.propertylogo,
      this.email,
      this.phone,
    //  this.address,
      this.team,
      this.reservation,
      this.guestform});
  factory Property.fromJson(Map<String, dynamic> json) {
    return new Property(
        propertyname: json["propertyname"],
        propertylogo: json["propertylogo"],
        email: json["email"],
      //  address: Address.fromJson(json["address"]),
        phone: json["phone"],
        team: Team.fromJson(json["team"]),
        reservation: Property_Reservation.fromJson(json["reservation"]),
        guestform: Guestform.fromJson(json["guestform"]));
  }
}

class Address {
  String addressLine1, city, state;
  Address({
    this.addressLine1,
    this.city,
    this.state,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return new Address(
        addressLine1: json['address_line1'],
        city: json['city'],
        state: json['state']);
  }
}

class Team {
  List<String> team;
  Team({this.team});
  factory Team.fromJson(Map<String, dynamic> json) {
    return new Team(team: json['team']);
  }
}

class Property_Reservation {
  String reservation;
  Property_Reservation({this.reservation});
  factory Property_Reservation.fromJson(Map<String, dynamic> json) {
    return new Property_Reservation(reservation: json['reservation']);
  }
}

class Guestform {
  bool verifiedphone, idverification;
  Guestform({this.verifiedphone, this.idverification});
  factory Guestform.fromJson(Map<String, dynamic> json) {
    return new Guestform(
        verifiedphone: json['verifiedphone'],
        idverification: json['idverification']);
  }
}

/* String get propertyname => _propertyname;
  String get propertylogo => _propertylogo;
  String get email => _email;
  String get phone => _phone;
  String get address1 => address;
 // String<Address>  get address => _address;
  String get team => _team;  
  String get reservation => _reservation;  
  String get guestform => _guestform;
  String get id => _id;*/

/*Property.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _propertyname = snapshot.value['propertyname'];
    _propertylogo = snapshot.value['propertylogo'];
    _email = snapshot.value['email'];
    _phone = snapshot.value['phone'];
    address = snapshot.value['address'];
    _team = snapshot.value['team'];
    _reservation = snapshot.value['reservation'];
    _guestform = snapshot.value['guestform'];
  }*/
