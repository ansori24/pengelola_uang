import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pengelola_uang/models/transaction.dart';
import 'package:pengelola_uang/repositories/transaction_repository.dart';

class AddTransactionPage extends StatefulWidget {
  @override
  AddTransactionPageState createState() => AddTransactionPageState();
}

class AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  Transaction _transaction = Transaction(type: 'masuk');
  GlobalKey<AutoCompleteTextFieldState<String>> autoCompletekey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 36.0),
          child: Column(
            children: <Widget>[
              buildTransactionType(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AutoCompleteTextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    icon: Icon(Icons.assignment_turned_in),
                    hintText: 'ex: makan, jalan-jalan',
                    labelText: 'Keterangan',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
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
                    return suggestion
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (String a, String b) {
                    return a.compareTo(b);
                  },
                  itemSubmitted: (String data) {
                    setState(() {
                      textEditingController.text = data;
                    });
                  },
                  clearOnSubmit: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Jumlah harus diisi';
                    }
                  },
                  onSaved: (value) {
                    setState(() => _transaction.amount = int.parse(value));
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.description),
                    contentPadding: EdgeInsets.zero,
                    hintText: 'ex: 20000',
                    labelText: 'Jumlah',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
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

  Row buildTransactionType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: 'masuk',
              groupValue: _transaction.type,
              onChanged: (value) {
                setState(() {
                  _transaction.type = value;
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
              groupValue: _transaction.type,
              onChanged: (value) {
                setState(() {
                  _transaction.type = value;
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
    final form = _formKey.currentState;
    _transaction.name = textEditingController.text;
    if (form.validate()) {
      form.save();
      TransactionRepository.insertTransaction(_transaction);
      Navigator.of(context).pop();
    }
  }
}
