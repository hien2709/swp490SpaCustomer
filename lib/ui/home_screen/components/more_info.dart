import 'package:flutter/material.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/home_screen/components/search_widget.dart';

class MoreInfo extends StatefulWidget {
  List<Datum> listPackage;

  MoreInfo(this.listPackage);

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  List<Datum> packages;
  String query = '';

  Widget buildSearch() => SearchWidget(
        query,
        searchPackage,
        'search package...',
      );

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

  Widget buildPackage(Datum package) => ListTile(
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
          Expanded(
            child: ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];

                return buildPackage(package);
              },
            ),
          ),
        ],
      ),
    );
  }
}
