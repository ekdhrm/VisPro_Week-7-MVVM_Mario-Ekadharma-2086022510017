import 'package:flutter/material.dart';
import '../formatters.dart';

class FineSummaryCard extends StatelessWidget {
  const FineSummaryCard({
    super.key,
    required this.total,
    required this.activeCount,
    required this.overdueCount,
  });

  final int total;
  final int activeCount;
  final int overdueCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total fines', style: theme.textTheme.labelLarge),
            Text(formatRupiah(total), style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('$activeCount active loans, $overdueCount overdue or missing'),
          ],
        ),
      ),
    );
  }
}
