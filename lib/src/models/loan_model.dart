
import 'dart:convert';

Loan oneLoanFromJson(String str) => Loan.fromJson(json.decode(str));
List<Loan> loanFromJson(String str) =>
    List<Loan>.from(json.decode(str).map((x) => Loan.fromJson(x)));

String loanToJson(List<Loan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loan {
  int id;
  String description;
  double amount;
  String createdAt;
  String updatedAt;
  bool status;

  Loan({
    required this.id,
    required this.description,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        description: json["description"],
        amount: json["amount"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "amount": amount,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "status": status,
      };
}
