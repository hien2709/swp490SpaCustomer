import 'package:flutter/material.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/services/PackageServices.dart';
import 'package:spa_customer/ui/home_screen/components/body.dart';
import 'package:spa_customer/ui/home_screen/components/search_widget.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading;
  List<PackageInstance> packagesToShow = BodyHomeScreen.listPackageDefault;
  String query = '';

  void searchPackage(String query) {
    final packageSearch = BodyHomeScreen.listPackageDefault.where((package) {
      final nameLower = package.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.packagesToShow = packageSearch;
    });
  }

  Widget buildSearch() => SearchWidget(
    query,
    searchPackage,
    'Tìm kiếm package...',
    true,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          child: Column(
            children: [
              buildSearch(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                          child: ListView.builder(
                            itemCount: packagesToShow.length == null ? 0 : packagesToShow.length,
                            itemBuilder: (context, index) {
                              final package = packagesToShow[index];

                              return ListPackage(package);
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  ListPackage(PackageInstance package) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          package.image == null ? "https://toplist.vn/images/800px/dang-ngoc-spa-149960.jpg" : package.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          package.name,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),

                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
