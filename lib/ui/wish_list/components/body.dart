import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/RequestBookingDetail.dart';
import 'package:spa_customer/size_config.dart';
import 'package:spa_customer/ui/booking/components/body.dart';
import 'package:spa_customer/ui/booking_confirm/booking_confirm_screen.dart';
import 'package:spa_customer/ui/home_screen/home_screen.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<bool> checkList =
      List<bool>.generate(HomeScreen.cart.length, (index) => false);
  List<RequestBookingDetail> listRequestBookingDetail = new List<RequestBookingDetail>();

  @override
  Widget build(BuildContext context) {
    print("data:" + checkList.toString());
    return Stack(
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
                            SizeConfig.getProportionateScreenHeight(8)),
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
                          MyApp.storage.setItem(
                              "cart", cartItemToJson(HomeScreen.cart));
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: checkList[index],
                            onChanged: (value) async {
                              if(value){
                                  RequestBookingDetail request = await showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext buildContext) {
                                        return Container(
                                          height: SizeConfig
                                              .getProportionateScreenHeight(800),
                                          child: ListView(
                                            children: [
                                              IconButton(
                                                alignment: Alignment.topRight,
                                                icon: Icon(
                                                  Icons.close,
                                                  color: kPrimaryColor,
                                                  size: 25,
                                                ),
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              BookingBody(package: HomeScreen.cart[index], isBookNow: false, listRequestBookingDetail: listRequestBookingDetail)
                                            ],
                                          ),
                                        );
                                      });
                                  request == null ? setState(() {
                                    checkList[index] = false;
                                    for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                      if(HomeScreen.cart[index].id == listRequestBookingDetail[i].packageId){
                                        listRequestBookingDetail.removeAt(i);
                                      }
                                    }
                                    for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                      print("1 Time: ${listRequestBookingDetail[i].timeBooking}-- Date: ${listRequestBookingDetail[i].dateBooking}-- PackageId: ${listRequestBookingDetail[i].packageId}");
                                    }
                                  }) :
                                  setState(() {
                                    bool isExist = false;
                                    for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                      if(listRequestBookingDetail[i].packageId == request.packageId){
                                        listRequestBookingDetail[i] = request;
                                        isExist = true;
                                      }
                                      print("2 Time: ${listRequestBookingDetail[i].timeBooking}-- Date: ${listRequestBookingDetail[i].dateBooking}-- PackageId: ${listRequestBookingDetail[i].packageId}");
                                    }
                                    if(isExist == false){
                                      listRequestBookingDetail.add(request);
                                      for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                        print("3 Time: ${listRequestBookingDetail[i].timeBooking}-- Date: ${listRequestBookingDetail[i].dateBooking}-- PackageId: ${listRequestBookingDetail[i].packageId}");
                                      }
                                    }
                                    checkList[index] = true;
                                  });
                              }
                              if(!value){
                                setState(() {
                                  checkList[index] = false;
                                  for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                    if(HomeScreen.cart[index].id == listRequestBookingDetail[i].packageId){
                                      listRequestBookingDetail.removeAt(i);
                                    }
                                  }
                                  for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                    print("4 Time: ${listRequestBookingDetail[i].timeBooking}-- Date: ${listRequestBookingDetail[i].dateBooking}-- PackageId: ${listRequestBookingDetail[i].packageId}");
                                  }
                                });
                              }
                              // setState(() {
                              //   checkList[index] = value;
                              // });
                            },
                          ),
                          CartItemCard(
                            cartItem: HomeScreen.cart[index],
                            press: () async{
                              RequestBookingDetail request = await showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext buildContext) {
                                    return Container(
                                      height: SizeConfig
                                          .getProportionateScreenHeight(800),
                                      child: ListView(
                                        children: [
                                          IconButton(
                                            alignment: Alignment.topRight,
                                            icon: Icon(
                                              Icons.close,
                                              color: kPrimaryColor,
                                              size: 25,
                                            ),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          BookingBody(package: HomeScreen.cart[index], isBookNow: false,listRequestBookingDetail: listRequestBookingDetail)
                                        ],
                                      ),
                                    );
                                  });
                              request == null ? setState(() {
                                checkList[index] = false;
                                for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                  if(HomeScreen.cart[index].id == listRequestBookingDetail[i].packageId){
                                    listRequestBookingDetail.removeAt(i);
                                  }
                                }
                                for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                  print("5 Time: ${listRequestBookingDetail[i].timeBooking}-- Date: ${listRequestBookingDetail[i].dateBooking}-- PackageId: ${listRequestBookingDetail[i].packageId}");
                                }
                              }) :
                              setState(() {
                                bool isExist = false;
                                for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                  if(listRequestBookingDetail[i].packageId == request.packageId){
                                    listRequestBookingDetail[i] = request;
                                    isExist = true;
                                  }
                                }
                                if(isExist == false){
                                  listRequestBookingDetail.add(request);
                                  for(var i = 0 ; i< listRequestBookingDetail.length ; i++){
                                    print("6 Time: ${listRequestBookingDetail[i].timeBooking}-- Date: ${listRequestBookingDetail[i].dateBooking}-- PackageId: ${listRequestBookingDetail[i].packageId}");
                                  }
                                }
                                checkList[index] = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: SizeConfig.getProportionateScreenWidth(375 ),
            height: SizeConfig.getProportionateScreenHeight(50),
            child: TextButton(
              child: Text("Đặt lịch",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingConfirmScreen(listRequestBooking: listRequestBookingDetail,)),
                );
              },
            )
          ),
          bottom: 0,
        )
      ],
    );
  }
}

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key key,
    this.cartItem,
    this.press,
  }) : super(key: key);
  @required
  final GestureTapCallback press;
  @required
  final PackageInstance cartItem;

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.getProportionateScreenWidth(88),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: widget.cartItem.image == null
                    ? Image.asset("assets/images/Splash_1.PNG", fit: BoxFit.cover,)
                    : Image.network(widget.cartItem.image, fit: BoxFit.cover,),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.getProportionateScreenWidth(20)),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cartItem.name,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                      text: "Liên hệ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
