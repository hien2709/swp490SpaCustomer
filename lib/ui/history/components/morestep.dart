import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/FinishedBookingDetail.dart';
import 'package:spa_customer/services/BookingDetailServices.dart';
import 'package:spa_customer/ui/history/components/FinishedProcessItem.dart';
import 'package:spa_customer/ui/process_detail/process_detail_screen.dart';

class MoreStepHistory extends StatefulWidget {
  const MoreStepHistory({Key key}) : super(key: key);

  @override
  _MoreStepHistoryState createState() => _MoreStepHistoryState();
}

class _MoreStepHistoryState extends State<MoreStepHistory> {
  FinishedBookingDetail _bookingDetail;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    super.initState();
    BookingDetailServices.getAllFinishBookingDetailMoreStepByCustomerId()
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
                    Icon(Icons.history,size: 100, color: kTextColor,),
                    Text("Không có dịch vụ đã hoàn thành")
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                          _bookingDetail.data.length,
                          (index) => FinishedProcessItem(
                              processItem: _bookingDetail.data[index],
                              press: () {
                                showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80),
                                      child: Dialog(
                                        child: Container(
                                          height: 150,
                                          child: Lottie.asset(
                                              "assets/lottie/circle_loading.json"),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                BookingDetailServices.getBookingDetailById(
                                        _bookingDetail.data[index].id)
                                    .then((value) => {
                                          setState(() {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerProcessDetail(
                                                        processDetail:
                                                            value.data,
                                                      )),
                                            );
                                          })
                                        });
                              }))
                    ],
                  ),
                ),
              );
  }
}
