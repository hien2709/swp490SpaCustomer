// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';
List<Datum> cartItemFromJson(String str) => List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));
String cartItemToJson(List<Datum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
Package packageFromJson(String str) => Package.fromJson(json.decode(str));

String packageToJson(Package data) => json.encode(data.toJson());

class Package {
  Package({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<Datum> data;
  Paging paging;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    code: json["code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paging: Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.image,
    this.type,
    this.status,
    this.createTime,
    this.createBy,
    this.categoryId,
    this.spaId,
    this.totalTime,
    this.services,
  });

  int id;
  String name;
  String description;
  String image;
  String type;
  String status;
  DateTime createTime;
  int createBy;
  CategoryOfPackage categoryId;
  Spa spaId;
  int totalTime;
  List<Service> services;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    type: json["type"],
    status: json["status"],
    createTime: DateTime.parse(json["create_time"]),
    createBy: json["create_by"],
    categoryId: CategoryOfPackage.fromJson(json["category_id"]),
    spaId: Spa.fromJson(json["spa_id"]),
    totalTime: json["total_time"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "type": type,
    "status": status,
    "create_time": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "create_by": createBy,
    "category_id": categoryId.toJson(),
    "spa_id": spaId.toJson(),
    "total_time": totalTime,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class CategoryOfPackage {
  CategoryOfPackage({
    this.id,
    this.name,
    this.icon,
    this.description,
    this.createTime,
    this.createBy,
    this.status,
    this.spa,
  });

  int id;
  String name;
  String icon;
  String description;
  DateTime createTime;
  int createBy;
  String status;
  Spa spa;

  factory CategoryOfPackage.fromJson(Map<String, dynamic> json) => CategoryOfPackage(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    status: json["status"],
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "status": status,
    "spa": spa.toJson(),
  };
}

class Spa {
  Spa({
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

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    street: json["street"],
    district: json["district"],
    city: json["city"],
    latitude: json["latitude"],
    longtitude: json["longtitude"],
    createBy: json["createBy"],
    createTime: DateTime.parse(json["createTime"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "street": street,
    "district": district,
    "city": city,
    "latitude": latitude,
    "longtitude": longtitude,
    "createBy": createBy,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}

class Service {
  Service({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
    this.status,
    this.type,
    this.durationMin,
    this.createTime,
    this.createBy,
    this.spa,
    this.spaPackages,
  });

  int id;
  String name;
  String image;
  String description;
  double price;
  String status;
  String type;
  int durationMin;
  DateTime createTime;
  String createBy;
  Spa spa;
  List<SpaPackage> spaPackages;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    price: json["price"],
    status: json["status"],
    type: json["type"],
    durationMin: json["durationMin"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    spa: Spa.fromJson(json["spa"]),
    spaPackages: List<SpaPackage>.from(json["spaPackages"].map((x) => SpaPackage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "price": price,
    "status": status,
    "type": type,
    "durationMin": durationMin,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "spa": spa.toJson(),
    "spaPackages": List<dynamic>.from(spaPackages.map((x) => x.toJson())),
  };
}

class SpaPackage {
  SpaPackage({
    this.id,
    this.name,
    this.description,
    this.image,
    this.type,
    this.status,
    this.createTime,
    this.createBy,
    this.category,
    this.spa,
  });

  int id;
  String name;
  String description;
  String image;
  String type;
  String status;
  DateTime createTime;
  int createBy;
  CategoryOfPackage category;
  Spa spa;

  factory SpaPackage.fromJson(Map<String, dynamic> json) => SpaPackage(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    type: json["type"],
    status: json["status"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["create_by"],
    category: CategoryOfPackage.fromJson(json["category"]),
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "type": type,
    "status": status,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "create_by": createBy,
    "category": category.toJson(),
    "spa": spa.toJson(),
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
