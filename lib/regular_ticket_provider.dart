
import 'package:flutter/cupertino.dart';

class RegularTicketProvider with ChangeNotifier{
  int a=2;
//list of numbers per Rows per Tickets per user
  List<List<List<List<int>>>>users_tickets_rows_num=List.generate(1, (index) => List.generate(2, (index) => List.generate(2, (index) => List.generate(6, (index) => index+1))));

  //print('${users_tickets_rows_num[0][1][1][3]}');


}