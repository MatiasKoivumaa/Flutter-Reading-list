import 'package:flutter/material.dart';

import './textField.dart';
import './books.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
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

  List<Map<String, Object>>_searchBooks() {
    var _foundBooks = <Map<String, Object>>[];
    for (int i = 0; i<_books.length; i++) {
      String name = _books[i]["name"];
      if (name.contains("Elly")) { //SEARCHWORD
        _foundBooks.add(_books[i]);
      }
    }
    return _foundBooks;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Reading List"),
      ),
      body: Column(
        children: [
          SearchField(),
          Books(_searchBooks()),
        ],
      ),
    ));
  }
}
