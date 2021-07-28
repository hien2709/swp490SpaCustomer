// To parse this JSON data, do
//
//     final notificationCustomer = notificationCustomerFromJson(jsonString);

import 'dart:convert';

NotificationCustomer notificationCustomerFromJson(String str) => NotificationCustomer.fromJson(json.decode(str));

String notificationCustomerToJson(NotificationCustomer data) => json.encode(data.toJson());

class NotificationCustomer {
  NotificationCustomer({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  List<Datum> data;

  factory NotificationCustomer.fromJson(Map<String, dynamic> json) => NotificationCustomer(
    code: json["code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.type,
    this.data,
    this.message,
    this.role,
    this.user,
  });

  int id;
  String title;
  String type;
  String data;
  String message;
  String role;
  User user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    data: json["data"],
    message: json["message"],
    role: json["role"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "data": data,
    "message": message,
    "role": role,
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
  String image;
  String address;
  bool active;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    phone: json["phone"],
    password: json["password"],
    gender: json["gender"],
    birthdate: DateTime.parse(json["birthdate"]),
    email: json["email"],
    image: json["image"],
    address: json["address"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone": phone,
    "password": password,
    "gender": gender,
    "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "email": email,
    "image": image,
    "address": address,
    "active": active,
  };
}
