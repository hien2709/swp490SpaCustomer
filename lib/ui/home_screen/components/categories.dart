import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/models/Category.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/services/CategoryServices.dart';

import 'more_info.dart';
class Categories extends StatefulWidget {
  final Category category;
  final Package package;

  const Categories({Key key, this.category, this.package}) : super(key: key);@override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<PackageInstance> listPackage = [];


  getListPackage(id){
    for(int i = 0; i < widget.package.data.length; i++){
      if(widget.package.data[i].categoryId.id == id){
        listPackage.add(widget.package.data[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: [
        ...List.generate(
            widget.category.data.length,
                (index) => CategoryCard(
                icon: widget.category.data[index].icon ,
                text: widget.category.data[index].name,
                press: (){
                  listPackage.clear();
                  getListPackage(widget.category.data[index].id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoreInfo(listPackage, widget.category.data[index].name)
                      ));
                })),

      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: SizedBox(
          width: 55,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFECDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: icon == null ? SvgPicture.asset("assets/icons/herbal-spa-treatment-leaves.svg") : Image.network(icon),

                ),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}