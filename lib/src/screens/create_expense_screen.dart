import 'package:finance_app/src/providers/expense_form_provider.dart';
import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:finance_app/src/providers/loan_form_provider.dart';
import 'package:finance_app/src/screens/expense_screen.dart';
import 'package:finance_app/src/screens/loan_screen.dart';
import 'package:finance_app/src/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class CreateExpenseScreen extends StatelessWidget {
  const CreateExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => ExpenseFormProvider(financeProvider.selectExpense),
      child: _ExpenseScreenBody(financeProvider: financeProvider),
    );
  }
}

class _ExpenseScreenBody extends StatelessWidget {
  const _ExpenseScreenBody({
    Key? key,
    required this.financeProvider,
  }) : super(key: key);

  final FinanceProvider financeProvider;

  @override
  Widget build(BuildContext context) {
    final expenseForm = Provider.of<ExpenseFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(financeProvider.selectExpense.id > 0
            ? 'Edit Expense'
            : 'Create Expense'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _ExpenseForm(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: financeProvider.isSaving
            ? null
            : () async {
                if (!expenseForm.isValidForm()) return;
                if (financeProvider.selectExpense.id == 0) {
                  await financeProvider
                      .createExpense(expenseForm.expense)
                      .then((value) => {
                            if (value['status'] == 201)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TabsPage())),
                                financeProvider.getExpenses()
                              }
                          });
                } else {
                  await financeProvider
                      .updateExpense(financeProvider.selectExpense)
                      .then((value) => {
                            if (value['status'] == 200)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TabsPage())),
                                financeProvider.getExpenses()
                              }
                          });
                }
              },
        child: financeProvider.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ExpenseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseForm = Provider.of<ExpenseFormProvider>(context);
    final expense = expenseForm.expense;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: expenseForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                initialValue: expense.description,
                onChanged: (value) => expense.description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The description is required';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Description', labelText: 'Description'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                initialValue: expense.amount.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    expense.amount = 0;
                  } else {
                    expense.amount = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Amount', labelText: 'Amount:'),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
