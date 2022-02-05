import 'package:flutter/material.dart';

import 'package:flutter_app/main.dart';

class Favorites extends StatelessWidget {
  final List<Book> favoriteBooks;
  final Function changeIcon;

  const Favorites(this.favoriteBooks, this.changeIcon, {Key key})
      : super(key: key);

  List<Image> get image {
    var images = <Image>[];
    for (int i = 0; i < favoriteBooks.length; i++) {
      images.add(favoriteBooks[i].image);
    }
    return images;
  }

  void checkPressed(Book book) {
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
        ? GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: favoriteBooks.length,
            itemBuilder: (BuildContext context, index) {
              return GridTile(
                  key: ValueKey(favoriteBooks[index].id),
                  child: image[index],
                  footer: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: favoriteBooks[index].addedToList
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
                      onPressed: () => checkPressed(favoriteBooks[index]),
                      icon: favoriteBooks[index].icon,
                    ),
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
  }
}
