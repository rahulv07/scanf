import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final String userId;
  final String collection;
  DataBase({required this.collection, required this.userId});

  Future<void> setData() async {
    final firestore = Firestore.instance;
    await firestore.collection(collection).document(userId).setData(
        {"in": FieldValue.arrayUnion([]), "out": FieldValue.arrayUnion([])});
  }

  Future<void> writeCheckIn({var timestamp}) async {
    final firestore = Firestore.instance;
    var shouldCheckin = await _shouldCheckIn();
    if (shouldCheckin) {
      firestore.collection(collection).document(userId).updateData({
        "in": FieldValue.arrayUnion([timestamp])
      }).then((value) => print("Success\n"));
    } else {
      firestore.collection(collection).document(userId).updateData({
        "in": FieldValue.arrayUnion([timestamp]),
        "out": FieldValue.arrayUnion(["NA"])
      }).then((value) => print("Success\n"));
    }
  }

  Future<void> writeCheckOut({var timestamp}) async {
    final firestore = Firestore.instance;
    var shouldCheckout = await _shouldCheckOut();
    if (shouldCheckout) {
      firestore.collection(collection).document(userId).updateData({
        "out": FieldValue.arrayUnion([timestamp])
      }).then((value) => print("Success\n"));
    } else {
      firestore.collection(collection).document(userId).updateData({
        "out": FieldValue.arrayUnion([timestamp]),
        "in": FieldValue.arrayUnion(["NA"])
      }).then((value) => print("Success\n"));
    }
  }

  Future<bool> _shouldCheckIn() async {
    final firestore = Firestore.instance;

    var docSnapShot =
        await firestore.collection(collection).document(userId).get();
    var response = docSnapShot.data;

    if (response["in"].length == response["out"].length) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _shouldCheckOut() async {
    final firestore = Firestore.instance;

    var docSnapShot =
        await firestore.collection(collection).document(userId).get();
    var response = docSnapShot.data;

    if (response["in"].length > response["out"].length) {
      return true;
    } else {
      return false;
    }
  }
}
