import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar(this.label, this.value, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.5),
      child: Column(
        children: [
          //fittedbox faz o texto diminuir para caber no espaço meudeeeeuuuss
          //o container pode definir a altura(importante)
          Container(
            child: FittedBox(child: Text('R\$${value.toStringAsFixed(2)}')),
            height: 20,
          ),
          SizedBox(height: 5),
          Container(
            height: 50,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 1.0),
                    color: const Color.fromARGB(96, 255, 214, 64),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
