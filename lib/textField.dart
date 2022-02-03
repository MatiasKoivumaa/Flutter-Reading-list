import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Search for books:",
        ),
      ),
    );
  }
}
