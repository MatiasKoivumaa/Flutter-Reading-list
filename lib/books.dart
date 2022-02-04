import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class Books extends StatelessWidget {
  final List<Book> books;

  Books(this.books);

  List<Image> get image {
    var images = <Image>[];
    for (int i=0; i<books.length; i++) {
      images.add(books[i].image);
    }
    return images;
  }

  /*List<Text> get name {
    var names = <Text>[];
    for (int i = 0; i < books.length; i++) {
      names.add(Text(
        books[i].name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
    }
    return names;
  }*/

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        children: image,
    );
  }
}
