

class Reservation {
  String reservation, primaryguest, addtionalguest;
  String checkIndate, checkoutdate;
  bool idverification, payment;
  VerifiedPhone verifiedPhone;
  Reservation(
      {this.reservation,
      this.primaryguest,
      this.addtionalguest,
      this.checkIndate,
      this.checkoutdate,
      this.idverification,
      this.payment,
      this.verifiedPhone});
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return new Reservation(
        reservation: json["reservation"],
        primaryguest: json["primaryguest"],
        addtionalguest: json["addtionalguest"],
        checkIndate: json["checkIndate"],
        checkoutdate: json["checkoutdate"],
        idverification: json["idverification"],
        payment: json["payment"],
        verifiedPhone: VerifiedPhone.fromJson(json["verifiedPhone"]));
  }
}

class VerifiedPhone {
  String verifiedphone, user;
  VerifiedPhone({this.verifiedphone, this.user});
  factory VerifiedPhone.fromJson(Map<String, dynamic> json) {
    return new VerifiedPhone(
        verifiedphone: json['verifiedphone'], user: json['user']);
  }
}
