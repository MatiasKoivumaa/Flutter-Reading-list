import 'package:flutter/material.dart';

import './books.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class Book {
  int id;
  String name;
  Image image;

  Book(this.id, this.name, this.image);
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _filter = new TextEditingController();

  final _allBooks = <Book>[];
  var _foundBooks = <Book>[];
  var _searchWord = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("Reading list");

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
        body: Container(
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (_searchWord.isNotEmpty) {
      List tempList = new List<Book>();
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
    return Books(_foundBooks);
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
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
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text("Reading list");
        _foundBooks = _allBooks;
        _filter.clear();
      }
    });
  }
}
