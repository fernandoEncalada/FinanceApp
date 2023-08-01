import 'dart:convert';

List<LoanRequest> loanRequestFromJson(String str) => List<LoanRequest>.from(json.decode(str).map((x) => LoanRequest.fromJson(x)));

String loanRequestToJson(List<LoanRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanRequest {
    int idPerson;
    String description;
    double amount;
    int status;

    LoanRequest({
        required this.idPerson,
        required this.description,
        required this.amount,
        required this.status,
    });

    factory LoanRequest.fromJson(Map<String, dynamic> json) => LoanRequest(
        idPerson: json["idPerson"] == null ? 1 : 1,
        description: json["description"],
        amount: json["amount"],
        status: json["status"] == null ? 0 : 1,
    );

    Map<String, dynamic> toJson() => {
        "idPerson": idPerson,
        "description": description,
        "amount": amount,
        "status": status,
    };
}
