import 'dart:convert';

List<ExpenseRequest> expenseRequestFromJson(String str) =>
    List<ExpenseRequest>.from(
        json.decode(str).map((x) => ExpenseRequest.fromJson(x)));

String expenseRequestToJson(List<ExpenseRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseRequest {
  String description;
  double amount;

  ExpenseRequest({
    required this.description,
    required this.amount,
  });

  factory ExpenseRequest.fromJson(Map<String, dynamic> json) =>
      ExpenseRequest(description: json["description"], amount: json["amount"]);

  Map<String, dynamic> toJson() =>
      {"description": description, "amount": amount};
}
