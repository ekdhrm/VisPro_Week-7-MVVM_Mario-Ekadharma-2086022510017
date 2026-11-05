import '../models/book.dart';
import '../models/loan.dart';
import '../viewmodels/fine_policy.dart';

const String kStudentId = '2086022510017';

const List<Book> sampleBooks = [
  Book(id: 'B1', title: 'Clean Code', author: 'Robert C. Martin', replacementPrice: 250000),
  Book(id: 'B2', title: 'Introduction to Algorithms', author: 'Thomas H. Cormen', replacementPrice: 600000, isAvailable: false),
  Book(id: 'B3', title: 'Design Patterns', author: 'Erich Gamma', replacementPrice: 350000, isAvailable: false),
  Book(id: 'B4', title: 'The Pragmatic Programmer', author: 'Andrew Hunt', replacementPrice: 300000, isAvailable: false),
  Book(id: 'B5', title: 'Database System Concepts', author: 'Abraham Silberschatz', replacementPrice: 450000, isAvailable: false),
  Book(id: 'B6', title: 'Flutter in Action', author: 'Eric Windmill', replacementPrice: 280000),
  Book(id: 'B7', title: 'Operating System Concepts', author: 'Abraham Silberschatz', replacementPrice: 500000),
];

DateTime _daysAgo(DateTime today, int days) =>
    DateTime(today.year, today.month, today.day - days);

Loan _loan(String id, String bookId, DateTime due) {
  return Loan(
    loanId: id,
    bookId: bookId,
    studentId: kStudentId,
    borrowDate: DateTime(due.year, due.month, due.day - FinePolicy.loanDays),
    dueDate: due,
  );
}

/// Past-dated loans so every fine case can be demonstrated.
List<Loan> sampleLoans(DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  return [
    _loan('L1', 'B2', _daysAgo(today, -3)), // on time, due in 3 days
    _loan('L2', 'B3', _daysAgo(today, 7)), // 1 completed week
    _loan('L3', 'B4', _daysAgo(today, 14)), // 2 completed weeks
    _loan('L4', 'B5', _daysAgo(today, 190)), // past six months: Missing
  ];
}
