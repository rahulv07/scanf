import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final userId;
  DataBase({this.userId});

  void writeData({var collection, var timestamp}) {
    final firestore = Firestore.instance;
    firestore.collection(collection).document(userId).setData({
      "in": FieldValue.arrayUnion([timestamp]),
      "out": FieldValue.arrayUnion([timestamp])
    });
  }
}
