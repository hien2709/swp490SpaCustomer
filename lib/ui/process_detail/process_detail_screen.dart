import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/ui/process_detail/components/body.dart';

class CustomerProcessDetail extends StatefulWidget {
  final Datum processDetail;
  const CustomerProcessDetail({Key key, this.processDetail}) : super(key: key);

  @override
  _CustomerProcessDetailState createState() => _CustomerProcessDetailState();
}

class _CustomerProcessDetailState extends State<CustomerProcessDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: kPrimaryColor
        ),
        title: Text("Chi tiết liệu trình",

        ),
        centerTitle: true,
      ),
      body: Body(processDetail: widget.processDetail,),
    );
  }
}
