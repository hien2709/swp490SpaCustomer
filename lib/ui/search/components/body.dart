import 'package:flutter/material.dart';
import 'package:spa_customer/ui/home_screen/components/search_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // SearchModel _searchResult;
  bool _loading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          child: Column(
            children: [
              SearchField(
                width: double.infinity,
                autoFocus: true,
                onSubmmited: (value) {
                  _loading = true;
                  // SearchServices.searchServiceAndCompany(value)
                  //     .then((searchResult) => {
                  //           setState(() {
                  //             _searchResult = searchResult;
                  //             _loading = false;
                  //           })
                  //         });
                },
              ),
              SizedBox(
                height: 20,
              ),
              // _searchResult == null
              //     ? Text("Tìm kiếm dịch vụ hoặc cửa hàng")
              //     : Column(
              //       children: [
              //         SearchedService(services: _searchResult.listServiceDtos),
              //         SizedBox(height: 20,),
              //         SearchedCompany(companies: _searchResult.listCompanyDtos),
              //       ],
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}
