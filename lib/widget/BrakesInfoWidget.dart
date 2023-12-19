
import 'package:flutter/material.dart';

import '../plane/Brakes.dart';
import '../warning/Warning.dart';

class BrakesInfoWidget extends StatelessWidget {
  BrakesInfoWidget(this._brakes, {super.key});

  Brakes _brakes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color:  Warning.isBrakeNoExpectedEnabled() ? Colors.red : Colors.grey,
        ),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hamulce", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status"),
                    Text("${_brakes.isBrakesEnabled()?  "Włączone" : "Wyłączone"}°")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(Warning.isBrakeNoExpectedEnabled() ? "\u26A0":""),
                    Text(Warning.isBrakeNoExpectedEnabled() ? "Hamulce włączone, ciąg też" : "\u2713")
                  ],
                )
              ],
            ),
          )),
    );
  }
}
