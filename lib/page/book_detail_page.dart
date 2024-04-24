import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import 'edit_book_page.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;

  const BookDetailPage({
    Key? key,
    required this.bookId
  }) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Book book;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshBook();
  }

  Future refreshBook() async {
    setState(() {
      isLoading = true;
    });

    book = await BooksDatabase.instance.readBook(widget.bookId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
        foregroundColor: Colors.white,
      ),

      body: isLoading ? const Center(child: CircularProgressIndicator()) :
        Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: <Widget> [
              bookImage(),
              const SizedBox(height: 8),
              Text(
                book.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Added on ${DateFormat.yMMMd().format(book.createdTime)}',
                style: const TextStyle(color: Colors.white38),
              ),

              const SizedBox(height: 8),

              Text(
                book.description,
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ],
          )
        )
    );
  }

  Widget editButton() => IconButton(
    icon: const Icon(Icons.edit_outlined),
    onPressed: () async {
      if (isLoading) return;

      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddEditBookPage(book: book)
      ));

      refreshBook();
    },
  );

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await BooksDatabase.instance.delete(widget.bookId);

      Navigator.of(context).pop();
    },
  );

  Widget bookImage() {
    return Image(
        image: NetworkImage(book.coverUrl),
        errorBuilder: (context, error, stackTrace) => Text(
          'Could not load cover image!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.red
          ),
        ),
    );
  }
}