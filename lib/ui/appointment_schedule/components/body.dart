import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/ui/one_step_process/one_step_process.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                child: SvgPicture.asset("assets/icons/schedule.svg"),
              ),
              SizedBox(
                width: 10,
              ),
              Text( "27/07/2021")
            ],
          ),
          Divider(
            height: 10,
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OneStepProcessScreen()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: Text("10:00",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      width: 10,
                      color: Colors.grey,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Đấm bóp",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        Text("Spa A"),
                        Text("16A/4 Tô Ký, Trung Mỹ Tây, Quận 12"),
                        Text("Chưa có nhân viên")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
