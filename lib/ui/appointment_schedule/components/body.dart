import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/models/CustomerSchedule.dart';
import 'package:spa_customer/services/BookingDetailServices.dart';
import 'package:spa_customer/services/CustomerScheduleSerivces.dart';
import 'package:spa_customer/ui/one_step_process/one_step_process.dart';
import 'package:spa_customer/ui/process_detail/process_detail_screen.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CustomerSchedule _customerSchedule;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    CustomerScheduleServices.getCustomerSchedule().then((value) =>
    {
      setState(() {
        _customerSchedule = value;
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
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ...List.generate(
                _customerSchedule.data.length,
                    (index) =>
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: SvgPicture.asset(
                                    "assets/icons/schedule.svg"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(MyHelper.getUserDate(_customerSchedule
                                  .data[index].dateBooking))
                            ],
                          ),
                          Divider(
                            height: 10,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                              _customerSchedule
                                  .data[index].bookingDetailSteps.length,
                                  (index2) =>
                                  GestureDetector(
                                    onTap: () {
                                      _customerSchedule.data[index].bookingDetailSteps[index2].treatmentService!=null?
                                      _customerSchedule.data[index].bookingDetailSteps[index2].treatmentService.spaService.type == "ONESTEP"
                                          ? Navigator.push(context, MaterialPageRoute(builder: (context) => OneStepProcessScreen(bookingDetailId: _customerSchedule.data[index].bookingDetailSteps[index2].bookingDetail.id)),)
                                          : {
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
                                        ),
                                        BookingDetailServices.getBookingDetailById(_customerSchedule.data[index].bookingDetailSteps[index2].bookingDetail.id).then((value) =>
                                        {
                                          setState(() {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerProcessDetail(processDetail: value.data,)),
                                            );
                                          })
                                        })
                                      } : {
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
                                        ),
                                        BookingDetailServices.getBookingDetailById(_customerSchedule.data[index].bookingDetailSteps[index2].bookingDetail.id).then((value) =>
                                        {
                                          setState(() {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerProcessDetail(processDetail: value.data,)),
                                            );
                                          })
                                        })
                                      };
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      width: double.infinity,
                                      height: 110,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: kGreen,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 4,
                                                    horizontal: 10),
                                                child: Text(
                                                  _customerSchedule
                                                      .data[index]
                                                      .bookingDetailSteps[
                                                  index2]
                                                      .startTime
                                                      .substring(0, 5),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                              width: 10,
                                              color: Colors.grey,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    _customerSchedule.data[index].bookingDetailSteps[index2].treatmentService == null
                                                        ? "Tư vấn"
                                                        : _customerSchedule.data[index].bookingDetailSteps[index2].treatmentService.spaService
                                                    .type == "MORESTEP" ? _customerSchedule.data[index].bookingDetailSteps[index2].treatmentService.spaService.name :_customerSchedule.data[index].bookingDetailSteps[index2].bookingDetail.spaPackage.name,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.8)),
                                                  ),
                                                  Text(_customerSchedule
                                                      .data[index]
                                                      .bookingDetailSteps[
                                                  index2]
                                                      .bookingDetail
                                                      .booking
                                                      .spa
                                                      .name),
                                                  Text(_customerSchedule
                                                      .data[index]
                                                      .bookingDetailSteps[
                                                  index2].bookingDetail.booking.spa.street +" "+
                                                      _customerSchedule.data[index].bookingDetailSteps[index2].bookingDetail.booking.spa.district +" "+
                                                      _customerSchedule.data[index].bookingDetailSteps[index2].bookingDetail.booking.spa.city),
                                                  Text(_customerSchedule.data[index].bookingDetailSteps[index2].treatmentService == null
                                                      ?
                                                  _customerSchedule.data[index].bookingDetailSteps[index2].consultant == null ?"Chưa có tư vấn viên"

                                                  :_customerSchedule.data[index].bookingDetailSteps[index2].consultant.user.fullname
                                                      : _customerSchedule.data[index].bookingDetailSteps[index2].staff == null
                                                      ? "Chưa có nhân viên"
                                                      : _customerSchedule
                                                      .data[index]
                                                      .bookingDetailSteps[
                                                  index2]
                                                      .staff
                                                      .user
                                                      .fullname)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
