import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetodespesaspessoais/models/transaction.dart';

class TransactionListtile extends StatelessWidget {
  final Transaction? transacao;
  final Function? fn;

  const TransactionListtile({Key? key, this.transacao, this.fn})
    : super(
        key: key,
      ); //usar o super dessa maneira permite usar o construtor da super classe

  @override
  Widget build(BuildContext context) {
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
                'R\$${transacao!.value}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
        title: Text(
          transacao!.title[0].toUpperCase() + transacao!.title.substring(1),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('dd/MM/y').format(transacao!.date)),
        trailing: IconButton(
          onPressed: () => fn!(transacao!.id),
          icon: Icon(Icons.delete),
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
