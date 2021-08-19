import 'package:geolocator/geolocator.dart';

class SpaToShow{
  SpaToShow({
    this.id,
    this.name,
    this.image,
    this.street,
    this.district,
    this.city,
    this.latitude,
    this.longitude,
    this.createBy,
    this.createTime,
    this.status,
    this.distance,
  });

  int id;
  String name;
  dynamic image;
  String street;
  String district;
  String city;
  String latitude;
  String longitude;
  String createBy;
  DateTime createTime;
  String status;
  double distance;
}
