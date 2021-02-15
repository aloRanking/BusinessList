import 'package:businesslisting/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function onTap;

  const ButtonWidget({Key key, this.title, this.hasBorder, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? kWhiteColor : kBlueColor,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(color: kBlueColor, width: 1)
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: hasBorder ? kBlueColor : kWhiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
