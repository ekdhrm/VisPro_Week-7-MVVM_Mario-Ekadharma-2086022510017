import 'package:flutter/material.dart';
import '../viewmodels/library_view_model.dart';
import 'widgets/empty_state.dart';
import 'widgets/fine_summary_card.dart';
import 'widgets/loan_card.dart';
import 'widgets/show_result.dart';

class BorrowedBooksScreen extends StatelessWidget {
  const BorrowedBooksScreen({super.key, required this.library});

  final LibraryViewModel library;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Loans')),
      body: ListenableBuilder(
        listenable: library,
        builder: (context, _) {
          final loans = library.loans.reversed.toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FineSummaryCard(
                total: library.totalFines,
                activeCount: library.activeLoans.length,
                overdueCount: library.overdueLoans.length,
              ),
              if (loans.isEmpty)
                const EmptyState(
                    icon: Icons.menu_book, message: 'No loans yet.')
              else
                for (final loan in loans)
                  LoanCard(
                    loan: loan,
                    title: library.bookOf(loan).title,
                    status: library.getOverdueStatus(loan),
                    fine: library.calculateFine(loan),
                    onReturn: () => showResult(
                      context,
                      library.returnBook(loan.loanId),
                      'Book returned.',
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
