import 'package:flutter/material.dart';
import 'package:pengelola_uang/models/transaction.dart';

class TransactionDetailPage extends StatefulWidget {
  final Transaction transaction;

  const TransactionDetailPage({Key key, this.transaction}) : super(key: key);
  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction.name),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'TRANSAKSI',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Colors.grey.shade700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Rp. ${widget.transaction.amount.toString()}",
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            Divider(),
            Card(
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tanggal transaksi'),
                    Text(
                      widget.transaction.createdAt.toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
