import 'package:flutter/material.dart';
import '../../models/book_status.dart';
import '../../models/loan_status.dart';

class StatusChip extends StatelessWidget {
  const StatusChip._(this.label, this.background, this.foreground);

  factory StatusChip.book(ColorScheme c, BookStatus s) => switch (s) {
        BookStatus.available =>
          StatusChip._(s.label, c.primaryContainer, c.onPrimaryContainer),
        BookStatus.borrowed =>
          StatusChip._(s.label, c.secondaryContainer, c.onSecondaryContainer),
        BookStatus.overdue =>
          StatusChip._(s.label, c.tertiaryContainer, c.onTertiaryContainer),
        BookStatus.missing => StatusChip._(s.label, c.error, c.onError),
      };

  factory StatusChip.loan(ColorScheme c, LoanStatus s) => switch (s) {
        LoanStatus.borrowed => StatusChip.book(c, BookStatus.borrowed),
        LoanStatus.overdue => StatusChip.book(c, BookStatus.overdue),
        LoanStatus.missing => StatusChip.book(c, BookStatus.missing),
        LoanStatus.returned => StatusChip._(
            s.label, c.surfaceContainerHighest, c.onSurfaceVariant),
      };

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
