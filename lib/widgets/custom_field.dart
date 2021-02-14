import 'package:businesslisting/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTexfield extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool shudObscure;
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final Function onValidate;
  final Function onSave;
  final Color textColor;
  final Color borderColor;
  final Color labelColor;
  final String intialValue;
  final IconData prefixIconData;
  final int minLines;
  final int maxLines;
  final bool isMultilnes;
  final IconData suffixIconData;
  final Function onTap;
  final Function onChanged;

  CustomTexfield({
    Key key,
    this.hintText,
    this.shudObscure,
    this.keyBoardType,
    this.controller,
    this.onValidate,
    this.onSave,
    this.textColor,
    this.borderColor,
    this.labelColor,
    this.intialValue,
    this.prefixIconData,
    this.minLines,
    this.maxLines,
    this.labelText,
    this.isMultilnes = false,
    this.suffixIconData,
    this.onTap, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        initialValue: intialValue ?? null,
        onSaved: onSave,
        keyboardType: keyBoardType,
        obscureText: shudObscure ?? false,
        controller: controller,
        validator: onValidate,
        minLines: minLines,
        maxLines: maxLines ?? 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: kGreenColor),
          filled: true,
          prefixIcon: isMultilnes
              ? null
              : Icon(
                  prefixIconData,
                  size: 18,
                  color: kGreenColor,
                ),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              suffixIconData,
              size: 18,
              color: kGreenColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: borderColor ?? kGreenColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
