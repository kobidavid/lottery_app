import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterTextField extends StatelessWidget {
  RegisterTextField({
    Key key,
    @required this.name, this.controller, this.labelName, this.returnErr, this.textDirection,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelName;
  final String name;
  final String returnErr;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
        keyboardType: labelName=="אימייל"?TextInputType.emailAddress:labelName=="טלפון נייד"?TextInputType.phone:labelName=="תעודת זהות"?TextInputType.number:TextInputType.text,
      decoration: InputDecoration(
          labelText: labelName
      ),
      onSaved: (String value) {

      },
    validator: _validator,

    );
  }

  String _validator(String value) {
    if (labelName=="שם משתמש") {
      if (value==null ||value.isEmpty){
        return returnErr;
      }
      return null;
    }else if (labelName=="אימייל") {
      if (value==null ||value.isEmpty){
        return returnErr;
      }
      bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (emailValid != true) {
        return "כתובת אימייל לא תקינה";
      }
      return null;
    }else if(labelName=="טלפון נייד"){ //^[1-9]\d*$
      if (value==null ||value.isEmpty){
        return returnErr;
      }
      bool phoneValid = RegExp(
          r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value);
      if (phoneValid != true) {
        return "טלפון נייד לא תקין";
      }
      return null;
    }else if(labelName=="תעודת זהות"){ //^[1-9]\d*$
      if (value==null ||value.isEmpty){
        return returnErr;
      }
      bool phoneValid = RegExp(
          r"^(?:[+0]9)?[0-9]{9}$").hasMatch(value);
      if (phoneValid != true) {
        return "תעודת זהות לא תקינה";
      }
      return null;
    }
  }
}
