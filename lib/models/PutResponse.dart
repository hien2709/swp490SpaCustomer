// To parse this JSON data, do
//
//     final putResponse = putResponseFromJson(jsonString);

import 'dart:convert';

PutResponse putResponseFromJson(String str) => PutResponse.fromJson(json.decode(str));

String putResponseToJson(PutResponse data) => json.encode(data.toJson());

class PutResponse {
  PutResponse({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  String data;

  factory PutResponse.fromJson(Map<String, dynamic> json) => PutResponse(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : data,
  };
}
