import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/ui/bottom_navigation/bottom_navigation.dart';
import 'package:spa_customer/ui/components/profile_pic.dart';
import 'package:spa_customer/ui/history/history_screen.dart';
import 'package:spa_customer/ui/notification/notification.dart';
import 'package:spa_customer/ui/profile/change_password/change_password.dart';
import 'package:spa_customer/ui/profile_detail/profile_detail.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(
          height: 30,
        ),
        ProfileMenu(
          icon: Icon(
            Icons.person_outline,
            size: 30,
            color: kPrimaryColor,
          ),
          text: "Thông tin tài khoản",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileDetail()),
            );
          },
        ),
        ProfileMenu(
          icon: Icon(
            Icons.security,
            size: 30,
            color: kPrimaryColor,
          ),
          text: "Đổi mật khẩu",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangePassword()));
          },
        ),
        ProfileMenu(
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 30,
            color: kPrimaryColor,
          ),
          text: "Thông báo",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomerNotification()),
            );
          },
        ),
        ProfileMenu(
          icon: Icon(
            Icons.history,
            size: 30,
            color: kPrimaryColor,
          ),
          text: "Lịch sử",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoryScreen()),
            );
          },
        ),
        ProfileMenu(
          icon: Icon(
            Icons.logout,
            size: 30,
            color: kPrimaryColor,
          ),
          text: "Đăng xuất",
          press: () {
            MyApp.storage.deleteItem("token");
            MyApp.storage.deleteItem("customerId");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
                    (route)=>false
            );
          },
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
