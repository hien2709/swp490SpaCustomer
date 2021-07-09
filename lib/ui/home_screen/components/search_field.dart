import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
    this.onTap,
    this.onSubmmited,
    this.onChange,
    @required this.width,
    this.autoFocus,
    this.focusNode,
  }) : super(key: key);

  final Function onTap;
  final Function onSubmmited;
  final Function onChange;
  final double width;
  final bool autoFocus;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        focusNode: focusNode,
        autofocus: autoFocus,
        textInputAction: TextInputAction.search,
        onTap: onTap,
        onSubmitted: onSubmmited,
        onChanged: onChange,
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Tìm kiếm...",
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
      ),
    );
  }
}
