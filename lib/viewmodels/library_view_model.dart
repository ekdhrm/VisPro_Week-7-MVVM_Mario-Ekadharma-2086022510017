import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/loan.dart';
import '../models/loan_status.dart';
import 'borrow_rules.dart';
import 'fine_policy.dart';

class LibraryViewModel extends ChangeNotifier {
  LibraryViewModel({
    required List<Book> books,
    List<Loan> loans = const [],
    DateTime Function()? clock,
  })  : _books = List.of(books),
        _loans = List.of(loans),
        _now = clock ?? DateTime.now;

  final List<Book> _books;
  final List<Loan> _loans;
  final DateTime Function() _now;

  List<Book> get books => List.unmodifiable(_books);
  List<Loan> get loans => List.unmodifiable(_loans);
  List<Loan> get activeLoans => _loans.where((l) => l.isActive).toList();
  int get totalFines => _loans.fold(0, (sum, l) => sum + calculateFine(l));

  List<Loan> get overdueLoans => activeLoans.where((l) {
        return getOverdueStatus(l) != LoanStatus.borrowed;
      }).toList();

  Book bookOf(Loan loan) => _books.firstWhere((b) => b.id == loan.bookId);

  LoanStatus getOverdueStatus(Loan loan) => FinePolicy.statusFor(loan, _now());

  int calculateFine(Loan loan) {
    if (!loan.isActive) return loan.finalFine ?? 0;
    return FinePolicy.fineFor(loan, bookOf(loan).replacementPrice, _now());
  }

  /// Returns null on success, or an error message for the View to show.
  String? borrowBook(String bookId, String studentId) {
    final error = BorrowRules.validate(_books, _loans, bookId, studentId);
    if (error != null) return error;
    final today = FinePolicy.dateOnly(_now());
    _loans.add(Loan(
      loanId: 'L${_loans.length + 1}',
      bookId: bookId,
      studentId: studentId.trim(),
      borrowDate: today,
      dueDate: FinePolicy.dueDateFor(today),
    ));
    _setAvailability(bookId, false);
    notifyListeners();
    return null;
  }

  String? returnBook(String loanId) {
    final i = _loans.indexWhere((l) => l.loanId == loanId);
    if (i == -1) return 'Loan not found.';
    final loan = _loans[i];
    if (!loan.isActive) return 'This loan is already returned.';
    _loans[i] = loan.copyWithReturn(
      returnDate: FinePolicy.dateOnly(_now()),
      finalFine: calculateFine(loan),
    );
    _setAvailability(loan.bookId, true);
    notifyListeners();
    return null;
  }

  void _setAvailability(String bookId, bool value) {
    final i = _books.indexWhere((b) => b.id == bookId);
    _books[i] = _books[i].copyWith(isAvailable: value);
  }
}
