import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/book_status.dart';
import '../models/loan_status.dart';
import 'library_view_model.dart';

/// Search text, status filter, and book status for the catalogue screen.
class CatalogueViewModel extends ChangeNotifier {
  CatalogueViewModel(this._library);

  final LibraryViewModel _library;
  String _query = '';
  BookStatus? _filter;

  BookStatus? get filter => _filter;

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setFilter(BookStatus? value) {
    _filter = value;
    notifyListeners();
  }

  BookStatus statusOf(Book book) {
    final active = _library.activeLoans.where((l) => l.bookId == book.id);
    if (active.isEmpty) return BookStatus.available;
    return switch (_library.getOverdueStatus(active.first)) {
      LoanStatus.overdue => BookStatus.overdue,
      LoanStatus.missing => BookStatus.missing,
      _ => BookStatus.borrowed,
    };
  }

  List<Book> get visibleBooks {
    final text = _query.trim().toLowerCase();
    return _library.books.where((b) {
      final matchesText = b.title.toLowerCase().contains(text) ||
          b.author.toLowerCase().contains(text);
      return matchesText && (_filter == null || statusOf(b) == _filter);
    }).toList();
  }
}
