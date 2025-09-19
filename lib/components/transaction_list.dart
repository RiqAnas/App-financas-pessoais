import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  TransactionList(this.transactions, this.onDelete);

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
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            'R\$${transacao.value}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transacao.title[0].toUpperCase() +
                          transacao.title.substring(1),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/y').format(transacao.date),
                    ),
                    trailing: IconButton(
                      onPressed: () => onDelete(transacao.id),
                      icon: Icon(Icons.delete),
                      color: Colors.deepOrange,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
