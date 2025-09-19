import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) funcao;

  //o construtor continua sendo em referência ao widget e não ao estado
  TransactionForm(this.funcao);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _pressed() {
    final title = _titleController.text;
    //tenta dar um parse para a string e se não conseguir será 0.0
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    //dessa forma ele consegue pegar dados e funç~oes recebidas como parametros
    widget.funcao(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        //informa que um estado do objeto foi alterado, necessário para mudar
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
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
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valor (R\$)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //precisa usar expressão lambda pois a função do onSubmitted precisa de um parametro e a funcao nao
              //entao dessa forma se consegue fazer isso, se quiser ignorar o parametro basta usar (_)
              onSubmitted: (_) => _pressed(),
              controller: _valueController,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(DateFormat("dd/MM/y").format(_selectedDate)),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  //() => _pressed() seria igual
                  onPressed: _pressed,
                  child: Text(
                    "Nova Transação",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
