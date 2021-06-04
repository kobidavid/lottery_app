import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:provider/provider.dart';

class RegisterTextField extends StatefulWidget {
  RegisterTextField(
      {Key key,
      @required this.name,
      this.lastName,
      this.controller,
      this.labelName,
      this.returnErr,
      this.textDirection,
      this.keyboardType,
      this.icon,
      this.charLength})
      : super(key: key);

  final TextEditingController controller;
  final String labelName;
  final String name;
  final String lastName;
  final TextInputType keyboardType;
  final String returnErr;
  final TextDirection textDirection;
  final Icon icon;
  int charLength;

  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState(charLength);
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  _RegisterTextFieldState(int charLength);

  @override
  Widget build(BuildContext context) {
    widget.charLength = 4;
    return FormBuilderTextField(
      name: widget.name,
      textDirection: widget.textDirection,
      keyboardType: widget.keyboardType,
      onChanged: (String value){Provider.of<LoginProvider>(context,listen: false).onChanged(value);},
      decoration: InputDecoration(
        icon: widget.icon,
        labelText: widget.labelName,
      ),
      onSaved: (String value) {},
      validator: _validator,
    );
  }

  String _validator(String value) {
    if (widget.labelName == "שם פרטי") {
      if (value == null || value.isEmpty) {
        return widget.returnErr;
      }
    } else if (widget.labelName == "שם משפחה") {
      if (value == null || value.isEmpty) {
        return widget.returnErr;
      }
      return null;
    } else if (widget.labelName == "אימייל") {
      if (value == null || value.isEmpty) {
        return widget.returnErr;
      }
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (emailValid != true) {
        return "כתובת אימייל לא תקינה";
      }
      return null;
   /* } else if (widget.labelName == "טלפון נייד" ||
        widget.labelName == "התחבר באמצעות מספר טלפון") {
      //^[1-9]\d*$
      if (value == null || value.isEmpty) {
        return widget.returnErr;
      }
      bool phoneValid = RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value);
      if (phoneValid != true) {
        return "טלפון נייד לא תקין";
      }
      return null;*/
    } else if (widget.labelName == "תעודת זהות") {
      //^[1-9]\d*$
      if (value == null || value.isEmpty) {
        return widget.returnErr;
      }
      bool phoneValid = RegExp(r"^(?:[+0]9)?[0-9]{9}$").hasMatch(value);
      if (phoneValid != true) {
        return "תעודת זהות לא תקינה";
      }
      return null;
    }
  }
}
