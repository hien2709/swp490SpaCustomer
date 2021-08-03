import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/Spa.dart';
import 'package:spa_customer/services/SpaServices.dart';
import 'package:spa_customer/ui/booking/customer_booking_screen.dart';
import 'package:spa_customer/ui/wish_list/wish_list_booking_screen.dart';

class ChooseSpaScreen extends StatefulWidget {
  final PackageInstance package;
  final bool isManyBooking;

  const ChooseSpaScreen({Key key, this.package, this.isManyBooking}) : super(key: key);

  @override
  _ChooseSpaScreenState createState() => _ChooseSpaScreenState();
}

class _ChooseSpaScreenState extends State<ChooseSpaScreen> {
  bool _loading;
  Spa _spa;

  @override
  void initState() {
    _loading = true;
    SpaServices.getAllCategory().then((value) => {
          setState(() {
            _spa = value;
            _loading = false;
          })
        });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Chọn Spa"),
      ),
      body: _loading
          ? Container(
        child: SpinKitWave(
          color: kPrimaryColor,
          size: 50,
        ),
            )
          : SingleChildScrollView(
            child: Container(
                child: Column(
                children: [
                  ...List.generate(
                      _spa.data.length,
                      (index) => Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 4,
                                  offset: Offset(4, 4), // Shadow position
                                ),
                              ],
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            height: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset("assets/icons/herbal-spa-treatment-leaves.svg", width: 24, height: 24,),
                                          Text(
                                            _spa.data[index].name,
                                            style:
                                                TextStyle(fontSize: 20, color: kGreen),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on, color: Colors.grey,),
                                          Expanded(
                                            child: Text(
                                              _spa.data[index].street +
                                              ", " +
                                              _spa.data[index].district +
                                              ", " +
                                              _spa.data[index].city,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            widget.isManyBooking
                                                ? WishListBookingScreen(spa: _spa.data[index],)
                                                : CustomerBookingScreen(
                                                  package: widget.package,
                                                  spa: _spa.data[index],
                                                )),
                                      );
                                    },
                                    child: Text("Chọn", style: TextStyle(fontSize: 16),))
                              ],
                            ),
                          )),
                ],
              )),
          ),
    );
  }
}
