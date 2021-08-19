import 'package:flutter/material.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/Spa.dart';
import 'package:spa_customer/models/SpaToShow.dart';
import 'package:spa_customer/ui/booking/components/body.dart';

class CustomerBookingScreen extends StatefulWidget {
  final PackageInstance package;
  final SpaToShow spa;
  const CustomerBookingScreen({Key key, this.package, this.spa}) : super(key: key);

  @override
  _CustomerBookingScreenState createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Đặt lịch hẹn",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black
          ),
        ),
      ),
      body: BookingBody(package: widget.package, isBookNow: true, spa: widget.spa,),
    );
  }
}
