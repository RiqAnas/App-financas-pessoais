import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextfield extends StatelessWidget {
  final String? label;
  final Function? pressed;
  final TextEditingController? controller;
  final TextInputType? textType;

  AdaptativeTextfield({
    this.label,
    this.textType,
    this.pressed,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: label,
            keyboardType: textType,
            //precisa usar expressão lambda pois a função do onSubmitted precisa de um parametro e a funcao nao
            //entao dessa forma se consegue fazer isso, se quiser ignorar o parametro basta usar (_)
            onSubmitted: (_) => pressed!(),
            controller: controller,
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            keyboardType: textType,
            //precisa usar expressão lambda pois a função do onSubmitted precisa de um parametro e a funcao nao
            //entao dessa forma se consegue fazer isso, se quiser ignorar o parametro basta usar (_)
            onSubmitted: (_) => pressed!(),
            controller: controller,
          );
  }
}
