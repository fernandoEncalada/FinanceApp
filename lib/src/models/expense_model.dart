import 'dart:convert';

Expense oneExpenseFromJson(String str) => Expense.fromJson(json.decode(str));
List<Expense> expenseFromJson(String str) =>
    List<Expense>.from(json.decode(str).map((x) => Expense.fromJson(x)));

String expenseToJson(List<Expense> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Expense {
  int id;
  String description;
  double amount;
  String createdAt;
  String updatedAt;

  Expense(
      {required this.id,
      required this.description,
      required this.amount,
      required this.createdAt,
      required this.updatedAt});

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
      id: json["id"],
      description: json["description"],
      amount: json["amount"],
      createdAt: json["createdAt"] ?? '',
      updatedAt: json["updatedAt"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "amount": amount,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };
}
