import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //You can run also the command below:
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Firestore.instance.collection(city).document('Attractions').updateData({"data": FieldValue.arrayUnion(obj)});

  Future<void> addUser(
      List<List<List<int?>>> myIntList,
      List<List<List<int?>>> myIntStrongList,
      numOfRows,
      String? userDocId,
      int? price) async {
    Map? map4Firstore = Map<String, List<int>>();

    for (int i = 0; i < (numOfRows * 2 + 2); i++) {
      map4Firstore['$i'] = myIntList[0][i] + myIntStrongList[0][i];
    }

    print(map4Firstore);
    DateTime _startDate = DateTime.now();
    for (int i = 0; i < 2; i++) {
      users
          // .collection('users')   //while using command in row 4
          .doc(userDocId) //ID
          .collection('Tickets') //ticket ID
          .doc(_startDate.toString()) //ID
          .set(map4Firstore[0])
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
