import 'package:flutter/material.dart';
import 'package:spa_customer/ui/components/section_title.dart';

class SearchedCompany extends StatelessWidget {
  const SearchedCompany({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(text: "Các cửa hàng", press: (){}),
        Row(
          children: [
            // ...List.generate(
            //   _companies.length,
            //       (index) => Text(_companies[index].name,
            //
            //   ),
            // )
          ],
        )

      ],

    );
  }
}
