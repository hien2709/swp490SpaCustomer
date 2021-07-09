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
    code: json["code"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.customType,
    this.user,
  });

  int id;
  String customType;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    customType: json["customType"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customType": customType,
    "user": user.toJson(),
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
    this.address,
    this.active,
  });

  int id;
  String fullname;
  String phone;
  String password;
  String gender;
  String birthdate;
  String email;
  String address;
  bool active;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    phone: json["phone"],
    password: json["password"],
    gender: json["gender"],
    birthdate: json["birthdate"],
    email: json["email"],
    address: json["address"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone": phone,
    "password": password,
    "gender": gender,
    "birthdate": birthdate,
    "email": email,
    "address": address,
    "active": active,
  };
}
