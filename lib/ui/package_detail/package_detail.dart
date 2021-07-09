import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/package_detail/components/body.dart';

class PackageDetailScreen extends StatefulWidget {
  final Datum package;

  const PackageDetailScreen({Key key, this.package}) : super(key: key);

  @override
  _PackageDetailScreenState createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Body(package: widget.package,)
    );
  }
}
