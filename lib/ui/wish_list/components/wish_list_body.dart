import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/RequestBookingDetail.dart';
import 'package:spa_customer/size_config.dart';
import 'package:spa_customer/ui/booking/components/choose_spa.dart';
import 'package:spa_customer/ui/home_screen/home_screen.dart';
import 'package:spa_customer/ui/login/login.dart';
import 'package:spa_customer/ui/wish_list/components/wish_list_booking_body.dart';

class WishListBody extends StatefulWidget {
  const WishListBody({Key key}) : super(key: key);

  @override
  _WishListBodyState createState() => _WishListBodyState();
}

class _WishListBodyState extends State<WishListBody> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen.cart.length == 0
        ? Center(
            child: Container(
            padding: EdgeInsets.only(bottom: 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/wishlist.svg",
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Danh sách mong muốn của bạn đang trống",
                  style: TextStyle(fontSize: 17, color: kBlue),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ))
        : Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    ...List.generate(
                        HomeScreen.cart.length,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      SizeConfig.getProportionateScreenHeight(
                                          8)),
                              child: Dismissible(
                                key: Key(HomeScreen.cart[index].id.toString()),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFFE6E6),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                      )
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    HomeScreen.cart.removeAt(index);
                                    MyApp.storage.setItem("cart",
                                        cartItemToJson(HomeScreen.cart));
                                  });
                                },
                                child: Row(
                                  children: [
                                    CartItemCard(
                                      cartItem: HomeScreen.cart[index],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ],
                ),
              ),
              Positioned(
                child: Visibility(
                  visible: HomeScreen.cart.length != 0,
                  child: Container(
                      width: SizeConfig.getProportionateScreenWidth(375),
                      height: SizeConfig.getProportionateScreenHeight(50),
                      child: TextButton(
                        child: MyApp.storage.getItem("token") == null
                            ? Text(
                                "Đăng nhập để đặt lịch",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )
                            : Text(
                                "Đặt lịch",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed: () {
                          if (MyApp.storage.getItem("token") == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login(
                                        isMainLogin: false,
                                      )),
                            ).then((value) => setState(() {}));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseSpaScreen(
                                        isManyBooking: true,
                                      )),
                            );
                          }
                        },
                      )),
                ),
                bottom: 0,
              )
            ],
          );
  }
}
