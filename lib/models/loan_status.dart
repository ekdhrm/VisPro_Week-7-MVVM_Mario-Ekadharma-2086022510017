// Labels only. The ViewModel decides which one applies.
enum LoanStatus {
  borrowed('Borrowed'),
  overdue('Overdue'),
  missing('Missing'),
  returned('Returned');

  const LoanStatus(this.label);
  final String label;
}
