import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/ui/history/components/morestep.dart';
import 'package:spa_customer/ui/history/components/onestep.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: kPrimaryColor,
          title: Text("Dịch vụ đã sử dụng", style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            tabs: [
              Tab(text: "Liệu trình dài",),
              Tab(text: "Dịch vụ ngắn",)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MoreStepHistory(),
            OneStepHistory()
          ],
        ),
      ),
    );
  }
}
