import '../models/book.dart';
import '../models/loan.dart';

/// Borrowing validation. Returns an error message, or null if allowed.
class BorrowRules {
  static String? validate(
    List<Book> books,
    List<Loan> loans,
    String bookId,
    String studentId,
  ) {
    final matches = books.where((b) => b.id == bookId);
    if (matches.isEmpty) return 'Book not found.';
    if (studentId.trim().isEmpty) return 'Student ID is required.';
    final taken = loans.any((l) => l.isActive && l.bookId == bookId);
    if (!matches.first.isAvailable || taken) {
      return 'This book is not available.';
    }
    return null;
  }
}
