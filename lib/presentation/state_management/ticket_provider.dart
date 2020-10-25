import 'package:flutter/cupertino.dart';
import 'package:lottery_app/data/firestore_service.dart';
import 'package:lottery_app/domain/entities/ticket.dart';
import 'package:lottery_app/domain/usecases/marked_num_of_desired_rows.dart';

class TicketProvider extends ChangeNotifier {
  Ticket ticket = Ticket();

  List<bool> get getMarkNumOfRows => Ticket.markNumOfRows;

  //List<List<List<bool>>> get getListOfAllTables => listOfAllTables;

  List<List<List<bool>>> get getAllTablesNumbers => Ticket.listOfAllTables;
  static int currentNumOnRow = 6;

  void desireNumOfRows(int numOfRow) {
    ticket.setMarkNumOfRows(numOfRow);
    ticket.setMarkNumOfRows(currentNumOnRow);

    currentNumOnRow = numOfRow;
    //tablesNumbers(numOfRow);
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
    print('sss');
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

// Creating 2 int list - for regular num and strong num
  void transferBoolArrayToInt() {
    List<List<List<int>>> myIntList =
        List.generate(1, (index) => List.generate(14, (i) => []));
    List<List<List<int>>> myIntStrongList =
        List.generate(1, (index) => List.generate(14, (i) => []));

    //prepare a strong list
    for (int i = 0; i < ((currentNumOnRow * 2) + 2); i++) {
      for (int j = 0; j < 7; j++) {
        if (Ticket.listOfAllTablesStrongNum[0][i][j] == true) {
          myIntStrongList[0][i].add(j + 1);
        } else {}
      }
    }

    for (int i = 0; i < ((currentNumOnRow * 2) + 2); i++) {
      for (int j = 0; j < 37; j++) {
        if (Ticket.listOfAllTables[0][i][j] == true) {
          if (myIntList[0][i].length == 6) {
            print('d');
            myIntList[0][i].add(myIntStrongList[0][i][0]);
          } else {
            myIntList[0][i].add(j + 1);
          }
        } else {}
      }
    }

    for (int i = 0; i < ((currentNumOnRow * 2) + 2); i++) {
      if (myIntList[0][i].length != 6) {
        ticketIsOkCounter++;
      }
      ;
    }

    for (int i = 0; i < ((currentNumOnRow * 2) + 2); i++) {
      if (myIntStrongList[0][i].length != 1) {
        ticketIsOkCounterStrongNum++;
      }

    }
    if(ticketIsOkCounter==0 &&ticketIsOkCounterStrongNum==0){
      ticketIsOkCounter = 0;
      ticketIsOkCounterStrongNum = 0;
      FirestoreService firestoreService=FirestoreService();
      firestoreService.addUser(myIntList,myIntStrongList);

    }
    else{
      ticketIsOkCounter = 0;
      ticketIsOkCounterStrongNum = 0;
      //return false;
    }
  }
}