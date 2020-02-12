import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pengelola_uang/models/transaction.dart';
import 'package:pengelola_uang/repositories/transaction_repository.dart';

class TransactionAddPage extends StatefulWidget {
  final String type;

  const TransactionAddPage({Key key, this.type}) : super(key: key);
  @override
  TransactionAddPageState createState() => TransactionAddPageState();
}

class TransactionAddPageState extends State<TransactionAddPage> {
  Transaction transaction = Transaction();
  GlobalKey<AutoCompleteTextFieldState<String>> autoCompletekey = GlobalKey();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  @override
  void initState() {
    transaction.type = widget.type;
    getSuggestions();
    super.initState();
  }

  getSuggestions() async {
    await TransactionRepository.getAllTransactionNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah transaksi'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.check_circle),
            onPressed: _saveTransaction,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 36.0),
        child: Column(
          children: <Widget>[
            buildTransactionType(),
            buildTransactionName(),
            buildTransactionAmount(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          _saveTransaction();
        },
      ),
    );
  }

  var inputStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  );

  InputDecoration buildInputDecoration({hintText, labelText, icon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      icon: icon,
      hintText: hintText,
      labelText: labelText,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    );
  }

  Padding buildTransactionName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AutoCompleteTextField(
        controller: keteranganController,
        decoration: buildInputDecoration(
          hintText: 'eg : makan, transport',
          labelText: 'Keterangan',
          icon: Icon(Icons.assignment_turned_in),
        ),
        key: autoCompletekey,
        suggestions: TransactionRepository.allTransactionNames,
        itemBuilder: (BuildContext context, String suggestion) {
          return Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(suggestion),
              ),
            ],
          );
        },
        itemFilter: (String suggestion, String query) {
          return suggestion.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (String a, String b) {
          return a.compareTo(b);
        },
        itemSubmitted: (String data) {
          setState(() {
            keteranganController.text = data;
          });
        },
        clearOnSubmit: false,
        style: inputStyle,
      ),
    );
  }

  Padding buildTransactionAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: jumlahController,
        keyboardType: TextInputType.number,
        decoration: buildInputDecoration(
          hintText: 'eg : 20000',
          labelText: 'Jumlah',
          icon: Icon(Icons.assignment),
        ),
        style: inputStyle,
      ),
    );
  }

  Row buildTransactionType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: 'masuk',
              groupValue: transaction.type,
              onChanged: (value) {
                setState(() {
                  transaction.type = value;
                });
              },
            ),
            Text(
              'Masuk',
              style: TextStyle(
                color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 'keluar',
              groupValue: transaction.type,
              onChanged: (value) {
                setState(() {
                  transaction.type = value;
                });
              },
            ),
            Text(
              'Keluar',
              style: TextStyle(
                color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveTransaction() {
    transaction.name = keteranganController.text;
    transaction.amount = int.parse(jumlahController.text);
    TransactionRepository.insertTransaction(transaction);
    Navigator.of(context).pop();
  }
}
