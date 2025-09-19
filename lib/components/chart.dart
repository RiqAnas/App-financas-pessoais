import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetodespesaspessoais/components/chart_bar.dart';

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

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get _weekTotalvalue {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + double.parse(item['value'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactions.map((t) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              t['day'].toString(),
              double.parse(t['value'].toString()),
              _weekTotalvalue == 0
                  ? 0
                  : double.parse(t['value'].toString()) / _weekTotalvalue,
            ),
          );
        }).toList(),
      ),
    );
  }
}
