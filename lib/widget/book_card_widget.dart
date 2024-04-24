import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/book.dart';
import '../page/book_detail_page.dart';
import '../page/books_page.dart';

class BookCardWidget extends StatelessWidget {
  const BookCardWidget({
    Key? key,
    required this.book,
    required this.index,
  }) : super(key: key);

  final Book book;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: ListTile(
          title: Text(book.title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(book.coverUrl),
          ),
        )
      );
  }
}