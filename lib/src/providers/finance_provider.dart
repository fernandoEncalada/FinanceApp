import 'dart:collection';
import 'dart:convert';
import 'package:finance_app/src/models/expense_model.dart';
import 'package:finance_app/src/models/expense_request.dart';
import 'package:finance_app/src/models/loan_model.dart';
import 'package:finance_app/src/models/loan_request.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const _FINANCE_URL = 'http://192.168.1.32:8084/api';

class FinanceProvider extends ChangeNotifier {
  List<Loan> loans = [];
  List<Expense> expenses = [];
  double totalLoan = 0.00;
  double totalExpense = 0.00;
  bool isLoading = true;
  bool isSaving = false;

  Loan selectLoan = Loan(
      id: 0,
      description: '',
      amount: 0,
      createdAt: '',
      updatedAt: '',
      status: false);
  Expense selectExpense =
      Expense(id: 0, description: '', amount: 0, createdAt: '', updatedAt: '');

  var url = Uri.parse('http://192.168.1.32:8084/api/loan');
  var urlExpenses = Uri.parse('http://192.168.1.32:8084/api/expense');

  FinanceProvider() {
    getLoans();
    getExpenses();
  }

  getLoans() async {
    final response = await http.get(url);

    final loanResponse = loanFromJson(response.body);
    loans = loanResponse;
    double totalSum = 0.0;
    double totalRest = 0.0;
    var loansToSum = loans.where((loan) => !loan.status);
    var loansToRest = loans.where((loan) => loan.status);
    for (var loan in loansToSum) {
      totalSum += loan.amount;
    }
    for (var loan in loansToRest) {
      totalRest -= loan.amount;
    }
    totalLoan = (totalSum + totalRest).abs();
    notifyListeners();
  }

  Future<Map> createLoan(Loan loan) async {
    LoanRequest loanRequest =
        LoanRequest(idPerson: 0, description: '', amount: 0, status: 0);
    loanRequest.description = loan.description;
    loanRequest.amount = loan.amount;
    loanRequest.idPerson = 1;
    loanRequest.status = loan.status ? 1 : 0;
    var response = {};
    try {
      final resp = await http.post(url,
          headers: {"content-type": "application/json"},
          body: jsonEncode(loanRequest));
      final loanResponse = oneLoanFromJson(resp.body);

      response = {'status': resp.statusCode, 'response': loanResponse};

      return response;
    } catch (e) {
      response = {'status': 500, 'response': e.toString()};
      print('catch: ' + e.toString());
      return response;
    }
  }

  Future<Map> updateLoan(Loan loan) async {
    LoanRequest loanRequest =
        LoanRequest(idPerson: 0, description: '', amount: 0, status: 0);
    loanRequest.description = loan.description;
    loanRequest.amount = loan.amount;
    loanRequest.idPerson = 1;
    loanRequest.status = loan.status ? 1 : 0;
    var response = {};
    try {
      var edit =
          Uri.parse('http://192.168.1.32:8084/api/loan/update/${loan.id}');
      final resp = await http.put(edit,
          headers: {"content-type": "application/json"},
          body: jsonEncode(loanRequest));
      final loanResponse = oneLoanFromJson(resp.body);

      response = {'status': resp.statusCode, 'response': loanResponse};

      return response;
    } catch (e) {
      response = {'status': 500, 'response': e.toString()};
      print('catch: ' + e.toString());
      return response;
    }
  }

  getExpenses() async {
    final response = await http.get(urlExpenses);

    final expenseResponse = expenseFromJson(response.body);
    expenses = expenseResponse;
    double totalSum = 0.0;
    for (var expense in expenses) {
      totalSum += expense.amount;
    }
    totalExpense = totalSum.abs();
    notifyListeners();
  }

  Future<Map> createExpense(Expense expense) async {
    ExpenseRequest expenseRequest = ExpenseRequest(description: '', amount: 0);
    expenseRequest.description = expense.description;
    expenseRequest.amount = expense.amount;
    var response = {};
    try {
      final resp = await http.post(urlExpenses,
          headers: {"content-type": "application/json"},
          body: jsonEncode(expenseRequest));
      final expenseResponse = oneExpenseFromJson(resp.body);

      response = {'status': resp.statusCode, 'response': expenseResponse};

      return response;
    } catch (e) {
      response = {'status': 500, 'response': e.toString()};
      print('catch: ' + e.toString());
      return response;
    }
  }

  Future<Map> updateExpense(Expense expense) async {
    ExpenseRequest expenseRequest = ExpenseRequest(description: '', amount: 0);
    expenseRequest.description = expense.description;
    expenseRequest.amount = expense.amount;
    var response = {};
    try {
      var edit = Uri.parse(
          'http://192.168.1.32:8084/api/expense/update/${expense.id}');
      final resp = await http.put(edit,
          headers: {"content-type": "application/json"},
          body: jsonEncode(expenseRequest));
      final expenseResponse = oneExpenseFromJson(resp.body);

      response = {'status': resp.statusCode, 'response': expenseResponse};

      return response;
    } catch (e) {
      response = {'status': 500, 'response': e.toString()};
      print('catch: ' + e.toString());
      return response;
    }
  }
}
