import 'package:flutter/material.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/home_screen/components/more_info.dart';

class SectionTitle extends StatefulWidget {

  const SectionTitle({
    Key key,
    @required this.text,
    @required this.press,
    @required this.package,
    @required this.id,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;
  final Package package;
  final int id;

  @override
  _SectionTitleState createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  List<Datum> listPackage = [];

  getListPackage(){
    for(int i = 0; i < widget.package.data.length; i++){
      if(widget.package.data[i].categoryId.id == widget.id){
        listPackage.add(widget.package.data[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getListPackage();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MoreInfo(listPackage)
                ));
          },
          child: Text("Xem thêm"),
        ),
      ],
    );
  }
}