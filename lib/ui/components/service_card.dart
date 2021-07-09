import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Package.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key key,
    @required List<Datum> services,
    this.width = 140,
    this.aspectRatio = 1.02,
    @required this.service,
    @required this.press,
  })  ;

  final double width, aspectRatio;
  final Datum service;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: service.image == null
                      ? Image.asset("assets/images/Splash_1.PNG", fit: BoxFit.cover,)
                      : Image.network(service.image, fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 5),
              service == null
                  ? Text("...")
                  : Text(
                      service.name,
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
