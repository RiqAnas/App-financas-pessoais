import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      //verificar se há alguma transação
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "Nenhuma transação cadastrada",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Image.network(
                  "https://www.pngmart.com/files/12/My-Neighbor-Totoro-Transparent-Background.png",
                ),
              ],
            )
          //ListView.builder serve par renderizar à medida que for necessário
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                //faz a lista de widgets (como se fosse o ...)
                final transacao = transactions[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepOrange,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          //toStringAsFixed define até quantas casas decimais irá mostrar
                          'R\$ ${transacao.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transacao.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            //DateFormat para formatar data (meudeus muito mais simples que o java pqp)
                            DateFormat('dd/MM/y').format(transacao.date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
