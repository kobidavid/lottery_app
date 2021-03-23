import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery_app/core/constants/app_colors.dart';
import 'package:lottery_app/presentation/pages/regular_ticket.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:provider/provider.dart';

import 'desired_num_button.dart';
class Abc extends StatefulWidget {
  @override
  _AbcState createState() => _AbcState();
}

class _AbcState extends State<Abc> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

oneLuckyTable(BuildContext context, int rowNumber) {
  return Consumer<TicketProvider>(builder: (context, ticketProviderr, child) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 105,
        //color: rowNumber % 2 == 0 ? Colors.pink.shade100 : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: rowNumber % 2 == 0
                  ? AppColors.PINK_BACKGROUND_COLOR
                  : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Container(
                      margin: EdgeInsets.all(0),
                      height: 10,
                      padding: EdgeInsets.all(0),
                      width: 19,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: FaIcon(
                          FontAwesomeIcons.magic,
                          color: Colors.indigo,
                          size: 16,
                        ),
                        onPressed: () {
                          ticketProviderr.randomRow(rowNumber);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(0),
                      height: 10,
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: FaIcon(
                          FontAwesomeIcons.trashAlt,
                          color: AppColors.RED_BUTTON_BORDER_COLOR,
                          size: 16,
                        ),
                        onPressed: () {
                          ticketProviderr.deleteCurrentRow(rowNumber);
                        },
                      ),
                    ),
                    DesignButton(
                        number: 1, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 2, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 3, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 4, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 5, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 6, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 7, rowNum: rowNumber, isStrongNum: false),
                  ]),
                  Row(children: [
                    DesignButton(
                        number: 8, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 9, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 10, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 11, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 12, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 13, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 14, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 15, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 16, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 17, rowNum: rowNumber, isStrongNum: false),
                  ]),
                  Row(children: [
                    DesignButton(
                        number: 18, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 19, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 20, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 21, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 22, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 23, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 24, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 25, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 26, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 27, rowNum: rowNumber, isStrongNum: false),
                  ]),
                  Row(children: [
                    DesignButton(
                        number: 28, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 29, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 30, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 31, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 32, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 33, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 34, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 35, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 36, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 37, rowNum: rowNumber, isStrongNum: false),
                  ]),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: VerticalDivider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            Container(
              color: rowNumber % 2 == 0
                  ? Colors.white
                  : AppColors.PINK_BACKGROUND_COLOR,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 1, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 2, rowNum: rowNumber, isStrongNum: true),
                      DesignButton(
                          number: 3, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 4, rowNum: rowNumber, isStrongNum: true),
                      DesignButton(
                          number: 5, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 6, rowNum: rowNumber, isStrongNum: true),
                      DesignButton(
                          number: 7, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  });
}