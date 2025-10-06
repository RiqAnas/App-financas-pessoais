import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar(this.label, this.value, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.5),
      child: LayoutBuilder(
        builder: (ctx, Constraints) {
          final constrainsHeight = Constraints.maxHeight;
          return Column(
            children: [
              //fittedbox faz o texto diminuir para caber no espaço meudeeeeuuuss
              //o container pode definir a altura(importante)
              Container(
                child: FittedBox(child: Text('R\$${value.toStringAsFixed(2)}')),
                height: constrainsHeight * 0.15,
              ),
              SizedBox(height: constrainsHeight * 0.05),
              Container(
                height: constrainsHeight * 0.6,
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
              SizedBox(height: constrainsHeight * 0.05),
              Container(
                height: constrainsHeight * 0.10,
                child: FittedBox(child: Text(label)),
              ),
            ],
          );
        },
      ),
    );
  }
}
