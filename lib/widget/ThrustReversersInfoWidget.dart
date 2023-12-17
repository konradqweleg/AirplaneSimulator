
import 'package:airplane/plane/ThrustReversers.dart';
import 'package:flutter/material.dart';

import '../plane/Warning.dart';



class ThrustReversersInfoWidget extends StatelessWidget {
  ThrustReversersInfoWidget(this._thrustReversers, {super.key});

  ThrustReversers _thrustReversers;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Warning.isThrustReversersNoExpectedEnabled() ? Colors.red :  Colors.grey,
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
                    Text("Odwraczacze ciągu", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Włączone"),
                    Text("${_thrustReversers.isThrustReversersEnabled()?  "Włączone" : "Wyłączone"}°")
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Warning.isThrustReversersNoExpectedEnabled() ? "\u26A0":""),
                    Text(Warning.isThrustReversersNoExpectedEnabled() ? "Odwraczacze włączone, ciag też" : "\u2713",style: const TextStyle(fontSize: 12),)
                  ],
                )
              ],
            ),
          )),
    );
  }
}
