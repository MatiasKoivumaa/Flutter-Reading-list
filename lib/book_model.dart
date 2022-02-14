import 'package:flutter/material.dart';

class BookItem {
  final String id;
  String title = "";
  String author = "";
  String imageLink = "";
  bool addedToList = false;
  Icon icon = const Icon(
    Icons.favorite_outline,
    color: Colors.red,
    size: 32,
  );

  BookItem({this.id, this.title, this.author, this.imageLink});
  BookItem.titleNull({this.id});
  BookItem.imageNull({this.id, this.title, this.author});
  BookItem.authorNull({this.id, this.title, this.imageLink});
  BookItem.authorAndImageNull({this.id, this.title});

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json["id"],
      title: json["volumeInfo"]["title"],
      author: json["volumeInfo"]["authors"][0],
      imageLink: json["volumeInfo"]["imageLinks"]["thumbnail"],
    );
  }
  factory BookItem.noTitleFromJson(Map<String, dynamic> json) {
    return BookItem.titleNull(
      id: json["id"],
    );
  }
  factory BookItem.noImageFromJson(Map<String, dynamic> json) {
    return BookItem.imageNull(
      id: json["id"],
      title: json["volumeInfo"]["title"],
      author: json["volumeInfo"]["authors"][0],
    );
  }
  factory BookItem.noAuthorFromJson(Map<String, dynamic> json) {
    return BookItem.authorNull(
      id: json["id"],
      title: json["volumeInfo"]["title"],
      imageLink: json["volumeInfo"]["imageLinks"]["thumbnail"],
    );
  }
  factory BookItem.noAuthorImageFromJson(Map<String, dynamic> json) {
    return BookItem.authorAndImageNull(
      id: json["id"],
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