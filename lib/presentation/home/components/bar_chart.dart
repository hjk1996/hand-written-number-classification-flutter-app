import 'package:flutter/material.dart';
import 'package:temp/domain/constant.dart';

class MyBarChart extends StatelessWidget {
  MyBarChart({Key? key, this.predictedNumber, this.probabilities})
      : super(key: key);
  int? predictedNumber;
  List<dynamic>? probabilities;

  final List<int> numbers = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: numbers
          .map(
            (i) => Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: barChartBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 200,
                      width: 15,
                    ),
                    Positioned(
                        bottom: 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: const BoxDecoration(
                            color: barChartFillColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          height: probabilities == null
                              ? 0
                              : probabilities![i] * 200,
                          width: 15,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  i.toString(),
                  style: TextStyle(
                      color: predictedNumber == i
                          ? Colors.amber[900]
                          : Colors.black),
                )
              ],
            ),
          )
          .toList(),
    );
  }
}
