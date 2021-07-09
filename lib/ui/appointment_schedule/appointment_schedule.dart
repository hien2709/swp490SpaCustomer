import 'package:flutter/material.dart';
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
      body: Body(),
    );
  }
}
