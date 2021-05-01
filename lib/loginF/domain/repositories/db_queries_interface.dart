 import 'package:lottery_app/core/service_locator.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';

abstract class DBQueriesInterface {

    Future<void> registerUser(context);
  }