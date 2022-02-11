import 'package:flutter/material.dart';
import 'package:flutter_app/book_model.dart';

class Favorites extends StatelessWidget {
  final List<BookItem> favoriteBooks;
  final Function changeIcon;

  const Favorites(this.favoriteBooks, this.changeIcon, {Key key})
      : super(key: key);

  void checkPressed(BookItem book) {
    if (book.addedToList) {
      book.addedToList = false;
    } else {
      book.addedToList = true;
    }
    changeIcon(book);
  }

  @override
  Widget build(BuildContext context) {
    return favoriteBooks.isNotEmpty
        ? ListView.builder(
            itemCount: favoriteBooks.length,
            itemExtent: 150,
            itemBuilder: (BuildContext context, index) {
              return Card(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.23,
                        maxWidth: MediaQuery.of(context).size.width * 0.23,
                      ),
                      child: favoriteBooks[index].imageLink != ""
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
                          padding: const EdgeInsets.fromLTRB(5, 6, 0, 0),
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
                          padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
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
                    width: MediaQuery.of(context).size.width * 0.19,
                    child: IconButton(
                      onPressed: () => checkPressed(favoriteBooks[index]),
                      icon: favoriteBooks[index].icon,
                    ),
                  )
                ],
              ));
            })
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
  }
}
