import 'package:flutter/material.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import '../widget/book_form_widget.dart';

class AddEditBookPage extends StatefulWidget {
  final Book? book;

  const AddEditBookPage({
    Key? key,
    this.book,
  }) : super(key: key);

  @override
  State<AddEditBookPage> createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String coverUrl;

  @override
  void initState() {
    super.initState();

    title = widget.book?.title ?? '';
    description = widget.book?.description ?? '';
    coverUrl = widget.book?.coverUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
        foregroundColor: Colors.white,
      ),

      body: Form(
        key: _formKey,
        child: BookFormWidget(
          title: title,
          description: description,
          coverUrl: coverUrl,
          onChangedTitle: (title) {
            setState(() {
              this.title = title;
            });
          },
          onChangedDescription: (description) {
            setState(() {
              this.description = description;
            });
          },
          onChangedCoverUrl: (coverUrl) {
            setState(() {
              this.coverUrl = coverUrl;
            });
          },
        )
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: isFormValid ? Colors.grey.shade500 : Colors.grey.shade800
        ),
        onPressed: addOrUpdateBook,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateBook() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.book != null;

      if (isUpdating) {
        await updateBook();
      } else {
        await addBook();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateBook() async {
    final book = widget.book!.copy(
      title: title,
      description: description,
      coverUrl: coverUrl
    );

    await BooksDatabase.instance.update(book);
  }

  Future addBook() async {
    final book = Book(
      title: title,
      createdTime: DateTime.now(),
      description: description,
      coverUrl: coverUrl,
    );

    await BooksDatabase.instance.create(book);
  }
}