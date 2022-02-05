import 'package:flutter/material.dart';

import './books.dart';
import './favorites.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class Book {
  int id;
  String name;
  Image image;
  bool addedToList = false;
  Icon icon = const Icon(
    Icons.favorite_outline,
    color: Colors.white,
    size: 30,
  );

  Book(this.id, this.name, this.image);

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

class _MyAppState extends State<MyApp> {
  final _filter = TextEditingController();
  final _allBooks = <Book>[];
  var _foundBooks = <Book>[];
  final _favoritedBooks = <Book>[];
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

  static const _books = [
    {
      "image": Image(
        image: AssetImage("graphics/BillySummers.jpg"),
      ),
      "name": "Stephen King Billy Summers",
    },
    {
      "image": Image(
        image: AssetImage("graphics/KuolemaJoulupaivana.jpg"),
      ),
      "name": "P.D.James Kuolema joulupäivänä",
    },
    {
      "image": Image(
        image: AssetImage("graphics/LevotonVeri.jpg"),
      ),
      "name": "Robert Galbraith Levoton veri",
    },
    {
      "image": Image(
        image: AssetImage("graphics/LohikaarmeenIsku.jpg"),
      ),
      "name": "Ilkka Remes Lohikäärmeen isku",
    },
    {
      "image": Image(
        image: AssetImage("graphics/Mentalisti.jpg"),
      ),
      "name": "Camilla Läckberg Henrik Fexeus Mentalisti",
    },
    {
      "image": Image(
        image: AssetImage("graphics/Merilokki.jpg"),
      ),
      "name": "Ann Cleeves Merilokki",
    },
    {
      "image": Image(
        image: AssetImage("graphics/MuukalaisenPaivakirjat.jpg"),
      ),
      "name": "Elly Griffiths Muukalaisen päiväkirjat",
    },
    {
      "image": Image(
        image: AssetImage("graphics/Napapiiri.jpg"),
      ),
      "name": "Liza Marklund Napapiiri",
    }
  ];

  _MyAppState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchWord = "";
          _foundBooks = _allBooks;
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
    for (int i = 0; i < _books.length; i++) {
      _allBooks.add(Book(i, _books[i]["name"], _books[i]["image"]));
      _foundBooks.add(Book(i, _books[i]["name"], _books[i]["image"]));
    }
    super.initState();
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: _buildBar(context),
          body: !_favorites
              ? Container(
                  child: _buildList(),
                )
              : Favorites(_favoritedBooks, _addToFavorites)),
    );
  }

  Widget _buildList() {
    if (_searchWord.isNotEmpty) {
      var tempList = <Book>[];
      for (int i = 0; i < _allBooks.length; i++) {
        if (_allBooks[i]
            .name
            .toLowerCase()
            .contains(_searchWord.toLowerCase())) {
          tempList.add(_allBooks[i]);
        }
      }
      _foundBooks = tempList;
    }
    return Books(_foundBooks, _addToFavorites);
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
        _foundBooks = _allBooks;
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

  void _addToFavorites(Book book) {
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
