import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/AvailableTime.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/RequestBookingDetail.dart';
import 'package:spa_customer/models/Spa.dart';
import 'package:spa_customer/services/AvailableTimeServices.dart';
import 'package:spa_customer/services/BookingServices.dart';
import 'package:spa_customer/size_config.dart';
import 'package:spa_customer/ui/booking/components/time_slot.dart';
import 'package:spa_customer/ui/booking_confirm/booking_confirm_screen.dart';
import 'package:spa_customer/ui/bottom_navigation/bottom_navigation.dart';
import 'package:spa_customer/ui/components/wrap_toggle_button.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

class BookingBody extends StatefulWidget {
  @override
  _BookingBodyState createState() => _BookingBodyState();

  @required
  final PackageInstance package;
  final SpaInstance spa;
  @required
  final bool isBookNow;
  final List<RequestBookingDetail> listRequestBookingDetail;

  const BookingBody(
      {Key key,
      @required this.package,
      @required this.isBookNow,
      this.listRequestBookingDetail,
      this.spa})
      : super(key: key);
}

class _BookingBodyState extends State<BookingBody> {
  int slotId;
  String requestDate;

  AvailableTime _availableTime;
  bool _loading;
  bool _loadingSlot = false;

  // TODO: implement initState
  int idButton;

  @override
  void initState() {
    super.initState();
    _loading = true;

    requestDate = MyHelper.getMachineDate(DateTime.now());
    AvailableTimeServices.getAvailableTimeForBooking(
            widget.package.id, requestDate, widget.spa.id)
        .then((availableTime) => {
              setState(() {
                _availableTime = availableTime;
                if (_availableTime.data != null) {
                  if (widget.listRequestBookingDetail != null) {
                    _availableTime = MyHelper.getAvailableTimeForCart(
                        availableTime,
                        widget.listRequestBookingDetail,
                        widget.package,
                        requestDate);
                  }
                }
                _loading = false;
                if (_availableTime.data != null) {
                  isSelected = List.generate(
                      _availableTime.data.length, (index) => false);
                }
              })
            });
  }

