import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Notification.dart';
import 'package:spa_customer/services/CustomerProfileServices.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  NotificationCustomer notification = NotificationCustomer();
  bool loading = true;
  String image = "";

  getNotification() async {
    await CustomerProfileServices.getCustomerNotification().then((value) => {
          setState(() {
            notification = value;
            loading = false;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
          child: SpinKitWave(
        color: kPrimaryColor,
        size: 50,
      ));
    } else {
      return notification.data.length == 0
          ? Center(
              child: Text(
              "Chưa có thông báo nào",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ))
          : SingleChildScrollView(
            child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notification.data.length,
                    itemBuilder: (context, index) {
                      if (notification.data[index].type == "STEP_FINISH") {
                        image = 'assets/notification/finish.jpg';
                      } else if (notification.data[index].type ==
                          "TREATMENT_FINISH") {
                        image = 'assets/notification/finish.jpg';
                      } else if (notification.data[index].type == "REMIND") {
                        image = 'assets/notification/remind.jpg';
                      } else if (notification.data[index].type == "CHANG_STAFF") {
                        image = 'assets/notification/changStaff.jpg';
                      } else if (notification.data[index].type == "SKIP") {
                        image = 'assets/notification/skip.jpg';
                      } else if (notification.data[index].type == "CANCEL") {
                        image = 'assets/notification/cancel.jpg';
                      }else{
                        image = 'assets/notification/spa.jpg';
                      }
                      return NotificationBookingSuccessItem(
                        image: image,
                        title: notification.data[index].title,
                        message: notification.data[index].message,
                      );
                    },
                  )
                ],
              ),
          );
    }
  }
}

class NotificationBookingSuccessItem extends StatelessWidget {
  const NotificationBookingSuccessItem({
    Key key,
    @required this.image,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  final String image, title, message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 5),
        ),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Container(
              child: Image.asset(image),
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          message,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
