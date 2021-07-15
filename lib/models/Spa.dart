// To parse this JSON data, do
//
//     final spa = spaFromJson(jsonString);

import 'dart:convert';

Spa spaFromJson(String str) => Spa.fromJson(json.decode(str));

String spaToJson(Spa data) => json.encode(data.toJson());

class Spa {
  Spa({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<SpaInstance> data;
  Paging paging;

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<SpaInstance>.from(json["data"].map((x) => SpaInstance.fromJson(x))),
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging == null ? null : paging.toJson(),
  };
}

class SpaInstance {
  SpaInstance({
    this.id,
    this.name,
    this.image,
    this.street,
    this.district,
    this.city,
    this.latitude,
    this.longtitude,
    this.createBy,
    this.createTime,
    this.status,
  });

  int id;
  String name;
  dynamic image;
  String street;
  String district;
  String city;
  String latitude;
  String longtitude;
  String createBy;
  DateTime createTime;
  String status;

  factory SpaInstance.fromJson(Map<String, dynamic> json) => SpaInstance(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"],
    street: json["street"] == null ? null : json["street"],
    district: json["district"] == null ? null : json["district"],
    city: json["city"] == null ? null : json["city"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longtitude: json["longtitude"] == null ? null : json["longtitude"],
    createBy: json["create_by"] == null ? null : json["create_by"],
    createTime: json["create_time"] == null ? null : DateTime.parse(json["create_time"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image,
    "street": street == null ? null : street,
    "district": district == null ? null : district,
    "city": city == null ? null : city,
    "latitude": latitude == null ? null : latitude,
    "longtitude": longtitude == null ? null : longtitude,
    "create_by": createBy == null ? null : createBy,
    "create_time": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "status": status == null ? null : status,
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
    page: json["page"] == null ? null : json["page"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    itemPerPage: json["itemPerPage"] == null ? null : json["itemPerPage"],
    totalItem: json["totalItem"] == null ? null : json["totalItem"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "totalPage": totalPage == null ? null : totalPage,
    "itemPerPage": itemPerPage == null ? null : itemPerPage,
    "totalItem": totalItem == null ? null : totalItem,
  };
}
