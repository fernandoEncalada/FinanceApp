import 'package:finance_app/src/models/loan_model.dart';
import 'package:finance_app/src/models/loan_request.dart';
import 'package:flutter/material.dart';

class LoanFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Loan loan;

  LoanFormProvider(this.loan);

  updateStatus(bool value) {
    loan.status = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
