import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/size_config.dart';
import 'package:spa_customer/ui/appointment_schedule/appointment_schedule.dart';
import 'package:spa_customer/ui/home_screen/home_screen.dart';
import 'package:spa_customer/ui/notification/notification.dart';
import 'package:spa_customer/ui/process/process.dart';
import 'package:spa_customer/ui/profile/profile.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();

}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    Process(),
    AppointmentSchedule(),
    CustomerNotification(),
    Profile()
  ];

  void  onBottomNavigationItemSelect(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // print(MyApp.storage.getItem("token"));
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text("Trang chủ"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_outlined,
            ),
            title: Text("Theo dõi"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            title: Text("Lịch hẹn"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none_outlined,
            ),
            title: Text("Thông báo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            title: Text("Tài khoản"),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onBottomNavigationItemSelect,
      ),
    );
  }
}
