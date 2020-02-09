import 'package:pengelola_uang/models/model.dart';

class Transaction implements Model {
  int id;
  String name;
  String type;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    this.id,
    this.name,
    this.type,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      amount: map['amount'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "type": type,
      "amount": amount,
      "created_at": createdAt != null
          ? createdAt.toIso8601String()
          : DateTime.now().toIso8601String(),
      "updated_at": updatedAt != null
          ? updatedAt.toIso8601String()
          : DateTime.now().toIso8601String(),
    };

    if (id != null) map['id'] = id;

    return map;
  }
}
