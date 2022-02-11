import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './favorites.dart';
import './books.dart';
import './book_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Future<List<BookItem>> futureBook;
  final _filter = TextEditingController();
  var _foundBooks = <BookItem>[];
  final _favoritedBooks = <BookItem>[];
  var _searchWord = "";
  Icon _searchIcon = const Icon(
    Icons.search,
    size: 32,
  );
  Icon _favoritesIcon = const Icon(
    Icons.favorite_outline,
    size: 32,
  );
  Widget _appBarTitle = const Text("Reading list");
  bool _favorites = false;

  _MyAppState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchWord = "";
        });
      } else {
        setState(() {
          _searchWord = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    futureBook = fetchBooks();
  }

  Future<List<BookItem>> fetchBooks() async {
    final res = await http.get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=harry+potter+and+inauthor:rowling&printType=books&maxResults=15"));
    if (res.statusCode == 200) {
      final jsonRes = json.decode(res.body);

      List<BookItem> books = (jsonRes["items"] as List)
          .map((data) => data["volumeInfo"]["imageLinks"] != null
              ? BookItem.fromJson(data)
              : BookItem.imageLinkFromJson(data))
          .toList();
      return books;
    } else {
      throw Exception("Unexpected error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: _buildBar(context),
          body: FutureBuilder<List<BookItem>>(
            future: futureBook,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<BookItem> books = snapshot.data;
                return !_favorites
                    ? Books(books, _addToFavorites)
                    : Favorites(_favoritedBooks, _addToFavorites);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          )),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: _favoritesIcon,
            onPressed: _favoritesPressed,
          ),
        )
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Search for books...",
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text("Reading list");
        //_foundBooks = _allBooks;
        _filter.clear();
      }
    });
  }

  void _favoritesPressed() {
    if (!_favorites) {
      setState(() {
        _favorites = true;
        _favoritesIcon = const Icon(
          Icons.home_outlined,
          size: 32,
        );
      });
    } else {
      setState(() {
        _favorites = false;
        _favoritesIcon = const Icon(
          Icons.favorite_outline,
          size: 32,
        );
      });
    }
  }

  void _addToFavorites(BookItem book) {
    if (book.addedToList) {
      setState(() {
        book.favorite();
        _favoritedBooks.add(book);
      });
    } else {
      setState(() {
        book.unFavorite();
        _favoritedBooks.remove(book);
      });
    }
  }
}
