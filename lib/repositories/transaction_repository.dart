import 'package:pengelola_uang/models/transaction.dart';
import 'package:pengelola_uang/services/db.dart';

class TransactionRepository {
  static List<String> allTransactionNames = [];

  static Future<List<Transaction>> getAllTransaction() async {
    List<Map<String, dynamic>> _result = await DB.query('transactions');

    return _result.map((item) => Transaction.fromMap(item)).toList();
  }

  static Future<List<Transaction>> getIncomeTransactions() async {
    List<Map<String, dynamic>> _result = await DB.query(
      'transactions',
      where: "type = 'masuk'",
      orderBy: "created_at DESC",
    );

    return _result.map((item) => Transaction.fromMap(item)).toList();
  }

  static Future<List<Transaction>> getOutcomeTransactions() async {
    List<Map<String, dynamic>> _result = await DB.query(
      'transactions',
      where: "type = 'keluar'",
      orderBy: "created_at DESC",
    );

    return _result.map((item) => Transaction.fromMap(item)).toList();
  }

  static Future<void> getAllTransactionNames() async {
    List<Map<String, dynamic>> _result = await DB.query(
      'transactions',
      columns: ['name'],
      groupBy: 'name',
    );
    allTransactionNames.clear();
    _result.forEach((item) => allTransactionNames.add(item['name']));
  }

  static Future<Transaction> insertTransaction(Transaction transaction) async {
    transaction.id = await DB.insert('transactions', transaction);

    return transaction;
  }

  static Future<void> emptyTable() async {
    await DB.truncate('transactions');
  }
}
