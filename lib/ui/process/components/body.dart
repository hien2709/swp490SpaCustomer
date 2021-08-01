import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    // TODO: implement initState
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
        child: Lottie.asset("assets/lottie/loading.json"),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
              _bookingDetail.data.length,
              (index) => Column(
                    children: [
                      ProcessItem(
                        processItem: _bookingDetail.data[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CustomerProcessDetail(processDetail: _bookingDetail.data[index],)),
                          );
                        },
                      ),
                      Divider(
                        height: 10,
                      )
                    ],
                  )),
        ],
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
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
                      "DỊCH VỤ    : ${_processItem.spaPackage.name}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Text("Cửa hàng  : ${_processItem.booking.spa.name}"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Địa chỉ       : "),
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
    );
  }
}
