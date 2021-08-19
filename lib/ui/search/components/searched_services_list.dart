import 'package:flutter/material.dart';
import 'package:spa_customer/ui/components/section_title.dart';

class SearchedServices extends StatelessWidget {
  const SearchedServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(name: "Dịch vụ", press: () {}),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // ...List.generate(
              //   _services.length,
              //       (index) => service_card.dartServiceCard(
              //     services: _services,
              //     service: _services[index],
              //     press: () => Navigator.pushNamed(
              //       context,
              //       ServiceDetailScreen.routeName,
              //       arguments: ServiceDetailsArguments(service: _services[index]),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
