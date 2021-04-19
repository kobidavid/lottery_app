import 'package:flutter/material.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:provider/provider.dart';

class DesiredNumOfTables extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Consumer<TicketProvider>(builder: (context,ticketProvider,child){
      return Column(children: [
        Text('מספר טבלאות רצוי',style: TextStyle(color: Colors.white,fontSize: 20),),SizedBox(height: 3,),
        Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(0);}, child: Text("2",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[0]==true?Colors.red:Colors.white))))),
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(1);}, child: Text("4",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[1]==true?Colors.red:Colors.white))))),
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(2);}, child: Text("6",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[2]==true?Colors.red:Colors.white))))),
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(3);}, child: Text("8",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[3]==true?Colors.red:Colors.white))))),
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(4);}, child: Text("10",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[4]==true?Colors.red:Colors.white))))),
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(5);}, child: Text("12",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[5]==true?Colors.red:Colors.white))))),
          Container(width:40,height:40,decoration:BoxDecoration(color:Color(0xff472bff),borderRadius: BorderRadius.circular(8)),child: Center(child: GestureDetector(onTap: (){ticketProvider.desireNumOfRows(6);}, child: Text("14",style:  TextStyle( fontSize: 26,color: ticketProvider.getMarkNumOfRows[6]==true?Colors.red:Colors.white))))),

        ],),],);},
    );
  }
}