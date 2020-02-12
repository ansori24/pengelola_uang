import 'package:flutter/material.dart';
import 'package:pengelola_uang/pages/add_transaction_page.dart';
import 'package:pengelola_uang/pages/transaction_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2, initialIndex: 1);
    tabController.addListener(updateIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    tabController.removeListener(updateIndex);
    super.dispose();
  }

  void updateIndex() {
    setState(() => tabIndex = tabController.index);
  }

  var textStyle = TextStyle(
    letterSpacing: 2,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(
              child: Text(
                'MASUK',
                style: textStyle,
              ),
            ),
            Tab(
              child: Text(
                'KELUAR',
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          TransactionPage(type: 'masuk'),
          TransactionPage(type: 'keluar'),
        ],
      ),
      floatingActionButton: tabIndex == 0
          ? buildFloatingActionButton(context, 'masuk')
          : buildFloatingActionButton(context, 'keluar'),
    );
  }

  FloatingActionButton buildFloatingActionButton(
      BuildContext context, String type) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AddTransactionPage(type: type),
          ),
        );
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
