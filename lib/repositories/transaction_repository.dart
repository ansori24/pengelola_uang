import 'package:pengelola_uang/models/transaction.dart';
import 'package:pengelola_uang/services/db.dart';

class TransactionRepository {
  static Future<List<Transaction>> getAllTransaction() async {
    List<Map<String, dynamic>> _result = await DB.query('transactions');

    return _result.map((item) => Transaction.fromMap(item)).toList();
  }
}
