import 'package:flutter/material.dart';
import 'package:pengelola_uang/models/transaction.dart';
import 'package:pengelola_uang/pages/transaction_detail_page.dart';
import 'package:pengelola_uang/repositories/transaction_repository.dart';

class TransactionPage extends StatefulWidget {
  final String type;

  const TransactionPage({Key key, this.type}) : super(key: key);
  @override
  TransactionPageState createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.type == 'masuk'
          ? TransactionRepository.getIncomeTransactions()
          : TransactionRepository.getOutcomeTransactions(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return buildListView(snapshot);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView buildListView(AsyncSnapshot<List> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        Transaction transaction = snapshot.data[index];
        return buildListTile(transaction);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 0,
      ),
    );
  }

  ListTile buildListTile(Transaction transaction) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          transaction.name[0].toUpperCase(),
        ),
      ),
      title: Text(
        transaction.name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text('Rp. ${transaction.amount.toString()}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TransactionDetailPage(
              transaction: transaction,
            ),
          ),
        );
      },
    );
  }
}
