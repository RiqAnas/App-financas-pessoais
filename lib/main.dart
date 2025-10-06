import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
  final List<Transaction> _transactions = [];

  //definir quais dias farão parte da lista, filtrando os últimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (tr) => tr.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    //para fechar o modal //metodo pop trata do primeira tela da "pilha" de telas, fechando ela
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => t.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).canvasColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      title: Text("Minhas Despesas"),
      //actions: botar widgets no appbar
      actions: <Widget>[
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final availableHeight =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxis da column = Vertical
          //crossAxis da column = horizontal
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              height: availableHeight * 0.2,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: availableHeight * 0.8,
              child: TransactionList(_transactions, _deleteTransaction),
            ),
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
