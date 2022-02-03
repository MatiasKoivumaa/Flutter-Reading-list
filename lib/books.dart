import 'package:flutter/material.dart';

class Books extends StatelessWidget {
  final List<Map<String, Object>> books;

  Books(@required this.books);

  List<Image> get images {
    var images = <Image>[];
    for (int i=0; i<books.length; i++) {
      images.add(books[i]["image"]);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        children: images,
      ),
    ));
  }
}
