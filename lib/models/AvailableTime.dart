// To parse this JSON data, do
//
//     final availableTime = availableTimeFromJson(jsonString);

import 'dart:convert';

AvailableTime availableTimeFromJson(String str) => AvailableTime.fromJson(json.decode(str));

String availableTimeToJson(AvailableTime data) => json.encode(data.toJson());

class AvailableTime {
  AvailableTime({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<String> data;
  Paging paging;

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
    code: json["code"],
    status: json["status"],
    data: List<String>.from(json["data"].map((x) => x)),
    paging: Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x)),
    "paging": paging.toJson(),
  };
}

class Paging {
  Paging({
    this.page,
    this.totalPage,
    this.itemPerPage,
    this.totalItem,
  });

  int page;
  int totalPage;
  int itemPerPage;
  int totalItem;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    page: json["page"],
    totalPage: json["totalPage"],
    itemPerPage: json["itemPerPage"],
    totalItem: json["totalItem"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "totalPage": totalPage,
    "itemPerPage": itemPerPage,
    "totalItem": totalItem,
  };
}
