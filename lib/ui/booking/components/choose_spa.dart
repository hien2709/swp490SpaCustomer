import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/Spa.dart';
import 'package:spa_customer/services/SpaServices.dart';
import 'package:spa_customer/ui/booking/customer_booking_screen.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

class ChooseSpaScreen extends StatefulWidget {
  final PackageInstance package;

  const ChooseSpaScreen({Key key, this.package}) : super(key: key);

  @override
  _ChooseSpaScreenState createState() => _ChooseSpaScreenState();
}

class _ChooseSpaScreenState extends State<ChooseSpaScreen> {
  bool _loading;
  Spa _spa;

  @override
  void initState() {
    _loading = true;
    SpaServices.getAllCategory().then((value) => {
          setState(() {
            _spa = value;
            _loading = false;
          })
        });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            child: Lottie.asset("assets/lottie/loading.json"),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Chọn Spa"),
            ),
            body: Container(
                child: Column(
              children: [
                ...List.generate(
                    _spa.data.length,
                    (index) => Container(
                          child: Row(
                            children: [
                              Text(_spa.data[index].name),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerBookingScreen(
                                                package: widget.package,
                                                spa: _spa.data[index],
                                              )),
                                    );
                                  },
                                  child: Text("Chọn"))
                            ],
                          ),
                        ))
              ],
            )
                ),
          );
  }
}
