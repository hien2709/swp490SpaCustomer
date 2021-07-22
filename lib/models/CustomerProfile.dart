// To parse this JSON data, do
//
//     final customerProfile = customerProfileFromJson(jsonString);

import 'dart:convert';

CustomerProfile customerProfileFromJson(String str) => CustomerProfile.fromJson(json.decode(str));

String customerProfileToJson(CustomerProfile data) => json.encode(data.toJson());

class CustomerProfile {
  CustomerProfile({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  Data data;

  factory CustomerProfile.fromJson(Map<String, dynamic> json) => CustomerProfile(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.customType,
    this.user,
    this.tokenFcm,
  });

  int id;
  String customType;
  User user;
  String tokenFcm;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    customType: json["customType"] == null ? null : json["customType"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    tokenFcm: json["tokenFCM"] == null ? null : json["tokenFCM"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "customType": customType == null ? null : customType,
    "user": user == null ? null : user.toJson(),
    "tokenFCM": tokenFcm == null ? null : tokenFcm,
  };
}

class User {
  User({
    this.id,
    this.fullname,
    this.phone,
    this.password,
    this.gender,
    this.birthdate,
    this.email,
    this.image,
    this.address,
    this.active,
  });

  int id;
  String fullname;
  String phone;
  String password;
  String gender;
  DateTime birthdate;
  String email;
  dynamic image;
  String address;
  bool active;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    phone: json["phone"] == null ? null : json["phone"],
    password: json["password"] == null ? null : json["password"],
    gender: json["gender"] == null ? null : json["gender"],
    birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
    email: json["email"] == null ? null : json["email"],
    image: json["image"],
    address: json["address"] == null ? null : json["address"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fullname": fullname == null ? null : fullname,
    "phone": phone == null ? null : phone,
    "password": password == null ? null : password,
    "gender": gender == null ? null : gender,
    "birthdate": birthdate == null ? null : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "email": email == null ? null : email,
    "image": image,
    "address": address == null ? null : address,
    "active": active == null ? null : active,
  };
}
