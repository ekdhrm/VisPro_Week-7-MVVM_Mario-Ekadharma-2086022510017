class Loan {
  final String loanId;
  final String bookId;
  final String studentId;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DateTime? returnDate; // null = still active
  final int? finalFine; // frozen amount, set only when returned

  const Loan({
    required this.loanId,
    required this.bookId,
    required this.studentId,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
    this.finalFine,
  });

  bool get isActive => returnDate == null;

  Loan copyWithReturn({
    required DateTime returnDate,
    required int finalFine,
  }) {
    return Loan(
      loanId: loanId,
      bookId: bookId,
      studentId: studentId,
      borrowDate: borrowDate,
      dueDate: dueDate,
      returnDate: returnDate,
      finalFine: finalFine,
    );
  }
}
