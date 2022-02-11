import 'package:flutter/material.dart';

class BookItem {
  final String id;
  final String title;
  final String author;

  String imageLink = "";
  bool addedToList = false;
  Icon icon = const Icon(
    Icons.favorite_outline,
    color: Colors.red,
    size: 30,
  );

  BookItem({this.id, this.title, this.author, this.imageLink});

  BookItem.imageNull({this.id, this.title, this.author});

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json["id"],
      title: json["volumeInfo"]["title"],
      author: json["volumeInfo"]["authors"][0],
      imageLink: json["volumeInfo"]["imageLinks"]["thumbnail"],
    );
  }

  factory BookItem.imageLinkFromJson(Map<String, dynamic> json) {
    return BookItem.imageNull(
      id: json["id"],
      title: json["volumeInfo"]["title"],
      author: json["volumeInfo"]["authors"][0],
    );
  }

  void favorite() {
    icon = const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 30,
    );
  }

  void unFavorite() {
    icon = const Icon(
      Icons.favorite_outline,
      color: Colors.red,
      size: 30,
    );
  }
}
