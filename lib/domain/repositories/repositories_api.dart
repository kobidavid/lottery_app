import 'package:lottery_app/data/repository_imp.dart';

abstract class FirebaseRepository {
  late Future<bool> checkIfUserExist;
}
