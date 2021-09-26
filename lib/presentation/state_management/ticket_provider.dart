import 'package:flutter/cupertino.dart';
import 'package:lottery_app/domain/entities/ticket.dart';

class TicketProvider extends ChangeNotifier {
  late Ticket ticket = Ticket();
  static int currentNumOnTables = 6;
  int get numOfTables => (currentNumOnTables + 1) * 2;

  List<bool> get getMarkNumOfRows => Ticket.markNumOfRows;

  //List<List<List<bool>>> get getListOfAllTables => listOfAllTables;

  List<List<List<bool>>> get getAllTablesNumbers => Ticket.listOfAllTables;

  static bool buttonAtTheMiddle = false;
  static bool missing_checkboxes = true;

  void setNumOfTables(int numOfRow) {
    ticket.setMarkNumOfRows(numOfRow);
    ticket.setMarkNumOfRows(currentNumOnTables);
    currentNumOnTables = numOfRow;
    notifyListeners();
  }

  bool getTablesNumbers(int rowNum, int num) {
    return ticket.getListOfAllTables[0][rowNum][num];
  }

  void updateTables(int numOfRow, int num) {
    ticket.setListOfAllTables(numOfRow, num);
    notifyListeners();
  }

  bool getTablesStrongNumbers(int rowNum, int num) {
    return ticket.getListOfAllTablesStrongNum[0][rowNum][num];
  }

  void updateStrongTables(int numOfRow, int num) {
    ticket.setListOfAllTablesStrongNum(numOfRow, num);
    print('you replace strong num row:$numOfRow strongnum:$num+1');
    notifyListeners();
  }

  void deleteCurrentRow(int rowNum) {
    ticket.deleteCurrentRow(rowNum);
    notifyListeners();
  }

  void randomRow(int rowNum) {
    ticket.randomRow(rowNum);
    notifyListeners();
  }

  static int ticketIsOkCounter = 0;
  static int ticketIsOkCounterStrongNum = 0;

  static late List<List<List<int?>>> myIntList;
  static late List<List<List<int?>>> myIntStrongList;
// Creating 2 int list - for regular num and strong num
  void transferBoolArrayToInt() {
    //List<List<List<int>>> myIntList =
    myIntList = List.generate(1, (index) => List.generate(14, (i) => []));
    myIntStrongList = List.generate(1, (index) => List.generate(14, (i) => []));

    //prepare a strong list
    for (int i = 0; i < ((currentNumOnTables * 2) + 2); i++) {
      for (int j = 0; j < 7; j++) {
        if (Ticket.listOfAllTablesStrongNum[0][i][j] == true) {
          //
          myIntStrongList[0][i].add(j + 1);
        } else {}
      }
    }

    //prepare a list of regular number
    for (int i = 0; i < ((currentNumOnTables * 2) + 2); i++) {
      for (int j = 0; j < 37; j++) {
        if (Ticket.listOfAllTables[0][i][j] == true) {
          if (myIntList[0][i].length == 6) {
            print('d');
            myIntList[0][i].add(myIntList[0][i][0]);
          } else {
            myIntList[0][i].add(j + 1);
          }
        } else {}
      }
    }

    for (int i = 0; i < ((currentNumOnTables * 2) + 2); i++) {
      if (myIntList[0][i].length != 6) {
        ticketIsOkCounter++;
      }
    }

    for (int i = 0; i < ((currentNumOnTables * 2) + 2); i++) {
      if (myIntStrongList[0][i].length != 1) {
        ticketIsOkCounterStrongNum++;
      }
    }
    if (ticketIsOkCounter == 0 && ticketIsOkCounterStrongNum == 0) {
      ticketIsOkCounter = 0;
      ticketIsOkCounterStrongNum = 0;
      missing_checkboxes = false;
      //FirestoreService firestoreService=FirestoreService();
      //firestoreService.addUser(myIntList,myIntStrongList,currentNumOnRow);

    } else {
      ticketIsOkCounter = 0;
      ticketIsOkCounterStrongNum = 0;
      //return false;
    }
  }

  positionOfSendButton(String buttonPosition) {
    if (buttonPosition == "center") {
      buttonAtTheMiddle = true;
    } else {
      buttonAtTheMiddle = false;
    }
    notifyListeners();
  }
}
