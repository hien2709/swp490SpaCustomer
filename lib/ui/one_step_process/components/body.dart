import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/services/BookingDetailServices.dart';
import 'package:spa_customer/services/GeneralServices.dart';
import 'package:spa_customer/ui/booking/components/body.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

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
    super.initState();
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
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  _bookingDetail.data.statusBooking == "FINISH"?
                      FinishStatusSection()
                  :TimeSection(),
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

                  if (_bookingDetail.data.bookingDetailSteps[0].rating != null)
                    _bookingDetail.data.bookingDetailSteps[0].rating.rate == null &&_bookingDetail.data.statusBooking == "FINISH"
                        ? DefaultButton(
                            press: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (builder) {
                                    return RatingDialog(
                                        title: "????nh gi?? d???ch v???",
                                        image: Icon(
                                          Icons.star_rate,
                                          color: Colors.amberAccent,
                                          size: 100,
                                        ),
                                        message:
                                            "B???n c?? h??i l??ng v??? d???ch v??? kh??ng?",
                                        commentHint: "nh???n x??t c???a b???n",
                                        submitButton: "G???i",
                                        onSubmitted: (response) {
                                          print("rating: " +
                                              response.rating.toString());
                                          print("comment: " + response.comment);
                                          showDialog(
                                            context: context,
                                            builder: (builder) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                          GeneralServices.editRating(
                                                  _bookingDetail
                                                      .data
                                                      .bookingDetailSteps[0]
                                                      .staff
                                                      .user
                                                      .id,
                                                  _bookingDetail
                                                      .data
                                                      .bookingDetailSteps[0]
                                                      .rating
                                                      .id,
                                                  response.comment,
                                                  response.rating.toDouble())
                                              .then((value) => {
                                                    value.code == 200
                                                        ? showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return MyCustomDialog(
                                                                height: 250,
                                                                press: () {
                                                                  Navigator.pop(context);
                                                                  Navigator.pop(context);
                                                                  setState(() {
                                                                    _loading = true;
                                                                    BookingDetailServices.getBookingDetailById(widget.bookingDetailId)
                                                                        .then((value) => {
                                                                      setState(() {
                                                                        _bookingDetail = value;
                                                                        _loading = false;
                                                                      })
                                                                    });
                                                                  });
                                                                },
                                                                title:
                                                                    "Th??nh C??ng !",
                                                                description:
                                                                    "????nh gi?? d???ch v??? th??nh c??ng",
                                                                buttonTitle:
                                                                    "Quay v???",
                                                                lottie:
                                                                    "assets/lottie/success.json",
                                                              );
                                                            },
                                                          )
                                                        : showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return MyCustomDialog(
                                                                height: 250,
                                                                press: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                title:
                                                                    "Th???t b???i !",
                                                                description:
                                                                    value.data,
                                                                buttonTitle:
                                                                    "Tho??t",
                                                                lottie:
                                                                    "assets/lottie/fail.json",
                                                              );
                                                            },
                                                          )
                                                  });
                                        });
                                  });
                            },
                            text: "????nh gi?? d???ch v???",
                          )
                        : SizedBox()
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
                      "Theo d??i l???ch ????? kh??ng b??? l??? h???n v???i spa c???a b???n",
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
  Container FinishStatusSection() {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: kGreen),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Icon(
                Icons.check,
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
                      "D???ch v??? ???? ho??n th??nh!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "B???n c?? th??? ????nh gi?? d???ch v??? sau khi ???? ho??n t???t",
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
                  "  Th??ng tin chuy??n vi??n",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Text(
                    "${_bookingDetail.data.bookingDetailSteps[0].staff == null ? "Ch??a c?? nh??n vi??n" : "T??n:" + _bookingDetail.data.bookingDetailSteps[0].staff.user.fullname}"),
                _bookingDetail.data.bookingDetailSteps[0].staff != null
                    ? Text(
                        "S??t: ${_bookingDetail.data.bookingDetailSteps[0].staff.user.phone}")
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
                  "  Th??ng tin spa",
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
                      children: [Text("T??n chi nh??nh: "), Text("?????a ch???:")],
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
                  "  Chi ti???t d???ch v???",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Text(
                  "D???ch v??? ${_bookingDetail.data.spaPackage.name}",
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
                              "B?????c ${index + 1}: ${_bookingDetail.data.bookingDetailSteps[index].treatmentService.spaService.name}",
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
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
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
