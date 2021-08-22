import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/ui/login/login.dart';
import 'package:spa_customer/ui/process/components/body.dart';

class Process extends StatefulWidget {
  const Process({Key key}) : super(key: key);

  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Icon(
                    Icons.assignment,
                    color: Colors.white,
                  ),
                  Text(
                    " Liệu trình của bạn",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            body: MyApp.storage.getItem("token") == null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: SvgPicture.asset("assets/icons/schedule.svg"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push( context, MaterialPageRoute( builder: (context) => Login( isMainLogin: false,)), ).then((value) => setState(() {}));
                    },
                    child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                text: "Đăng nhập",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 17,
                                ),
                              ),
                              TextSpan(
                                text: " để xem liệu trình của bạn !",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: kTextColor
                                ),
                              )
                            ]
                        )
                    ),
                  )
                ],
              ),
            )
                : Body()
        ));
  }
}
