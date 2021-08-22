import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/home_screen/components/search_widget.dart';
import 'package:spa_customer/ui/package_detail/package_detail.dart';

class MoreInfo extends StatefulWidget {
  List<PackageInstance> listPackage;
  String category;

  MoreInfo(this.listPackage, this.category);

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  List<PackageInstance> packages;
  String query = '';

  Widget buildSearch() => SearchWidget(query, searchPackage, false);

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
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PackageDetailScreen(
                          package:package,
                        ),
                  ),
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.zero,
                        ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              package.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),

                            Text(package.type == "ONESTEP"?"DỊCH VỤ NGẮN":"LIỆU TRÌNH DÀI",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade500)),
                            SizedBox(height: 5),
                            Text(package.description, maxLines: 3, overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade500)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.category,
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
