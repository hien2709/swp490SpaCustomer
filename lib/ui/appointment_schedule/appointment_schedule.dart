import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/ui/appointment_schedule/components/body.dart';
class AppointmentSchedule extends StatefulWidget {
  const AppointmentSchedule({Key key}) : super(key: key);

  @override
  _AppointmentScheduleState createState() => _AppointmentScheduleState();
}

class _AppointmentScheduleState extends State<AppointmentSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            Text(
              " Lịch hẹn của bạn",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Body(),
    );
  }
}
