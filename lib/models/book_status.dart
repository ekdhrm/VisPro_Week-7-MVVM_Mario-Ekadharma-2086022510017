// What a book looks like in the catalogue. The ViewModel decides which one.
enum BookStatus {
  available('Available'),
  borrowed('Borrowed'),
  overdue('Overdue'),
  missing('Missing');

  const BookStatus(this.label);
  final String label;
}
