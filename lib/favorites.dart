import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './dataBase.dart';

class Favorites extends StatelessWidget {
  final User user;
  final Function removeFromFavorites;

  const Favorites(this.user, this.removeFromFavorites, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.readItems(user: user),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        } else if (snapshot.hasData) {
          return snapshot.data.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemExtent: 150,
                  padding: const EdgeInsets.all(7),
                  itemBuilder: (context, index) {
                    var bookInfo = snapshot.data.docs[index];
                    var id = snapshot.data.docs[index].id;
                    String title = bookInfo["title"];
                    String author = bookInfo["author"];
                    String imageLinks = bookInfo["imageLink"];
                    return Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.23,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.23,
                                ),
                                child: imageLinks != ""
                                    ? Image.network(
                                        imageLinks,
                                        fit: BoxFit.fill,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            "graphics/image_missing.png"),
                                      ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 6, 0, 0),
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 10, 0, 6),
                                    child: Text(
                                      author,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: IconButton(
                                onPressed: () {
                                  DataBase.deleteItem(user: user, docId: id);
                                  removeFromFavorites(title);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 32,
                                ),
                              ),
                            )
                          ],
                        ));
                  },
                )
              : const Center(
                  heightFactor: 3,
                  child: Text(
                    "Reading list is empty",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
        } else {
          return const Text("");
        }
      },
    );
  }
}
