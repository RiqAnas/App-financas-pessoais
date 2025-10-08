import 'package:flutter/material.dart';
import 'package:projetodespesaspessoais/components/transaction_listtile.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;

  TransactionList(this.transactions, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "Nenhuma transação cadastrada",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          )
        //ListView.builder serve par renderizar à medida que for necessário
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              //faz a lista de widgets (como se fosse o ...)
              final transacao = transactions[index];
              return TransactionListtile(
                transacao: transacao,
                fn: onDelete,
                //key se baseando no id da transação para que se crie uma identificação desse
                //componente, GlobalObjectKey é cara para a otimização, chaves não são tão necessárias
                //na maioria dos casos
                key: GlobalObjectKey(transacao),
              );
            },
          );
  }
}
