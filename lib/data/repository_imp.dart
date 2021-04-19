import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottery_app/domain/repositories/repositories_api.dart';

class RepositoryImp extends FirebaseRepository{
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future userExists( aaa) async{
    // TODO: implement userExists
   await (users.doc("040210833").get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
      }
    }));
  }

  @override
  Future<void> addUser() {
    // TODO: implement addUser
    throw UnimplementedError();
  }



  /*Future<bool> userExists(String userId) async =>
      (await users.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
        }
      }));*/
}