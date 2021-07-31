import 'package:flutter/material.dart';
import 'package:spa_customer/ui/one_step_process/components/body.dart';

class OneStepProcessScreen extends StatelessWidget {
  const OneStepProcessScreen({Key key, this.bookingDetailId}) : super(key: key);
  final int bookingDetailId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết dịch vụ"),
      ),
      body: OneStepProcessBody(bookingDetailId: bookingDetailId,),
    );
  }
}
