import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './book_model.dart';
import './favorites.dart';
import './books.dart';
import 'package:flutter_app/login.dart';

class BookPage extends StatefulWidget {
  final User user;
  const BookPage(this.user, {Key key}) : super(key: key);
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: _buildBar(context),
      body: FutureBuilder<List<BookItem>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BookItem> books = snapshot.data;
            return !_favorites
                ? Books(books, widget.user, _addToFavorites)
                : Favorites(widget.user, _removeFromFavorites);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              heightFactor: 3,
              child: _filter.text.isNotEmpty
                  ? const Text(
                      "No books found",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<BookItem>> futureBook;
  final _favoritedBooks = <BookItem>[];
  final _filter = TextEditingController();
  String _apiUrl =
      'https://www.googleapis.com/books/v1/volumes?q=inauthor:stephen+king&printType=books&maxResults=15&langRestrict=en';
  Icon _searchIcon = const Icon(
    Icons.search,
    size: 33,
  );
  Icon _favoritesIcon = const Icon(
    Icons.favorite_outline,
    size: 32,
  );
  final Icon _logOutIcon = const Icon(
    Icons.logout_outlined,
    size: 32,
  );
  Widget _appBarTitle = const Text("Reading list");
  bool _favorites = false;

  _BookPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _apiUrl =
              'https://www.googleapis.com/books/v1/volumes?q=inauthor:stephen+king&printType=books&maxResults=15&langRestrict=en';
        });
      } else {
        setState(() {
          _apiUrl =
              'https://www.googleapis.com/books/v1/volumes?q="${_filter.text}"&printType=books&maxResults=15';
        });
      }
    });
  }

  Future<List<BookItem>> fetchBooks() async {
    List<BookItem> books;
    final res = await http.get(Uri.parse(_apiUrl));
    if (res.statusCode == 200) {
      final jsonRes = json.decode(res.body);
      if (jsonRes["totalItems"] > 0) {
        books = (jsonRes["items"] as List)
            .map((data) => data["volumeInfo"]["title"] == null
                ? BookItem.noTitleFromJson(data)
                : data["volumeInfo"]["authors"] != null &&
                        data["volumeInfo"]["imageLinks"] != null
                    ? BookItem.fromJson(data)
                    : data["volumeInfo"]["authors"] == null &&
                            data["volumeInfo"]["imageLinks"] == null
                        ? BookItem.noAuthorImageFromJson(data)
                        : data["volumeInfo"]["imageLinks"] == null
                            ? BookItem.noImageFromJson(data)
                            : BookItem.noAuthorFromJson(data))
            .toList();
      }
      if (books != null) {
        books.removeWhere((item) => item.title == "");
        books.removeWhere((item) => item.author == "");
        for (int i=0; i<books.length; i++) {
          for (int y=0; y<_favoritedBooks.length; y++) {
            if (_favoritedBooks[y].title == books[i].title) {
              books.removeAt(i);
            }
          }
        }
      }
      return books;
    } else {
      throw Exception("Unexpected error occurred.");
    }
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.deepPurple.shade400,
      toolbarHeight: 70,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 22,
      ),
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: _favoritesIcon,
            onPressed: _favoritesPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: IconButton(
            icon: _logOutIcon,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(
          Icons.close,
          size: 31,
        );
        _appBarTitle = TextField(
          controller: _filter,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: " Search for books...",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        _searchIcon = const Icon(
          Icons.search,
          size: 33,
        );
        _appBarTitle = const Text("Reading list");
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
    setState(() {
      _favoritedBooks.add(book);
    });
  }

  void _removeFromFavorites(String title) {
    setState(() {
      _favoritedBooks.removeWhere((book) => book.title == title);
    });
  }
}
