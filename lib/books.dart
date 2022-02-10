import 'package:flutter/material.dart';
import 'package:flutter_app/book_model.dart';

import 'package:flutter_app/main.dart';

class Books extends StatelessWidget {
  final List<BookItem> books;
  final Function changeIcon;

  const Books(this.books, this.changeIcon, {Key key}) : super(key: key);

  /*List<Image> get image {
    var images = <Image>[];
    for (int i = 0; i < books.length; i++) {
      images.add(books[i].);
    }
    return images;
  }*/

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
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: books.length,
      itemBuilder: (BuildContext context, index) {
        return GridTile(
            key: ValueKey(books[index].id),
            child: books[index].imageLink != ""
                ? Image.network(
                    books[index].imageLink,
                    fit: BoxFit.fill,
                  )
                : const Image(
                    image: AssetImage("graphics/image_missing.png"),
                  ),
            footer: GridTileBar(
              backgroundColor: Colors.black45,
              title: books[index].addedToList
                  ? const Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      "Add to list",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              trailing: IconButton(
                onPressed: () => checkPressed(books[index]),
                icon: books[index].icon,
              ),
            ));
      },
    );
  }
}
