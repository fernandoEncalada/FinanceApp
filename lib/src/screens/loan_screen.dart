import 'package:finance_app/src/models/loan_model.dart';
import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:finance_app/src/screens/create_loan_screen.dart';
import 'package:finance_app/src/widgets/loan_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loanProvider = Provider.of<FinanceProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Loans'),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                loanProvider.selectLoan = new Loan(id: 0, description: '', amount: 0, createdAt: '', updatedAt: '', status: false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateLoanScreen()));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: (loanProvider.loans.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : LoanList(loanProvider.loans));
  }
}
