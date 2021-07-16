import 'package:geolocator/geolocator.dart';

class SpaToShow{
  String name;
  String street;
  double distance;
  String image;
  String latitude;
  String longtitude;

  SpaToShow(
      {this.name,
      this.street,
      this.distance,
      this.image,
      this.latitude,
      this.longtitude});
}
