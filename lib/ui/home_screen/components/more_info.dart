import 'package:flutter/material.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/home_screen/components/search_widget.dart';

class MoreInfo extends StatefulWidget {
  List<PackageInstance> listPackage;

  MoreInfo(this.listPackage);

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  List<PackageInstance> packages;
  String query = '';

  Widget buildSearch() =>
      SearchWidget(query, searchPackage, false);

  void searchPackage(String query) {
    final packageSearch = widget.listPackage.where((package) {
      final nameLower = package.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.packages = packageSearch;
    });
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
                      image: NetworkImage(package.image == null
                          ? "https://toplist.vn/images/800px/dang-ngoc-spa-149960.jpg"
                          : package.image),
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

  Widget buildPackage(PackageInstance package) => ListTile(
        leading: Image.network(
          package.image,
          fit: BoxFit.cover,
          width: 100,
          height: 150,
        ),
        title: Text(package.name),
        subtitle: Text(package.type),
        //minVerticalPadding: 30,
      );

  @override
  void initState() {
    super.initState();
    packages = widget.listPackage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Điều trị da",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          buildSearch(),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];

                return ListPackage(package);
              },
            ),
          ),
        ],
      ),
    );
  }
}
