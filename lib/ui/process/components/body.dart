import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/services/BookingDetailServices.dart';
import 'package:spa_customer/ui/process_detail/process_detail_screen.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  BookingDetail _bookingDetail;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    super.initState();
    BookingDetailServices.getAllBookingDetailMoreStepByCustomerId()
        .then((value) => {
              setState(() {
                _bookingDetail = value;
                _loading = false;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Container(
        child: SpinKitWave(
          color: kPrimaryColor,
          size: 50,
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            ...List.generate(
                _bookingDetail.data.length,
                (index) => _bookingDetail.data[index].statusBooking != "FINISH"
                    ? ProcessItem(
                        processItem: _bookingDetail.data[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerProcessDetail(
                                      processDetail: _bookingDetail.data[index],
                                    )),
                          );
                        },
                      )
                    : SizedBox()),
          ],
        ),
      ),
    );
  }
}

class ProcessItem extends StatelessWidget {
  const ProcessItem({
    Key key,
    @required Datum processItem,
    @required GestureTapCallback press,
  })  : _processItem = processItem,
        _press = press,
        super(key: key);

  final Datum _processItem;
  final GestureTapCallback _press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _press,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _processItem.spaPackage.image == null
                          ? Image.asset(
                              "assets/images/Splash_1.PNG",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              _processItem.spaPackage.image,
                              fit: BoxFit.cover,
                            ),
                    ),
                    width: 70,
                    height: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "D???CH V???:  ${_processItem.spaPackage.name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Container(
                              child:
                                  SvgPicture.asset("assets/icons/company.svg"),
                              width: 18,
                              height: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(_processItem.booking.spa.name),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                                child: Text(_processItem.booking.spa.street +
                                    " " +
                                    _processItem.booking.spa.district +
                                    " " +
                                    _processItem.booking.spa.city)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
