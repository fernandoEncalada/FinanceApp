import 'package:finance_app/src/models/loan_model.dart';
import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_loan_screen.dart';

class LoanList extends StatelessWidget {
  final List<Loan> loans;

  const LoanList(this.loans);

  @override
  Widget build(BuildContext context) {
    final FinanceProvider financeProvider =
        Provider.of<FinanceProvider>(context);
    return Column(
      children: [
        Text(
          'Total loan: ${financeProvider.totalLoan}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: loans.length,
            itemBuilder: (_, int index) {
              return _Loans(loan: loans[index], index: index);
            },
          ),
        ),
      ],
    );
  }
}

class _Loans extends StatelessWidget {
  final Loan loan;
  final int index;

  const _Loans({required this.loan, required this.index});

  @override
  Widget build(BuildContext context) {
    final FinanceProvider financeProvider =
        Provider.of<FinanceProvider>(context);
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: const Color.fromARGB(255, 74, 138, 241),
      child: SizedBox(
        width: 300,
        height: MediaQuery.of(context).size.height / 3.5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                loan.description,
                style: const TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 48, 53, 48),
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                '\$ ${loan.amount.toString()}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 20, 16),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                loan.status ? 'Paid (-)' : 'Pending (+)',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 20, 16),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                'Created: ${loan.createdAt}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 20, 16),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                'Updated: ${loan.updatedAt}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 20, 16),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    financeProvider.selectLoan = loan;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateLoanScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 64, 116, 228))),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      children: [Icon(Icons.edit_outlined), Text('Edit')],
                    ),
                  ),
                ),
              ) //SizedBox
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}

double getTotal() {
  return 10;
}
