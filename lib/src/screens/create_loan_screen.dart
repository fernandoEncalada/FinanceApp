import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:finance_app/src/providers/loan_form_provider.dart';
import 'package:finance_app/src/screens/expense_screen.dart';
import 'package:finance_app/src/screens/loan_screen.dart';
import 'package:finance_app/src/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class CreateLoanScreen extends StatelessWidget {
  const CreateLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoanFormProvider(financeProvider.selectLoan),
      child: _LoanScreenBody(financeProvider: financeProvider),
    );
  }
}

class _LoanScreenBody extends StatelessWidget {
  const _LoanScreenBody({
    Key? key,
    required this.financeProvider,
  }) : super(key: key);

  final FinanceProvider financeProvider;

  @override
  Widget build(BuildContext context) {
    final loanForm = Provider.of<LoanFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            financeProvider.selectLoan.id > 0 ? 'Edit Loan' : 'Create Loan'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _LoanForm(),
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
                if (!loanForm.isValidForm()) return;
                if (financeProvider.selectLoan.id == 0) {
                  await financeProvider
                      .createLoan(loanForm.loan)
                      .then((value) => {
                            if (value['status'] == 201)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TabsPage())),
                                financeProvider.getLoans()
                              }
                          });
                } else {
                  await financeProvider
                      .updateLoan(financeProvider.selectLoan)
                      .then((value) => {
                            if (value['status'] == 200)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TabsPage())),
                                financeProvider.getLoans()
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

class _LoanForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loanForm = Provider.of<LoanFormProvider>(context);
    final loan = loanForm.loan;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: loanForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                initialValue: loan.description,
                onChanged: (value) => loan.description = value,
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
                initialValue: loan.amount.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    loan.amount = 0;
                  } else {
                    loan.amount = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Amount', labelText: 'Amount:'),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: loan.status,
                title:
                    const Text('Paid', style: TextStyle(color: Colors.black)),
                activeColor: Colors.indigo,
                onChanged: (value) => {loanForm.updateStatus(value)},
              ),
              const SizedBox(height: 30),
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
