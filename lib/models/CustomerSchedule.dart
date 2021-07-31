// To parse this JSON data, do
//
//     final customerSchedule = customerScheduleFromJson(jsonString);

import 'dart:convert';

CustomerSchedule customerScheduleFromJson(String str) => CustomerSchedule.fromJson(json.decode(str));

String customerScheduleToJson(CustomerSchedule data) => json.encode(data.toJson());

class CustomerSchedule {
  CustomerSchedule({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<Datum> data;
  Paging paging;

  factory CustomerSchedule.fromJson(Map<String, dynamic> json) => CustomerSchedule(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging == null ? null : paging.toJson(),
  };
}

class Datum {
  Datum({
    this.dateBooking,
    this.bookingDetailSteps,
  });

  DateTime dateBooking;
  List<BookingDetailStep> bookingDetailSteps;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dateBooking: json["dateBooking"] == null ? null : DateTime.parse(json["dateBooking"]),
    bookingDetailSteps: json["bookingDetailSteps"] == null ? null : List<BookingDetailStep>.from(json["bookingDetailSteps"].map((x) => BookingDetailStep.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dateBooking": dateBooking == null ? null : "${dateBooking.year.toString().padLeft(4, '0')}-${dateBooking.month.toString().padLeft(2, '0')}-${dateBooking.day.toString().padLeft(2, '0')}",
    "bookingDetailSteps": bookingDetailSteps == null ? null : List<dynamic>.from(bookingDetailSteps.map((x) => x.toJson())),
  };
}

class BookingDetailStep {
  BookingDetailStep({
    this.id,
    this.dateBooking,
    this.startTime,
    this.endTime,
    this.bookingPrice,
    this.statusBooking,
    this.reason,
    this.isConsultation,
    this.treatmentService,
    this.staff,
    this.consultant,
    this.bookingDetail,
    this.rating,
    this.consultationContent,
  });

  int id;
  DateTime dateBooking;
  String startTime;
  String endTime;
  double bookingPrice;
  String statusBooking;
  dynamic reason;
  String isConsultation;
  TreatmentService treatmentService;
  Consultant staff;
  Consultant consultant;
  BookingDetail bookingDetail;
  dynamic rating;
  ConsultationContent consultationContent;

  factory BookingDetailStep.fromJson(Map<String, dynamic> json) => BookingDetailStep(
    id: json["id"] == null ? null : json["id"],
    dateBooking: json["dateBooking"] == null ? null : DateTime.parse(json["dateBooking"]),
    startTime: json["startTime"] == null ? null : json["startTime"],
    endTime: json["endTime"] == null ? null : json["endTime"],
    bookingPrice: json["bookingPrice"] == null ? null : json["bookingPrice"],
    statusBooking: json["statusBooking"] == null ? null : json["statusBooking"],
    reason: json["reason"],
    isConsultation: json["isConsultation"] == null ? null : json["isConsultation"],
    treatmentService: json["treatmentService"] == null ? null : TreatmentService.fromJson(json["treatmentService"]),
    staff: json["staff"] == null ? null : Consultant.fromJson(json["staff"]),
    consultant: json["consultant"] == null ? null : Consultant.fromJson(json["consultant"]),
    bookingDetail: json["bookingDetail"] == null ? null : BookingDetail.fromJson(json["bookingDetail"]),
    rating: json["rating"],
    consultationContent: json["consultationContent"] == null ? null : ConsultationContent.fromJson(json["consultationContent"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "dateBooking": dateBooking == null ? null : "${dateBooking.year.toString().padLeft(4, '0')}-${dateBooking.month.toString().padLeft(2, '0')}-${dateBooking.day.toString().padLeft(2, '0')}",
    "startTime": startTime == null ? null : startTime,
    "endTime": endTime == null ? null : endTime,
    "bookingPrice": bookingPrice == null ? null : bookingPrice,
    "statusBooking": statusBooking == null ? null : statusBooking,
    "reason": reason,
    "isConsultation": isConsultation == null ? null : isConsultation,
    "treatmentService": treatmentService == null ? null : treatmentService.toJson(),
    "staff": staff == null ? null : staff.toJson(),
    "consultant": consultant == null ? null : consultant.toJson(),
    "bookingDetail": bookingDetail == null ? null : bookingDetail.toJson(),
    "rating": rating,
    "consultationContent": consultationContent == null ? null : consultationContent.toJson(),
  };
}

class BookingDetail {
  BookingDetail({
    this.id,
    this.totalTime,
    this.type,
    this.totalPrice,
    this.statusBooking,
    this.booking,
    this.spaTreatment,
    this.spaPackage,
  });

  int id;
  int totalTime;
  String type;
  double totalPrice;
  String statusBooking;
  Booking booking;
  SpaTreatment spaTreatment;
  SpaPackage spaPackage;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    id: json["id"] == null ? null : json["id"],
    totalTime: json["totalTime"] == null ? null : json["totalTime"],
    type: json["type"] == null ? null : json["type"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    statusBooking: json["statusBooking"] == null ? null : json["statusBooking"],
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
    spaTreatment: json["spaTreatment"] == null ? null : SpaTreatment.fromJson(json["spaTreatment"]),
    spaPackage: json["spaPackage"] == null ? null : SpaPackage.fromJson(json["spaPackage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "totalTime": totalTime == null ? null : totalTime,
    "type": type == null ? null : type,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "statusBooking": statusBooking == null ? null : statusBooking,
    "booking": booking == null ? null : booking.toJson(),
    "spaTreatment": spaTreatment == null ? null : spaTreatment.toJson(),
    "spaPackage": spaPackage == null ? null : spaPackage.toJson(),
  };
}

class Booking {
  Booking({
    this.id,
    this.totalPrice,
    this.totalTime,
    this.statusBooking,
    this.createTime,
    this.customer,
    this.spa,
  });

  int id;
  double totalPrice;
  int totalTime;
  String statusBooking;
  DateTime createTime;
  Customer customer;
  Spa spa;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"] == null ? null : json["id"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    totalTime: json["totalTime"] == null ? null : json["totalTime"],
    statusBooking: json["statusBooking"] == null ? null : json["statusBooking"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "totalTime": totalTime == null ? null : totalTime,
    "statusBooking": statusBooking == null ? null : statusBooking,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "customer": customer == null ? null : customer.toJson(),
    "spa": spa == null ? null : spa.toJson(),
  };
}

class Customer {
  Customer({
    this.id,
    this.customType,
    this.user,
    this.tokenFcm,
  });

  int id;
  String customType;
  User user;
  String tokenFcm;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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
  String image;
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
    image: json["image"] == null ? null : json["image"],
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
    "image": image == null ? null : image,
    "address": address == null ? null : address,
    "active": active == null ? null : active,
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
    this.phone,
    this.latitude,
    this.longitude,
    this.createBy,
    this.createTime,
    this.status,
  });

  int id;
  String name;
  String image;
  String street;
  String district;
  String city;
  String phone;
  String latitude;
  String longitude;
  String createBy;
  DateTime createTime;
  String status;

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    street: json["street"] == null ? null : json["street"],
    district: json["district"] == null ? null : json["district"],
    city: json["city"] == null ? null : json["city"],
    phone: json["phone"] == null ? null : json["phone"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    createBy: json["createBy"] == null ? null : json["createBy"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "street": street == null ? null : street,
    "district": district == null ? null : district,
    "city": city == null ? null : city,
    "phone": phone == null ? null : phone,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "createBy": createBy == null ? null : createBy,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "status": status == null ? null : status,
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
  Category category;

  factory SpaPackage.fromJson(Map<String, dynamic> json) => SpaPackage(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["create_by"] == null ? null : json["create_by"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "create_by": createBy == null ? null : createBy,
    "category": category == null ? null : category.toJson(),
  };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    icon: json["icon"] == null ? null : json["icon"],
    description: json["description"] == null ? null : json["description"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["createBy"] == null ? null : json["createBy"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "icon": icon == null ? null : icon,
    "description": description == null ? null : description,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy == null ? null : createBy,
    "status": status == null ? null : status,
  };
}

class SpaTreatment {
  SpaTreatment({
    this.id,
    this.name,
    this.description,
    this.totalPrice,
    this.totalTime,
    this.createTime,
    this.createBy,
    this.spaPackage,
  });

  int id;
  String name;
  String description;
  double totalPrice;
  int totalTime;
  DateTime createTime;
  int createBy;
  SpaPackage spaPackage;

  factory SpaTreatment.fromJson(Map<String, dynamic> json) => SpaTreatment(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    totalTime: json["totalTime"] == null ? null : json["totalTime"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["createBy"] == null ? null : json["createBy"],
    spaPackage: json["spaPackage"] == null ? null : SpaPackage.fromJson(json["spaPackage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "totalTime": totalTime == null ? null : totalTime,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy == null ? null : createBy,
    "spaPackage": spaPackage == null ? null : spaPackage.toJson(),
  };
}

class Consultant {
  Consultant({
    this.id,
    this.user,
    this.spa,
    this.tokenFcm,
    this.status,
  });

  int id;
  User user;
  Spa spa;
  String tokenFcm;
  String status;

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
    tokenFcm: json["tokenFCM"] == null ? null : json["tokenFCM"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user.toJson(),
    "spa": spa == null ? null : spa.toJson(),
    "tokenFCM": tokenFcm == null ? null : tokenFcm,
    "status": status == null ? null : status,
  };
}

class ConsultationContent {
  ConsultationContent({
    this.id,
    this.description,
    this.expectation,
    this.result,
    this.note,
  });

  int id;
  String description;
  dynamic expectation;
  dynamic result;
  dynamic note;

  factory ConsultationContent.fromJson(Map<String, dynamic> json) => ConsultationContent(
    id: json["id"] == null ? null : json["id"],
    description: json["description"] == null ? null : json["description"],
    expectation: json["expectation"],
    result: json["result"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "description": description == null ? null : description,
    "expectation": expectation,
    "result": result,
    "note": note,
  };
}

class TreatmentService {
  TreatmentService({
    this.id,
    this.ordinal,
    this.spaService,
  });

  int id;
  int ordinal;
  SpaService spaService;

  factory TreatmentService.fromJson(Map<String, dynamic> json) => TreatmentService(
    id: json["id"] == null ? null : json["id"],
    ordinal: json["ordinal"] == null ? null : json["ordinal"],
    spaService: json["spaService"] == null ? null : SpaService.fromJson(json["spaService"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ordinal": ordinal == null ? null : ordinal,
    "spaService": spaService == null ? null : spaService.toJson(),
  };
}

class SpaService {
  SpaService({
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

  factory SpaService.fromJson(Map<String, dynamic> json) => SpaService(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    status: json["status"] == null ? null : json["status"],
    type: json["type"] == null ? null : json["type"],
    durationMin: json["durationMin"] == null ? null : json["durationMin"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["createBy"] == null ? null : json["createBy"],
    spaPackages: json["spaPackages"] == null ? null : List<SpaPackage>.from(json["spaPackages"].map((x) => SpaPackage.fromJson(x))),
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
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy == null ? null : createBy,
    "spaPackages": spaPackages == null ? null : List<dynamic>.from(spaPackages.map((x) => x.toJson())),
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
