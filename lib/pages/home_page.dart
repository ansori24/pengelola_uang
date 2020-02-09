import 'package:flutter/material.dart';
import 'package:pengelola_uang/models/transaction.dart';
import 'package:pengelola_uang/pages/add_transaction_page.dart';
import 'package:pengelola_uang/repositories/transaction_repository.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: TransactionRepository.getAllTransaction(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Transaction transaction = snapshot.data[index];
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
                  onTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 0,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddTransactionPage(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
