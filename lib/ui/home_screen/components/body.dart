import 'package:flutter/material.dart';
import 'package:spa_customer/models/Category.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/services/CategoryServices.dart';
import 'package:spa_customer/services/PackageServices.dart';
import 'package:spa_customer/ui/components/section_title.dart';
import 'package:spa_customer/ui/components/service_card.dart';
import 'package:spa_customer/ui/home_screen/components/categories.dart';
import 'package:spa_customer/ui/home_screen/components/home_header.dart';
import 'package:spa_customer/ui/package_detail/package_detail.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loading;
  Package _package;
  Category _category;
  
  @override
  void initState() {
    CategoryServices.getAllCategory().then((category) => {
      setState(() {
        _category = category;
        _loading = false;
      })
    });
    // TODO: implement initState
    PackageServices.getAllPackages().then((package) => {
      setState(() {
        _package = package;
        _loading = false;
      })
    });
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
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
                Categories(category: _category),
                SizedBox(height: 20),
                Column(
                  children: [
                    ...List.generate(_category.data.length, (index1) =>
                        Column(
                          children: [
                            SectionTitle(text: _category.data[index1].name, press: (){}),
                            Wrap(
                              children: [
                                ...List.generate(
                                  _package.data.length,
                                      (index2) =>
                                      _package.data[index2].categoryId.id == _category.data[index1].id ? ServiceCard(service: _package.data[index2] ,
                                        press: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PackageDetailScreen(package: _package.data[index2],),
                                            ),
                                          );
                                        },
                                      ) : SizedBox(height: 0, width: 0,)
                                  ,
                                )
                              ],
                            )
                          ],
                        ),)
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
