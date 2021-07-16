import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/RequestBookingDetail.dart';
import 'package:spa_customer/services/BookingServices.dart';
import 'package:spa_customer/ui/booking/components/body.dart';
import 'package:spa_customer/ui/bottom_navigation/bottom_navigation.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

class Body extends StatelessWidget {
  @required
  final List<RequestBookingDetail> listRequestBooking;

  const Body({Key key, @required this.listRequestBooking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PackageInstance> listPackage =
        MyHelper.getListPackageFromListRequestBooking(listRequestBooking);
    return Column(
      children: [
        ...List.generate(
            listRequestBooking.length,
            (index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChoosenPackage(
                            package: listPackage[index],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thời gian :",style: TextStyle(fontSize: 20),),
                              Text(listRequestBooking[index].timeBooking,style: TextStyle(fontSize: 20),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ngày hẹn :",style: TextStyle(fontSize: 20),),
                              Text(MyHelper.getUserDateFromString(listRequestBooking[index].dateBooking),style: TextStyle(fontSize: 20),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )),
        DefaultButton(
          text: "Đặt lịch",
          press: (){
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
              );
              BookingServices.createBookingRequest(
                  listRequestBooking, 1)
                  .then((value) {
                Navigator.pop(context);
                value.compareTo("200") == 0
                    ? showDialog(
                  context: context,
                  builder: (context) {
                    return MyCustomDialog(
                      height: 250,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigation()),
                        );
                      },
                      title: "Thành Công !",
                      description:
                      "Dịch vụ của bạn đã được đặt lịch thành công, vui lòng chờ xác nhận từ cửa hàng",
                      buttonTitle: "Quay về trang chủ",
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
                        Navigator.pop(context);
                      },
                      title: "Thất bại !",
                      description:
                      "Đặt dịch vụ không thành công, vui lòng thử lại sau",
                      buttonTitle: "Thoát",
                      lottie: "assets/lottie/fail.json",
                    );
                  },
                );
              });

          },
        )
      ],
    );
  }
}
