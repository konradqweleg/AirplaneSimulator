
import 'package:airplane/plane/ThrustReversers.dart';
import 'package:flutter/material.dart';



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
          color:  Colors.grey,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status"),
                    Text("OK")
                  ],
                )
              ],
            ),
          )),
    );
  }
}
