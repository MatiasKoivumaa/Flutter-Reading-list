import 'package:flutter/material.dart';

import './books.dart';
import './main.dart';

class BookList extends StatelessWidget {
  final String searchWord;
  final List<Book> allBooks;
  final Function addToFavorites;

  const BookList(this.searchWord, this.allBooks, this.addToFavorites, {Key key})
      : super(key: key);

  List<Book> get search {
    var foundBooks = <Book>[];
    if (searchWord.isNotEmpty) {
      var tempList = <Book>[];
      for (int i = 0; i < allBooks.length; i++) {
        if (allBooks[i].name.toLowerCase().contains(searchWord.toLowerCase())) {
          tempList.add(allBooks[i]);
        }
      }
      foundBooks = tempList;
    }
    return foundBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Books(search, addToFavorites);
  }
}
