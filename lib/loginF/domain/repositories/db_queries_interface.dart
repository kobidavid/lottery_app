 import 'package:lottery_app/core/service_locator.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';

abstract class DBQueriesInterface {

    Future<void> registerUser(context,bool isLoginMethod);
    Future<bool> checkIfUserEmailOrPassExist(context,String email,String phone);
    Future<bool> checkIfEmailExist(context);
    Future<bool> checkIfPhoneExist(context,String phoneNumber);
    Future<bool> checkIfEmailExistInFireStore(context,String email);
  }