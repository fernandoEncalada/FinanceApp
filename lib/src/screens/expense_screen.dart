import 'package:finance_app/src/models/expense_model.dart';
import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:finance_app/src/screens/create_expense_screen.dart';
import 'package:finance_app/src/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<FinanceProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                expenseProvider.selectExpense = new Expense(
                    id: 0,
                    description: '',
                    amount: 0,
                    createdAt: '',
                    updatedAt: '');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateExpenseScreen()));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: (expenseProvider.expenses.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : ExpenseList(expenseProvider.expenses));
  }
}
