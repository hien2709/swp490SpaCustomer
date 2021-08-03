import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Category.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/services/CategoryServices.dart';
import 'package:spa_customer/services/PackageServices.dart';
import 'package:spa_customer/ui/components/section_title.dart';
import 'package:spa_customer/ui/components/service_card.dart';
import 'package:spa_customer/ui/home_screen/components/categories.dart';
import 'package:spa_customer/ui/home_screen/components/home_header.dart';
import 'package:spa_customer/ui/package_detail/package_detail.dart';

import 'nearby_spa.dart';

class BodyHomeScreen extends StatefulWidget {
  const BodyHomeScreen({Key key}) : super(key: key);
  static List<PackageInstance> listPackageDefault;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodyHomeScreen> {
  bool _loading = true;
  Package _package;
  Category _category;

  getAllCatagory() async {
    await CategoryServices.getAllCategory().then((category) => {
          setState(() {
            _category = category;
          })
        });
  }

  getAllPackages() async {
    await PackageServices.getAllPackages().then((package) => {
          setState(() {
            _package = package;
            BodyHomeScreen.listPackageDefault = package.data;
          })
        });
  }

  getData() async {
    await getAllCatagory();
    await getAllPackages();
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
          child: SpinKitWave(
        color: kPrimaryColor,
        size: 50,
      ));
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  HomeHeader(),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NearBySpa()));
                        },
                        child: Text(
                          "Xem những spa gần bạn",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Categories(category: _category),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      ...List.generate(
                        _category.data.length,
                        (index1) => Column(
                          children: [
                            SectionTitle(
                                id: _category.data[index1].id,
                                text: _category.data[index1].name,
                                package: _package),
                            Wrap(
                              children: [
                                ...List.generate(
                                  _package.data.length,
                                  (index2) =>
                                      _package.data[index2].categoryId.id ==
                                              _category.data[index1].id
                                          ? ServiceCard(
                                              service: _package.data[index2],
                                              press: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PackageDetailScreen(
                                                      package:
                                                          _package.data[index2],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : SizedBox(
                                              height: 0,
                                              width: 0,
                                            ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
