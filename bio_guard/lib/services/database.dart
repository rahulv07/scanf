import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final userId;
  final collection;
  DataBase({this.collection, this.userId});

  void setData() {
    final firestore = Firestore.instance;
    firestore.collection(collection).document(userId).setData(
        {"in": FieldValue.arrayUnion([]), "out": FieldValue.arrayUnion([])});
  }

  void checkIn({var timestamp}) {
    final firestore = Firestore.instance;
    firestore.collection(collection).document(userId).updateData({
      "in": FieldValue.arrayUnion([timestamp])
    }).then((value) => print("Success\n"));
  }

  void checkOut({var timestamp}) {
    final firestore = Firestore.instance;
    firestore.collection(collection).document(userId).updateData({
      "out": FieldValue.arrayUnion([timestamp])
    }).then((value) => print("Success\n"));
  }
}
