import 'package:flutter/material.dart';

import '../../../constant.dart';

class SearchWidget extends StatefulWidget {
   String text;
   ValueChanged<String> onChanged;
   String hintText;
   bool autoFocus;

   SearchWidget(this.text, this.onChanged, this.hintText, this.autoFocus);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        autofocus: widget.autoFocus,
        controller: controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Tìm kiếm...",
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
              child: Icon(Icons.close, color: style.color),
              onTap: () {
                controller.clear();
                widget.onChanged('');
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
                : null,

        ),
      ),
    );
  }
}
