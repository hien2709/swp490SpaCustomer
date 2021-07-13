import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String token;
  String title = "";

  getToken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print("token: " + token);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    RemoteNotification notification = message.notification;
    print("Notification title: " + notification.title);
    print("Notification body: " + notification.body);
    print(message.data['message']);
    setState(() {
      title = notification.title;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print("Notification title: " + notification.title);
      print("Notification body: " + notification.body);
      setState(() {
        title = notification.title;
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      print("Notification title: " + notification.title);
      print("Notification body: " + notification.body);
      setState(() {
        title = notification.title;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Title: " + title),
    );
    // return Column(
    //   children: [
    //     NotificationBookingSuccessItem(
    //       image: "assets/images/beauty.png",
    //       companyName: "Eri international",
    //       serviceName: "BIO ACNE",
    //       date: "25/03/2021",
    //     ),
    //     NotificationBookingSuccessItem(
    //       image: "assets/images/body.png",
    //       companyName: "Eri international",
    //       serviceName: "Massage JiaczHoiz",
    //       date: "26/03/2021",
    //     ),
    //     NotificationBookingSuccessItem(
    //       image: "assets/images/Skin.png",
    //       companyName: "Eri international",
    //       serviceName: "AQUA DETOX",
    //       date: "27/03/2021",
    //     ),
    //   ],
    // );

  }
}

class NotificationBookingSuccessItem extends StatelessWidget {
  const NotificationBookingSuccessItem({
    Key key,
    @required this.image,
    @required this.companyName,
    @required this.serviceName,
    @required this.date,
  }) : super(key: key);

  final String image, companyName, serviceName, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Container(
              child: Image.asset(
                image,
              ),
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Dịch vụ ",
                          ),
                          TextSpan(
                            text: serviceName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " tại ",
                          ),
                          TextSpan(
                            text: companyName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                            " đã được đặt thành công, vui lòng đợi xác nhận từ phía cửa hàng",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: double.infinity,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
