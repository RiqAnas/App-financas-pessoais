import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  //

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //delimita as recent transactions para até os últimos 7 dias (de hoje pra trás) e verifica se
  //há na lista passada alguma transação que se passe nesses dias, caso sim, irá calcular o valor
  //total baseado no index do dia que está dentro dos 7 (atribuindo o valorTotal por dia)
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }
      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);
      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(20),
      child: Row(children: <Widget>[
          
        ],
      ),
    );
  }
}
