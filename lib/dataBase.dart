import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("books");

class DataBase {

  static Future<void> addItem(
      {User user, String title, String author, String imageLink}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user.uid).collection("items").doc(title);

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

  static Stream<QuerySnapshot> readItems({User user}) {
    CollectionReference booksItemCollection =
        _mainCollection.doc(user.uid).collection("items");
    return booksItemCollection.snapshots();
  }

  static Future<void> deleteItem({User user, String docId}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user.uid).collection("items").doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => print("Books item deleted from the database"))
        .catchError((e) => print(e));
  }
}
