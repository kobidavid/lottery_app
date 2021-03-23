

import 'package:flutter/cupertino.dart';

class RegisterProvider extends ChangeNotifier{

  int a=10;
  void checkIfTrue(){
    a=20;
    notifyListeners();
  }

}