import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField({
    Key key,
    @required this.userNameController, this.labelName, this.returnErr, this.textDirection,
  }) : super(key: key);

  final TextEditingController userNameController;
  final String labelName;
  final String returnErr;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //textInputAction: TextInputAction.send,
      controller: userNameController,
      decoration: InputDecoration(
          labelText: labelName, alignLabelWithHint: false),
      textDirection: textDirection,
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        if (value.isEmpty) {
          return returnErr;
        }
        //return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    );
  }
}