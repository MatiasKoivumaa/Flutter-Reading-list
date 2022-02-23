import 'package:flutter/material.dart';

class BookItem {
  String title = "";
  String author = "";
  String imageLink = "";
  bool addedToList = false;
  Icon icon = const Icon(
    Icons.favorite_outline,
    color: Colors.red,
    size: 32,
  );

  BookItem({this.title, this.author, this.imageLink});
  BookItem.titleNull();
  BookItem.imageNull({this.title, this.author});
  BookItem.authorNull({this.title, this.imageLink});
  BookItem.authorAndImageNull({this.title});


  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      title: json["volumeInfo"]["title"],
      author: json["volumeInfo"]["authors"][0],
      imageLink: json["volumeInfo"]["imageLinks"]["thumbnail"],
    );
  }
  factory BookItem.noTitleFromJson(Map<String, dynamic> json) {
    return BookItem.titleNull(
    );
  }
  factory BookItem.noImageFromJson(Map<String, dynamic> json) {
    return BookItem.imageNull(
      title: json["volumeInfo"]["title"],
      author: json["volumeInfo"]["authors"][0],
    );
  }
  factory BookItem.noAuthorFromJson(Map<String, dynamic> json) {
    return BookItem.authorNull(
      title: json["volumeInfo"]["title"],
      imageLink: json["volumeInfo"]["imageLinks"]["thumbnail"],
    );
  }
  factory BookItem.noAuthorImageFromJson(Map<String, dynamic> json) {
    return BookItem.authorAndImageNull(
      title: json["volumeInfo"]["title"],
    );
  }

  void favorite() {
    icon = const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 32,
    );
  }

  void unFavorite() {
    icon = const Icon(
      Icons.favorite_outline,
      color: Colors.red,
      size: 32,
    );
  }
}