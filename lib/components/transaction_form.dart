import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetodespesaspessoais/components/adaptative_textfield.dart';

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          AdaptativeTextfield(
            label: "Título",
            textType: TextInputType.name,
            controller: _titleController,
            pressed: _pressed,
          ),
          AdaptativeTextfield(
            label: "Valor (R\$)",
            textType: TextInputType.numberWithOptions(decimal: true),
            controller: _valueController,
            pressed: _pressed,
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
