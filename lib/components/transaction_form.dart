import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) funcao;

  //o construtor continua sendo em referência ao widget e não ao estado
  TransactionForm(this.funcao);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _pressed() {
    final title = titleController.text;
    //tenta dar um parse para a string e se não conseguir será 0.0
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    //dessa forma ele consegue pegar dados e funç~oes recebidas como parametros
    widget.funcao(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Título"),
              //faz o formulario exercer uma função quando clica no 'enter'
              onSubmitted: (_) => _pressed(),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor (R\$)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //precisa usar expressão lambda pois a função do onSubmitted precisa de um parametro e a funcao nao
              //entao dessa forma se consegue fazer isso, se quiser ignorar o parametro basta usar (_)
              onSubmitted: (_) => _pressed(),
              controller: valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  //() => _pressed() seria igual
                  onPressed: _pressed,
                  child: Text(
                    "Nova Transação",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
