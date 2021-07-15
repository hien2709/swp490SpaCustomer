// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';

List<PackageInstance> cartItemFromJson(String str) =>
    List<PackageInstance>.from(json.decode(str).map((x) => PackageInstance.fromJson(x)));

String cartItemToJson(List<PackageInstance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  List<PackageInstance> data;
  Paging paging;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<PackageInstance>.from(json["data"].map((x) => PackageInstance.fromJson(x))),
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "paging": paging == null ? null : paging.toJson(),
      };
}

class PackageInstance {
  PackageInstance({
    this.id,
    this.name,
    this.description,
    this.image,
    this.type,
    this.status,
    this.createTime,
    this.createBy,
    this.categoryId,
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
  int totalTime;
  List<Service> services;

  factory PackageInstance.fromJson(Map<String, dynamic> json) => PackageInstance(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        createTime: json["create_time"] == null
            ? null
            : DateTime.parse(json["create_time"]),
        createBy: json["create_by"] == null ? null : json["create_by"],
        categoryId: json["category_id"] == null
            ? null
            : CategoryOfPackage.fromJson(json["category_id"]),
        totalTime: json["total_time"] == null ? null : json["total_time"],
        services: json["services"] == null
            ? null
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "create_time": createTime == null
            ? null
            : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
        "create_by": createBy == null ? null : createBy,
        "category_id": categoryId == null ? null : categoryId.toJson(),
        "total_time": totalTime == null ? null : totalTime,
        "services": services == null
            ? null
            : List<dynamic>.from(services.map((x) => x.toJson())),
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
  });

  int id;
  String name;
  String icon;
  String description;
  DateTime createTime;
  int createBy;
  String status;

  factory CategoryOfPackage.fromJson(Map<String, dynamic> json) => CategoryOfPackage(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
        description: json["description"] == null ? null : json["description"],
        createTime: json["createTime"] == null
            ? null
            : DateTime.parse(json["createTime"]),
        createBy: json["createBy"] == null ? null : json["createBy"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
        "description": description == null ? null : description,
        "createTime": createTime == null
            ? null
            : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
        "createBy": createBy == null ? null : createBy,
        "status": status == null ? null : status,
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
  List<SpaPackage> spaPackages;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        durationMin: json["durationMin"] == null ? null : json["durationMin"],
        createTime: json["createTime"] == null
            ? null
            : DateTime.parse(json["createTime"]),
        createBy: json["createBy"] == null ? null : json["createBy"],
        spaPackages: json["spaPackages"] == null
            ? null
            : List<SpaPackage>.from(
                json["spaPackages"].map((x) => SpaPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "durationMin": durationMin == null ? null : durationMin,
        "createTime": createTime == null
            ? null
            : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
        "createBy": createBy == null ? null : createBy,
        "spaPackages": spaPackages == null
            ? null
            : List<dynamic>.from(spaPackages.map((x) => x.toJson())),
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

  factory SpaPackage.fromJson(Map<String, dynamic> json) => SpaPackage(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        createTime: json["createTime"] == null
            ? null
            : DateTime.parse(json["createTime"]),
        createBy: json["create_by"] == null ? null : json["create_by"],
        category: json["category"] == null
            ? null
            : CategoryOfPackage.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "createTime": createTime == null
            ? null
            : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
        "create_by": createBy == null ? null : createBy,
        "category": category == null ? null : category.toJson(),
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
