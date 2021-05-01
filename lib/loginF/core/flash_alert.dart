import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar flushbar;

void showFlushbar1(BuildContext context,
    {String text,
    int seconds = 3,
    Color color,
    FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM}) {
  if (flushbar != null) {
    flushbar.dismiss();
  }
  flushbar = Flushbar(
    messageText: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(40, 0, 0, 0),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 2))
        ],
        color: color ?? Colors.red[600]
      ),
      child: Directionality(textDirection: TextDirection.rtl,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
    duration: Duration(seconds: seconds),
    animationDuration: Duration(milliseconds: 600),
    margin: EdgeInsets.all(8),
    //borderRadius: BorderRadius.circular(8),
    isDismissible: true,
    flushbarPosition: flushbarPosition,
    backgroundColor: Colors.transparent,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.decelerate,
  )..show(context);
}