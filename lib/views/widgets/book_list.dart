import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../models/book_status.dart';
import 'book_card.dart';
import 'empty_state.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    required this.statusOf,
    required this.onBorrow,
  });

  final List<Book> books;
  final BookStatus Function(Book) statusOf;
  final ValueChanged<Book> onBorrow;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const EmptyState(
        icon: Icons.search_off,
        message: 'No books match your search or filter.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: books.length,
      itemBuilder: (_, i) => BookCard(
        book: books[i],
        status: statusOf(books[i]),
        onBorrow: () => onBorrow(books[i]),
      ),
    );
  }
}
