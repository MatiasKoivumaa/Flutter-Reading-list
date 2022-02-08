import 'package:flutter/material.dart';

class BookItem {
  final String id;
  final String title;
  final String imageLink;
  
  bool addedToList = false;
  Icon icon = const Icon(
    Icons.favorite_outline,
    color: Colors.white,
    size: 30,
  );

  BookItem({this.id, this.title, this.imageLink});

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json["id"],
      title: json["volumeInfo"]["title"],
      imageLink: json["volumeInfo"]["imageLinks"]["thumbnail"],
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
      color: Colors.white,
      size: 30,
    );
  }
}
