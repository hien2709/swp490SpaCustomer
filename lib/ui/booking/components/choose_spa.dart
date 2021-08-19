import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/Spa.dart';
import 'package:spa_customer/models/SpaToShow.dart';
import 'package:spa_customer/services/SpaServices.dart';
import 'package:spa_customer/ui/booking/customer_booking_screen.dart';
import 'package:spa_customer/ui/wish_list/wish_list_booking_screen.dart';

class ChooseSpaScreen extends StatefulWidget {
  final PackageInstance package;
  final bool isManyBooking;

  const ChooseSpaScreen({Key key, this.package, this.isManyBooking})
      : super(key: key);

  @override
  _ChooseSpaScreenState createState() => _ChooseSpaScreenState();
}

class _ChooseSpaScreenState extends State<ChooseSpaScreen> {
  bool _loading;
  Spa _spa;
  Position currentPosition;
  List<SpaToShow> listSpaAfterCaculateDistance = [];

  double coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        currentPosition = position;
        print('CURRENT POS: $currentPosition');
      });
    }).catchError((e) {
      print(e);
    });
  }

  caculateDistanceToDevice() async {
    for (int i = 0; i < _spa.data.length; i++) {
      double distance = coordinateDistance(
          double.parse("${currentPosition.latitude}"),
          double.tryParse("${currentPosition.longitude}"),
          double.tryParse("${_spa.data[i].latitude}"),
          double.tryParse("${_spa.data[i].longitude}"));
      int id = _spa.data[i].id;
      String name = _spa.data[i].name;
      String image = _spa.data[i].image;
      String street = _spa.data[i].street;
      String district = _spa.data[i].district;
      String city = _spa.data[i].city;
      String latitude = _spa.data[i].latitude;
      String longitude = _spa.data[i].longitude;
      String createBy = _spa.data[i].createBy;
      DateTime createTime = _spa.data[i].createTime;
      String status= _spa.data[i].status;
      listSpaAfterCaculateDistance.add(new SpaToShow(
        id: id,
        name: name,
        image: image,
        street: street,
        district: district,
        city: city,
        latitude: latitude,
        longitude: longitude,
        createBy: createBy,
        createTime: createTime,
        status: status,
        distance: distance,
      ));
    }
  }

  getListAscending() async {
    SpaToShow temp;
    for (int i = 0; i < listSpaAfterCaculateDistance.length - 1; i++) {
      for (int j = i + 1; j < listSpaAfterCaculateDistance.length; j++) {
        if (listSpaAfterCaculateDistance[i].distance >
            listSpaAfterCaculateDistance[j].distance) {
          temp = listSpaAfterCaculateDistance[i];
          listSpaAfterCaculateDistance[i] = listSpaAfterCaculateDistance[j];
          listSpaAfterCaculateDistance[j] = temp;
        }
      }
    }
    _loading = false;
  }

  getAllSpa() async{
    await SpaServices.getAllCategory().then((value) => {
          setState(() {
            _spa = value;
            _loading = false;
            print("Ten: ${_spa.data[0].name}" );
          })
        });
  }
  getData() async {
    await getCurrentLocation();
    await getAllSpa();
    await caculateDistanceToDevice();
    await getListAscending();
  }

  @override
  void initState() {
    _loading = true;
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Chọn Spa"),
      ),
      body: _loading
          ? Container(
              child: SpinKitWave(
                color: kPrimaryColor,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  ...List.generate(
                      listSpaAfterCaculateDistance.length,
                      (index) => Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 4,
                                  offset: Offset(4, 4), // Shadow position
                                ),
                              ],
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/herbal-spa-treatment-leaves.svg",
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              listSpaAfterCaculateDistance[index].name,
                                              style: TextStyle(
                                                  fontSize: 20, color: kGreen),
                                            ),
                                          ),
                                          Text(listSpaAfterCaculateDistance[index].distance.toStringAsFixed(2) + " km",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey.shade500
                                          ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              listSpaAfterCaculateDistance[index].street +
                                                  ", " +
                                                  listSpaAfterCaculateDistance[index].district +
                                                  ", " +
                                                  listSpaAfterCaculateDistance[index].city,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                widget.isManyBooking
                                                    ? WishListBookingScreen(
                                                        spa: listSpaAfterCaculateDistance[index],
                                                      )
                                                    : CustomerBookingScreen(
                                                        package: widget.package,
                                                        spa: listSpaAfterCaculateDistance[index],
                                                      )),
                                      );
                                    },
                                    child: Text(
                                      "Chọn",
                                      style: TextStyle(fontSize: 16),
                                    ))
                              ],
                            ),
                          )),
                ],
              )),
            ),
    );
  }
}
