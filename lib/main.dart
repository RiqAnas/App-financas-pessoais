import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projetodespesaspessoais/components/chart.dart';
import 'package:projetodespesaspessoais/components/transaction_form.dart';
import 'package:projetodespesaspessoais/components/transaction_list.dart';
import 'package:projetodespesaspessoais/models/transaction.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.alexandriaTextTheme(),
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        primarySwatch: Colors.orange,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'primeira compra',
      value: 200.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'segunda compra',
      value: 150.00,
      date: DateTime.now(),
    ),
  ];

  //definir quais dias farão parte da lista, filtrando os últimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (tr) => tr.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    //para fechar o modal //metodo pop trata do primeira tela da "pilha" de telas, fechando ela
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Despesas"),
        //actions: botar widgets no appbar
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxis da column = Vertical
          //crossAxis da column = horizontal
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
