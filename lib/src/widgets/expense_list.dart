import 'package:finance_app/src/models/expense_model.dart';
import 'package:finance_app/src/models/expense_model.dart';
import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_expense_screen.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList(this.expenses);

  @override
  Widget build(BuildContext context) {
    final FinanceProvider financeProvider =
        Provider.of<FinanceProvider>(context);
    return Column(
      children: [
        Text(
          'Total expense: ${financeProvider.totalExpense}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (_, int index) {
              return _Expenses(expense: expenses[index], index: index);
            },
          ),
        ),
      ],
    );
  }
}

class _Expenses extends StatelessWidget {
  final Expense expense;
  final int index;

  const _Expenses({required this.expense, required this.index});

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
                expense.description,
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
                '\$ ${expense.amount.toString()}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 20, 16),
                ), //Textstyle
              ),
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                'Created: ${expense.createdAt}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 16, 20, 16),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                'Updated: ${expense.updatedAt}',
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
                    financeProvider.selectExpense = expense;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateExpenseScreen()));
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
