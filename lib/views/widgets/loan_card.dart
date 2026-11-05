import 'package:flutter/material.dart';
import '../../models/loan.dart';
import '../../models/loan_status.dart';
import '../formatters.dart';
import 'status_chip.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({
    super.key,
    required this.loan,
    required this.title,
    required this.status,
    required this.fine,
    required this.onReturn,
  });

  final Loan loan;
  final String title;
  final LoanStatus status;
  final int fine;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
              StatusChip.loan(theme.colorScheme, status),
            ]),
            const SizedBox(height: 8),
            Text('Student ID: ${loan.studentId}'),
            Text('Borrowed: ${formatDate(loan.borrowDate)}'),
            Text('Due: ${formatDate(loan.dueDate)}'),
            if (loan.returnDate != null)
              Text('Returned: ${formatDate(loan.returnDate!)}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fine: ${formatRupiah(fine)}',
                    style: theme.textTheme.titleSmall),
                if (loan.isActive)
                  FilledButton.tonal(
                      onPressed: onReturn, child: const Text('Return')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
