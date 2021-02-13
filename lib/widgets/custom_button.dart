import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String textButton;
  final double width;
  final double height;
  final Color textColor;

  CustomButton(
      {Key key,
      this.onPressed,
      this.color,
      this.textButton,
      this.width,
      this.textColor,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55 ?? height,
      child: RaisedButton(
        onPressed: onPressed,
        textColor: Colors.white ?? textColor,
        child: Text(
          textButton.toUpperCase(),
          style: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        color: color,
      ),
    );
  }
}
