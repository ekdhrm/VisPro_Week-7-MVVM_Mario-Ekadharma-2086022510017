import '../models/loan.dart';
import '../models/loan_status.dart';

/// The ONE place for loan period, fine rate, and date rules.
class FinePolicy {
  static const int loanDays = 6;
  static const int weeklyFine = 5000; // Rupiah per completed week
  static const int missingAfterMonths = 6;

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static DateTime dueDateFor(DateTime borrowDate) {
    final b = dateOnly(borrowDate);
    return DateTime(b.year, b.month, b.day + loanDays);
  }

  static int overdueDays(DateTime dueDate, DateTime reference) {
    final due = DateTime.utc(dueDate.year, dueDate.month, dueDate.day);
    final ref = DateTime.utc(reference.year, reference.month, reference.day);
    final days = ref.difference(due).inDays;
    return days < 0 ? 0 : days;
  }

  static int completedWeeks(DateTime dueDate, DateTime reference) =>
      overdueDays(dueDate, reference) ~/ 7;

  // Same day number, 6 calendar months later (clamped to month end).
  static DateTime missingDate(DateTime dueDate) {
    final first = DateTime(dueDate.year, dueDate.month + missingAfterMonths, 1);
    final lastDay = DateTime(first.year, first.month + 1, 0).day;
    final day = dueDate.day > lastDay ? lastDay : dueDate.day;
    return DateTime(first.year, first.month, day);
  }

  static bool isMissing(DateTime dueDate, DateTime reference) =>
      !dateOnly(reference).isBefore(missingDate(dueDate));

  static int fineFor(Loan loan, int replacementPrice, DateTime reference) {
    final weekly = completedWeeks(loan.dueDate, reference) * weeklyFine;
    final missing = isMissing(loan.dueDate, reference);
    return missing ? replacementPrice + weekly : weekly;
  }

  static LoanStatus statusFor(Loan loan, DateTime reference) {
    if (!loan.isActive) return LoanStatus.returned;
    if (isMissing(loan.dueDate, reference)) return LoanStatus.missing;
    if (overdueDays(loan.dueDate, reference) > 0) return LoanStatus.overdue;
    return LoanStatus.borrowed;
  }
}
