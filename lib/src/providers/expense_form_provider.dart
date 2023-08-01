import 'package:finance_app/src/models/expense_model.dart';
import 'package:finance_app/src/models/loan_model.dart';
import 'package:finance_app/src/models/loan_request.dart';
import 'package:flutter/material.dart';

class ExpenseFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Expense expense;

  ExpenseFormProvider(this.expense);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
