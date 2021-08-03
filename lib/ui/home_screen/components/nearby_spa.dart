import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/AllSpa.dart';
import 'package:spa_customer/models/SpaToShow.dart';
import 'package:spa_customer/services/CustomerProfileServices.dart';

import 'MapUtils.dart';

class NearBySpa extends StatefulWidget {
  @override
  _NearBySpaState createState() => _NearBySpaState();
}

class _NearBySpaState extends State<NearBySpa> {
  AllSpa allSpa;
  Position currentPosition;
  List<SpaToShow> listSpaAfterCaculateDistance = [];
  bool loading = true;

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

  getAllSpa() async {
    await CustomerProfileServices.getAllSpa().then((spa) => {
          setState(() {
            allSpa = spa;
            print("Lat: " + allSpa.data[0].latitude);
          })
        });
  }

  double coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  caculateDistanceToDevice() async {
    for (int i = 0; i < allSpa.data.length; i++) {
      double distance = coordinateDistance(
          double.parse("${currentPosition.latitude}"),
          double.tryParse("${currentPosition.longitude}"),
          double.tryParse("${allSpa.data[i].latitude}"),
          double.tryParse("${allSpa.data[i].longitude}"));
      String street = allSpa.data[i].street;
      String image = allSpa.data[i].image;
      String name = allSpa.data[i].name;
      String latitude = allSpa.data[i].latitude;
      String longitude = allSpa.data[i].longitude;
      listSpaAfterCaculateDistance.add(new SpaToShow(
          name: name, street: street, distance: distance, image: image, latitude: latitude, longitude: longitude,));
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
    loading = false;
  }

  getData() async {
    await getCurrentLocation();
    await getAllSpa();
    await caculateDistanceToDevice();
    await getListAscending();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
            child: SpinKitWave(
          color: kPrimaryColor,
          size: 50,
        )),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              "Những Spa gần bạn",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listSpaAfterCaculateDistance.length,
              itemBuilder: (context, index) {
                final spa = listSpaAfterCaculateDistance[index];

                return ListSpa(spa);
              }));
    }
  }

  ListSpa(SpaToShow spa) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                         spa.image == null ? "https://toplist.vn/images/800px/dang-ngoc-spa-149960.jpg" : spa.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          spa.name,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          spa.street,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade500),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Text(
                              spa.distance.toStringAsFixed(2) + " km",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade500),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                MapUtils.openMap(currentPosition.latitude,currentPosition.longitude,double.tryParse(spa.latitude),double.tryParse(spa.longitude));
                              },
                              child: Text(
                                "xem trên map",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
