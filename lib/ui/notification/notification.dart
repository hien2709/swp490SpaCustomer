import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/ui/notification/components/body.dart';

class CustomerNotification extends StatefulWidget {
  const CustomerNotification({Key key}) : super(key: key);

  @override
  _CustomerNotificationState createState() => _CustomerNotificationState();
}

class _CustomerNotificationState extends State<CustomerNotification> {
  @override
  Widget build(BuildContext context) {
    DateFormat formater = new DateFormat("hh:mm:ss");
    DateTime time = formater.parse("21:00:00");
    print("Time ne");
    print(time.toString().substring(11,19));
    return Container(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                Text(
                  " Thông báo",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ],
            )),
        body: Body(),
      ),
    );
  }
}


