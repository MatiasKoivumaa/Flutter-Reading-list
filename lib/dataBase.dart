import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("books");

class DataBase {
  static String userUid;

  static Future<void> addItem(
      {String title, String author, String imageLink}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection("items").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "author": author,
      "imageLink": imageLink,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Books item added to the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference booksItemCollection =
        _mainCollection.doc(userUid).collection("items");
    return booksItemCollection.snapshots();
  }

  static Future<void> deleteItem({String docId}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection("items").doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => print("Books item added to the database"))
        .catchError((e) => print(e));
  }
}
