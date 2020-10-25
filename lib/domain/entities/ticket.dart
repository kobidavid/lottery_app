import 'dart:math';

import 'package:flutter/cupertino.dart';

class Ticket{

  static List <bool>markNumOfRows= [false,false,false,false,false,false,true];
  static List<List<List<bool>>> listOfAllTables= List.generate(1, (index) => List.generate(14, (index) => List.generate(37, (index) => false)));
  static List<List<List<bool>>> listOfAllTablesStrongNum= List.generate(1, (index) => List.generate(14, (index) => List.generate(7, (index) => false)));



  List<bool> get getMarkNumOfRows => markNumOfRows;

  void setMarkNumOfRows(int numOfRow) {

    markNumOfRows[numOfRow] = !markNumOfRows[numOfRow];
  }



  List<List<List<bool>>> get getListOfAllTables => listOfAllTables;

  void setListOfAllTables(int rowNum,int num) {

int valueReg=0;
    valueReg = listOfAllTables[0][rowNum].where((item) => item == true).length;
    if (valueReg<6) {
      listOfAllTables[0][rowNum][num] =
      !listOfAllTables[0][rowNum][num];
    }else if (valueReg==6){
      if(listOfAllTables[0][rowNum][num]==true){
        listOfAllTables[0][rowNum][num] =
        !listOfAllTables[0][rowNum][num];
      }
    }
    //listOfAllTables[0][rowNum][num] = !listOfAllTables[0][rowNum][num];
  }

  List<List<List<bool>>> get getListOfAllTablesStrongNum => listOfAllTablesStrongNum;

  int value=0;

  void setListOfAllTablesStrongNum(int rowNum,int num) {
    value = listOfAllTablesStrongNum[0][rowNum].where((item) => item == true).length;
    if (value<1) {
      listOfAllTablesStrongNum[0][rowNum][num] =
      !listOfAllTablesStrongNum[0][rowNum][num];
    }else{
      if(listOfAllTablesStrongNum[0][rowNum][num]==true){
        listOfAllTablesStrongNum[0][rowNum][num] =
        !listOfAllTablesStrongNum[0][rowNum][num];
      }else {
        listOfAllTablesStrongNum[0][rowNum] =
        [false, false, false, false, false, false, false];
        listOfAllTablesStrongNum[0][rowNum][num] =
        !listOfAllTablesStrongNum[0][rowNum][num];
      }
    }
  }

  void deleteCurrentRow(int rowNum){
    listOfAllTables[0][rowNum]=[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
    listOfAllTablesStrongNum[0][rowNum]=[false,false,false,false,false,false,false];
  }

  void randomRow(int rowNum){
    var listReg = new List<int>.generate(37, (int index) => index); // [0, 1, 4]
    deleteCurrentRow(rowNum);
    listReg.shuffle();
    for(int i=0;i<6;i++) {
      listOfAllTables[0][rowNum][listReg[i]] = true;
    }

    var listStrong = new List<int>.generate(7, (int index) => index); // [0, 1, 4]

    listStrong.shuffle();
    for(int i=0;i<1;i++) {
      listOfAllTablesStrongNum[0][rowNum][listStrong[i]] = true;
    }

  }



}