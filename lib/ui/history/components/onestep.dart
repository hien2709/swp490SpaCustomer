import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/FinishedBookingDetail.dart';
import 'package:spa_customer/services/BookingDetailServices.dart';
import 'package:spa_customer/ui/history/components/FinishedProcessItem.dart';
import 'package:spa_customer/ui/one_step_process/one_step_process.dart';

class OneStepHistory extends StatefulWidget {
  const OneStepHistory({Key key}) : super(key: key);

  @override
  _OneStepHistoryState createState() => _OneStepHistoryState();
}

class _OneStepHistoryState extends State<OneStepHistory> {
  FinishedBookingDetail _bookingDetail;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    super.initState();
    BookingDetailServices.getAllFinishBookingDetailOneStepByCustomerId()
        .then((value) => {
              setState(() {
                _bookingDetail = value;
                _loading = false;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            child: SpinKitWave(
              color: kPrimaryColor,
              size: 50,
            ),
          )
        : _bookingDetail.data.length == 0
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 100,
                      color: kTextColor,
                    ),
                    Text("Không có dịch vụ đã hoàn thành")
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...List.generate(
                          _bookingDetail.data.length,
                          (index) => FinishedProcessItem(
                              processItem: _bookingDetail.data[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OneStepProcessScreen(
                                              bookingDetailId: _bookingDetail
                                                  .data[index].id)),
                                );
                              }))
                    ],
                  ),
                ),
              );
  }
}
