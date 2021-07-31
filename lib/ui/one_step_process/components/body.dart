import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/constant.dart';

class OneStepProcessBody extends StatefulWidget {
  const OneStepProcessBody({Key key}) : super(key: key);

  @override
  _OneStepProcessBodyState createState() => _OneStepProcessBodyState();
}

class _OneStepProcessBodyState extends State<OneStepProcessBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            TimeSection(),
            SizedBox(height: 20,),
            SpaSection(),
            SizedBox(height: 20,),
            StaffSection(),
            SizedBox(height: 20,),
            ServiceSection(),
          ],
        ),
      ),
    );
  }

  Container TimeSection(){
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
                      "8:00 | 31/07/2021",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Text(
                      "Theo dõi lịch để không bị lỡ hẹn với spa của bạn",
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
                  "  Thông tin chuyên viên",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Text("Tên: Vũ Đức Hiển"),
                Text("Sđt: 0349871777"),
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
                  "  Thông tin spa",
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
                      children: [Text("Tên chi nhánh: "), Text("Địa chỉ:")],
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Eri-Clinic Q12"),
                          Text("16A/4 Tô Ký, Trung Mỹ Tây, Q12,Thành Phố HCM"),
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
                  "  Chi tiết dịch vụ",
                  style: TextStyle(fontSize: 22, color: kPrimaryColor),
                ),
                Divider(
                  color: kPrimaryColor,
                ),
                Text("Dịch vụ chăm sóc da mặt", style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Text("Bước 1: Tẩy tế bào chết", style: TextStyle(fontSize: 18 ,color: kGreen),),
                SizedBox(height: 10,),
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
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                          child:  Image.asset(
                            "assets/images/beauty.png",
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                      SizedBox(width: 8,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Làm sạch nhẹ nhàng và sâu bên trong da, làm cho da có cảm giác thư giãn, giúp thải độc...",),
                          ),
                        ],),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text("Bước 2: Mát xa", style: TextStyle(fontSize: 18, color: kGreen),),
                SizedBox(height: 10,),
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
                        width: 70,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            child:  Image.asset(
                              "assets/images/body.png",
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      SizedBox(width: 8,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Làm sạch nhẹ nhàng và sâu bên trong da, làm cho da có cảm giác thư giãn, giúp thải độc...",),
                            ),
                          ],),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
