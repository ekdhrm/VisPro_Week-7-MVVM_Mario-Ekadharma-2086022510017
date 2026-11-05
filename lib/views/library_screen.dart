import 'package:flutter/material.dart';
import '../viewmodels/catalogue_view_model.dart';
import '../viewmodels/library_view_model.dart';
import 'borrowed_books_screen.dart';
import 'widgets/book_list.dart';
import 'widgets/catalogue_controls.dart';
import 'widgets/show_result.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({
    super.key,
    required this.library,
    required this.catalogue,
    required this.studentId,
  });

  final LibraryViewModel library;
  final CatalogueViewModel catalogue;
  final String studentId;

  void _openLoans(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BorrowedBooksScreen(library: library)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: 'My loans',
            onPressed: () => _openLoans(context),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([library, catalogue]),
        builder: (context, _) {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CatalogueControls(
                selected: catalogue.filter,
                onSearch: catalogue.setQuery,
                onFilter: catalogue.setFilter,
              ),
            ),
            Expanded(
              child: BookList(
                books: catalogue.visibleBooks,
                statusOf: catalogue.statusOf,
                onBorrow: (book) => showResult(
                  context,
                  library.borrowBook(book.id, studentId),
                  'Book borrowed.',
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
