import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/core/constants/app_colors.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:provider/provider.dart';


class DesignButton extends StatelessWidget {
  final int number;
  final int rowNum;
  final bool isStrongNum;

  const DesignButton(
      {@required this.number,
        @required this.rowNum,
        @required this.isStrongNum});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      return Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 3),
          child: Center(
              child: GestureDetector(
                onTap: () {
                  if (isStrongNum == false) {
                    ticketProvider.updateTables(rowNum, number - 1);
                  } else if (isStrongNum == true) {
                    ticketProvider.updateStrongTables(rowNum, number - 1);
                  }
                },
                child: Text(
                  "$number",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.RED_BUTTON_BORDER_COLOR),
                ),
              )),
          height: 19,
          //width: MediaQuery.of(context).size.width / 13,
          width: MediaQuery.of(context).size.width / 13,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.RED_BUTTON_BORDER_COLOR),
              borderRadius: BorderRadius.circular(12),
              color: isStrongNum == true &&
                  ticketProvider.getTablesStrongNumbers(
                      rowNum, number - 1) ==
                      true
                  ? Colors.yellow
                  : (isStrongNum == false &&
                  ticketProvider.getTablesNumbers(rowNum, number - 1) ==
                      true
                  ? Colors.yellow
                  : Colors.white)));
    });
  }
}