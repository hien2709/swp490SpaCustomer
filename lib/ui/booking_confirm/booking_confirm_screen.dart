import 'package:flutter/material.dart';
import 'package:spa_customer/models/RequestBookingDetail.dart';
import 'package:spa_customer/ui/booking_confirm/components/body.dart';

class BookingConfirmScreen extends StatefulWidget {
  @required final List<RequestBookingDetail> listRequestBooking;
  const BookingConfirmScreen({Key key, this.listRequestBooking}) : super(key: key);

  @override
  _BookingConfirmScreenState createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đặt lịch"),
      ),
      body: Body(listRequestBooking: widget.listRequestBooking,),
    );
  }
}
