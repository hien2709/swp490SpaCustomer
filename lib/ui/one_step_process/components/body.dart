import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/services/BookingDetailServices.dart';

class OneStepProcessBody extends StatefulWidget {
  const OneStepProcessBody({Key key, this.bookingDetailId}) : super(key: key);
  final int bookingDetailId;

  @override
  _OneStepProcessBodyState createState() => _OneStepProcessBodyState();
}

class _OneStepProcessBodyState extends State<OneStepProcessBody> {
  BookingDetailResponse _bookingDetail;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    BookingDetailServices.getBookingDetailById(widget.bookingDetailId)
        .then((value) => {
              setState(() {
                _bookingDetail = value;
                _loading = false;
              })
            });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            child: Lottie.asset("assets/lottie/loading.json"),
          )
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  TimeSection(),
                  SizedBox(
                    height: 20,
                  ),
                  SpaSection(),
                  SizedBox(
                    height: 20,
                  ),
                  StaffSection(),
                  SizedBox(
                    height: 20,
                  ),
                  ServiceSection(),
                ],
              ),
            ),
          );
  }

  Container TimeSection() {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: kBlue),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Icon(
                Icons.access_time,
                size: 50,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${_bookingDetail.data.bookingDetailSteps[0].startTime.substring(0, 5)} | ${MyHelper.getUserDate(_bookingDetail.data.bookingDetailSteps[0].dateBooking)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "Theo dõi lịch để không bị lỡ hẹn với spa của bạn",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container StaffSection() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            size: 24,
            color: kPrimaryColor,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  Thông tin chuyên viên",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Text(
                    "${_bookingDetail.data.bookingDetailSteps[0].staff == null ? "Chưa có nhân viên" : "Tên:" + _bookingDetail.data.bookingDetailSteps[0].staff.user.fullname}"),
                _bookingDetail.data.bookingDetailSteps[0].staff != null
                    ? Text(
                        "Sđt: ${_bookingDetail.data.bookingDetailSteps[0].staff.user.phone}")
                    : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container SpaSection() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/herbal-spa-treatment-leaves.svg",
            width: 24,
            height: 24,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  Thông tin spa",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("Tên chi nhánh: "), Text("Địa chỉ:")],
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_bookingDetail.data.booking.spa.name),
                          Text(_bookingDetail.data.booking.spa.street +
                              " " +
                              _bookingDetail.data.booking.spa.district +
                              "" +
                              _bookingDetail.data.booking.spa.city),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container ServiceSection() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/process.svg",
            color: kPrimaryColor,
            width: 24,
            height: 24,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  Chi tiết dịch vụ",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Text(
                  "Dịch vụ ${_bookingDetail.data.spaPackage.name}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    _bookingDetail.data.bookingDetailSteps.length,
                    (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bước ${index + 1}: ${_bookingDetail.data.bookingDetailSteps[index].treatmentService.spaService.name}",
                              style: TextStyle(fontSize: 18, color: kGreen),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              height: 120,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 90,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        child: Image.network(
                                          _bookingDetail
                                              .data
                                              .bookingDetailSteps[index]
                                              .treatmentService
                                              .spaService
                                              .image,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _bookingDetail
                                                .data
                                                .bookingDetailSteps[index]
                                                .treatmentService
                                                .spaService
                                                .description,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ))
              ],
            ),
          )
        ],
      ),
    );
  }
}