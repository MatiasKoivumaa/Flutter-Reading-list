import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/book_model.dart';
import './dataBase.dart';

class Favorites extends StatelessWidget {

  const Favorites({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemExtent: 150,
            padding: const EdgeInsets.all(7),
            itemBuilder: (BuildContext context, index) {
              var bookInfo = snapshot.data.docs[index].data();
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
                        minWidth: MediaQuery.of(context).size.width * 0.23,
                        maxWidth: MediaQuery.of(context).size.width * 0.23,
                      ),
                      child: snapshot.data.docs[index].data()["imageLink"] != ""
                          ? Image.network(
                              favoriteBooks[index].imageLink,
                              fit: BoxFit.fill,
                            )
                          : const Image(
                              image: AssetImage("graphics/image_missing.png"),
                            ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 6, 0, 0),
                          child: Text(
                            favoriteBooks[index].title,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 10, 0, 6),
                          child: Text(
                            favoriteBooks[index].author,
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
                      onPressed: () => checkPressed(favoriteBooks[index]),
                      icon: favoriteBooks[index].icon,
                    ),
                  )
                ],
              ));
            },
          );
        }
    },
  );
}}