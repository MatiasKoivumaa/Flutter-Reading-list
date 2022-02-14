import 'package:flutter/material.dart';
import 'package:flutter_app/book_model.dart';

class Books extends StatelessWidget {
  final List<BookItem> books;
  final Function changeIcon;

  const Books(this.books, this.changeIcon, {Key key}) : super(key: key);

  void checkPressed(BookItem book) {
    if (book.addedToList) {
      book.addedToList = false;
    } else {
      book.addedToList = true;
    }
    changeIcon(book);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: books.length,
        itemExtent: 150,
        padding: const EdgeInsets.all(7),
        itemBuilder: (BuildContext context, index) {
          return Card(
              elevation: 5,
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.23,
                    maxWidth: MediaQuery.of(context).size.width * 0.23,
                  ),
                  child: books[index].imageLink != ""
                      ? Image.network(
                          books[index].imageLink,
                          fit: BoxFit.fill,
                        )
                      : const Image(
                          image: AssetImage("graphics/image_missing.png"),
                        ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 0, 0),
                      child: Text(
                        books[index].title,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 0, 6),
                      child: Text(
                        books[index].author,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: IconButton(
                  onPressed: () => checkPressed(books[index]),
                  icon: books[index].icon,
                ),
              )
            ],
          ));
        });
  }
}
