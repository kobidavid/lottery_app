import 'package:get_it/get_it.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';

class GetItt {
  GetIt locator = GetIt.instance;

  void setupLocator() {
    locator.registerLazySingleton<UserEntity>(() => UserEntity());
  }
}
