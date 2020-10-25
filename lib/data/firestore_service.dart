import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //You can run also the command below:
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Firestore.instance.collection(city).document('Attractions').updateData({"data": FieldValue.arrayUnion(obj)});

  Future<void> addUser(
      List<List<List<int>>> myIntList, List<List<List<int>>> myIntStrongList) {
    for (int i = 0; i < 2; i++) {
      return users
          // .collection('users')   //while using command in row 4
          .doc('040210833') //ID
          .collection('Tickets') //ticket ID
          .doc('103') //ID
         // .collection('Tickets')
          .set({'${i+1}': myIntList[0][i] + myIntStrongList[0][i]})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
