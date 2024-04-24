import 'package:flutter/material.dart';
import '../db/books_database.dart';
import '../model/book.dart';
import 'edit_book_page.dart';
import '../widget/book_card_widget.dart';
import '../page/book_detail_page.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late List<Book> books;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshBooks();
  }

  @override
  void dispose() {
    BooksDatabase.instance.close();

    super.dispose();
  }

  Future refreshBooks() async {
    setState(() {
      isLoading = true;
    });

    books = await BooksDatabase.instance.readAllBooks();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Your Books',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: const [Icon(Icons.search), SizedBox(width: 12,)],
      ),

      body: Center(
        child: isLoading ? CircularProgressIndicator() :
          books.isEmpty ? const Text('There are no books here', style: TextStyle(color: Colors.white, fontSize: 24)) :
          buildBooks(),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditBookPage()),
          );

          refreshBooks();
        },
      ),
    );
  }

  // Widget buildBooks() => StaggeredGrid.count(
  //   crossAxisCount: 2,
  //   mainAxisSpacing: 2,
  //   crossAxisSpacing: 2,
  //   children: List.generate(
  //     books.length,
  //     (index) {
  //       final book = books[index];

  //       return StaggeredGridTile.fit(
  //         crossAxisCellCount: 1,
  //         child: GestureDetector(
            // onTap: () async {
            //   await Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => 
            //       BookDetailPage(bookId: book.id!)
            //     )
            //   );

            //   refreshBooks();
            // },

  //           child: BookCardWidget(book: book, index: index),
  //         ),
  //       );
  //     }
  //   ),
  // );

  // Widget buildBooks() {
  //   return ListView.builder(
  //       itemCount: books.length,
  //       itemBuilder: (context, index) {
  //         return BookCardWidget(book: books[index], index: index);
  //       },
        
  //     );
  // }

  Widget buildBooks() {
    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => 
                  BookDetailPage(bookId: books[index].id!)
                )
              );

              refreshBooks();
            },
                title: Text(books[index].title),
                leading: CircleAvatar(
                  backgroundImage:NetworkImage(books[index].coverUrl),
                ),
              )
            )
          );
        },
      );
  }
}