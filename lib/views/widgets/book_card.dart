import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../models/book_status.dart';
import '../formatters.dart';
import 'status_chip.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.status,
    required this.onBorrow,
  });

  final Book book;
  final BookStatus status;
  final VoidCallback onBorrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title, style: theme.textTheme.titleMedium),
                  Text(book.author),
                  Text('Replacement: ${formatRupiah(book.replacementPrice)}'),
                  const SizedBox(height: 8),
                  StatusChip.book(theme.colorScheme, status),
                ],
              ),
            ),
            FilledButton(onPressed: onBorrow, child: const Text('Borrow')),
          ],
        ),
      ),
    );
  }
}