  List<bool> _selections = [true, false, false, false, false, false, false];
  List<bool> isSelected;

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
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   ServiceDetailScreen.routeName,
                    //   arguments:
                    //       ServiceDetailsArguments(service: widget.service),
                    // );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dịch vụ đã chọn",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ChoosenPackage(
                        package: widget.package,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "1.Chọn ngày",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ToggleButtons(
                          children: [
                            DateBox(
                              date: DateTime.now().add(Duration(days: 0)),
                              package: widget.package,
                            ),
                            DateBox(
                              date: DateTime.now().add(Duration(days: 1)),
                              package: widget.package,
                            ),
                            DateBox(
                              date: DateTime.now().add(Duration(days: 2)),
                              package: widget.package,
                            ),
                            DateBox(
                              date: DateTime.now().add(Duration(days: 3)),
                              package: widget.package,
                            ),
                            DateBox(
                              date: DateTime.now().add(Duration(days: 4)),
                              package: widget.package,
                            ),
                            DateBox(
                              date: DateTime.now().add(Duration(days: 5)),
                              package: widget.package,
                            ),
                            DateBox(
                              date: DateTime.now().add(Duration(days: 6)),
                              package: widget.package,
                            ),
                          ],
                          isSelected: _selections,
                          onPressed: (int index) {
                            setState(() {
                              print("loading ne");
                              _loadingSlot = true;
                              print("loading: ${_loadingSlot.toString()}");
                              for (int i = 0; i < _selections.length; i++) {
                                _selections[i] = (i == index);
                              }
                              String selectedDay = MyHelper.getMachineDate(
                                  DateTime.now().add(Duration(days: index)));
                              requestDate = selectedDay;
                              AvailableTimeServices.getAvailableTimeForBooking(
                                      widget.package.id,
                                      requestDate,
                                      widget.spa.id)
                                  .then((availableTime) => {
                                        setState(() {
                                          _availableTime = availableTime;
                                          if (_availableTime.data != null) {
                                            if (widget
                                                    .listRequestBookingDetail !=
                                                null) {
                                              _availableTime = MyHelper
                                                  .getAvailableTimeForCart(
                                                      availableTime,
                                                      widget
                                                          .listRequestBookingDetail,
                                                      widget.package,
                                                      requestDate);
                                            }
                                          }
                                          if (_availableTime.data != null) {
                                            isSelected = List.generate(
                                                _availableTime.data.length,
                                                (index) => false);
                                          }
                                          _loadingSlot = false;
                                          print(
                                              "loading: ${_loadingSlot.toString()}");
                                        })
                                      });
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "2.Chọn giờ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TimeBookingDescriptionBar(),
                      SizedBox(
                        height: 20,
                      ),
                      _availableTime.data != null
                          ? Container(
                              child: _loadingSlot
                                  ? Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: SpinKitWave(
                                        color: kPrimaryColor,
                                        size: 50,
                                      ),
                                    )
                                  : WrapToggleIconButtons(
                                      iconList: List.generate(
                                          _availableTime.data.length,
                                          (index) => TimeSlot()),
                                      isSelected: isSelected,
                                      availableTime: _availableTime,
                                      isDisabled: List.generate(
                                          _availableTime.data.length,
                                          (index) => false),
                                      // isDisabled: [false,false,false,false,false,false,false,false,false,false,],
                                      onPressed: (int index) {
                                        print(
                                            "Package id ${widget.package.id}--${requestDate}--${_availableTime.data[index]}");
                                        setState(() {
                                          if (isSelected.isEmpty) {
                                            isSelected = List.generate(
                                                _availableTime.data.length,
                                                (index) => false);
                                          } else {
                                            for (var i = 0;
                                                i < isSelected.length;
                                                i++) isSelected.remove(i);
                                            isSelected = List.generate(
                                                _availableTime.data.length,
                                                (index) => false);
                                          }
                                          for (int buttonIndex = 0;
                                              buttonIndex < isSelected.length;
                                              buttonIndex++) {
                                            if (buttonIndex == index) {
                                              isSelected[buttonIndex] =
                                                  !isSelected[buttonIndex];
                                            } else {
                                              isSelected[buttonIndex] = false;
                                            }
                                          }
                                          print("$index is selected");
                                          slotId = index;
                                          print(slotId.toString() +
                                              " is selected");
                                        });
                                      },
                                    ),
                            )
                          : _loadingSlot
                              ? Container(
                                  height: 200,
                                  width: double.infinity,
                                  child: Lottie.asset(
                                      "assets/lottie/loading.json"),
                                )
                              : Container(
                                  child: Text("Không có nhân viên rảnh")),
                      SizedBox(
                        height: 40,
                      ),
                      widget.isBookNow == false
                          ? DefaultButton(
                              text: "Xác nhận",
                              press: () {
                                Navigator.pop(
                                  context,
                                  new RequestBookingDetail(
                                      packageId: widget.package.id,
                                      dateBooking: requestDate,
                                      timeBooking: _availableTime.data[slotId]),
                                );
                              },
                            )
                          : DefaultButton(
                              text: "Tiếp theo",
                              press: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (builder) {
                                //     return Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 80),
                                //       child: Dialog(
                                //         child: Container(
                                //           height: 150,
                                //           child: Lottie.asset(
                                //               "assets/lottie/circle_loading.json"),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );
                                List<RequestBookingDetail>
                                    listRequestBookingDetail =
                                    new List<RequestBookingDetail>();
                                listRequestBookingDetail.add(
                                    new RequestBookingDetail(
                                        packageId: widget.package.id,
                                        dateBooking: requestDate,
                                        timeBooking:
                                            _availableTime.data[slotId]));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookingConfirmScreen(
                                            spa: widget.spa,
                                            listRequestBooking:
                                                listRequestBookingDetail,
                                            packageInstance: widget.package,
                                          )),
                                );
                                // BookingServices.createBookingRequest(
                                //         listRequestBookingDetail, widget.spa.id)
                                //     .then((value) {
                                //   Navigator.pop(context);
                                //   value.compareTo("200") == 0
                                //       ? showDialog(
                                //           context: context,
                                //           builder: (context) {
                                //             return MyCustomDialog(
                                //               height: 250,
                                //               press: () {
                                //                 Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) =>
                                //                           BottomNavigation()),
                                //                 );
                                //               },
                                //               title: "Thành Công !",
                                //               description:
                                //                   "Dịch vụ của bạn đã được đặt lịch thành công, vui lòng chờ xác nhận từ cửa hàng",
                                //               buttonTitle: "Quay về trang chủ",
                                //               lottie:
                                //                   "assets/lottie/success.json",
                                //             );
                                //           },
                                //         )
                                //       : showDialog(
                                //           context: context,
                                //           builder: (context) {
                                //             return MyCustomDialog(
                                //               height: 250,
                                //               press: () {
                                //                 Navigator.pop(context);
                                //               },
                                //               title: "Thất bại !",
                                //               description:
                                //                   "Đặt dịch vụ không thành công, vui lòng thử lại sau",
                                //               buttonTitle: "Thoát",
                                //               lottie: "assets/lottie/fail.json",
                                //             );
                                //           },
                                //         );
                                // }
                                // );
                              }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class ChoosenPackage extends StatelessWidget {
  const ChoosenPackage({
    Key key,
    this.package,
  }) : super(key: key);

  final PackageInstance package;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.getProportionateScreenWidth(70),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: package.image == null
                      ? Image.asset(
                          "assets/images/Splash_1.PNG",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          package.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  package.description.length < 50
                      ? Text(package.description)
                      : Text(package.description.substring(0, 49) + "..."),
                  // Container(
                  //   width: double.infinity,
                  //   child: Text(
                  //     package.spaId.name,
                  //     textAlign: TextAlign.right,
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCustomDialog extends StatelessWidget {
  const MyCustomDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.buttonTitle,
    @required this.lottie,
    @required this.press,
    @required this.height,
  }) : super(key: key);

  final String title, description, buttonTitle, lottie;
  final double height;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                child: Lottie.asset(
                  lottie,
                  repeat: false,
                ),
                width: 100,
                height: 100,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
              TextButton(
                  onPressed: press,
                  child: Text(
                    buttonTitle,
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class DateBox extends StatefulWidget {
  const DateBox({
    Key key,
    @required this.date,
    this.package,
  }) : super(key: key);
  final DateTime date;
  final PackageInstance package;

  @override
  _DateBoxState createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 60,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.date.month.toString()),
              Text(
                MyHelper.dayOfWeekToText(widget.date.weekday),
              ),
            ],
          ),
          Text(
            widget.date.day.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeBookingDescriptionBar extends StatelessWidget {
  const TimeBookingDescriptionBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
                width: 50,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black),
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              "Còn trống",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
                width: 50,
                height: 25,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5),
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              "Đang chọn",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
