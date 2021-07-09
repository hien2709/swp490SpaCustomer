import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';

class TimeSlot extends StatelessWidget {
  final bool active;
  final bool isDisable;
  final Function onTap;
  final int width;
  final int height;
  final int index;
  final String time;

  const TimeSlot({
    Key key,
    this.active,
    this.onTap,
    this.width,
    this.height,
    this.index,
    this.isDisable,
    @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisable ? () => null : () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDisable
                ? Colors.grey.withOpacity(0.5)
                : active
                    ? kPrimaryColor
                    : Colors.white,
            border: Border.all(
              color: isDisable
                  ? Colors.grey.withOpacity(0.5)
                  : active
                      ? kPrimaryColor
                      : Colors.black,
            )),
        height: 40,
        width: 80,
        child: Center(child: Text(time.substring(0, 5))),
      ),
    );
  }
}
