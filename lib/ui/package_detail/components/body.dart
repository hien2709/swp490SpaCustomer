import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/booking/components/choose_spa.dart';
import 'package:spa_customer/ui/booking/customer_booking_screen.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';
import 'package:spa_customer/ui/login/login.dart';
import 'package:spa_customer/ui/package_detail/components/package_detail_image.dart';

class Body extends StatefulWidget {
  final PackageInstance package;

  const Body({Key key, this.package}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PackageDetailImage(package: widget.package),
          DraggableScrollableSheet(
              minChildSize: 0.45,
              builder: (context, scrollController) {
                return Container(
                  // margin: EdgeInsets.only(top: size.height * 0.45),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            child: Container(
                              width: 150,
                              height: 7,
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.package.name,
                            style: TextStyle(
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            widget.package.description,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Chi tiết dịch vụ",
                            style: TextStyle(
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              ...List.generate(
                                  widget.package.services.length,
                                  (index) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.black),
                                                child: widget
                                                            .package
                                                            .services[index]
                                                            .image ==
                                                        null
                                                    ? Image.asset(
                                                        "assets/images/Splash_1.PNG")
                                                    : Image.network(
                                                        widget
                                                            .package
                                                            .services[index]
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Container(
                                                  height: 150,
                                                  width: 160,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        widget
                                                            .package
                                                            .services[index]
                                                            .name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                      Text(
                                                        widget
                                                            .package
                                                            .services[index]
                                                            .description,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DefaultButton(
                            text: MyApp.storage.getItem("token") == null ?"Đăng nhập để đặt lịch" :"Đặt lịch ngay",
                            press: () {
                              if (MyApp.storage.getItem("token") == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login(
                                        isMainLogin: false,
                                      )),
                                ).then((value) => setState(() {}));
                              }else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChooseSpaScreen(package: widget.package,
                                          isManyBooking: false,),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
