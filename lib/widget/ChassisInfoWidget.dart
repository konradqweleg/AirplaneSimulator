
import 'package:airplane/plane/Chassis.dart';
import 'package:airplane/plane/Warning.dart';
import 'package:flutter/material.dart';



class ChassisInfoWidget extends StatelessWidget {
  ChassisInfoWidget(this._chassis, {super.key});

  Chassis _chassis;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color:  Warning.isUnnecessarilyExtendedChassisEnabled() ? Colors.red : Colors.grey,
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
                    Text("Podwozie", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status"),
                    Text("${_chassis.isEjectedChassis()?  "Schowane" : "Wysunięte"}")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    Text( Warning.isUnnecessarilyExtendedChassisEnabled()? "\u26A0 Podwozie wysunięte na dużej wysokośći" : "\u2713",style: const TextStyle(fontSize: 10),)
                  ],
                )
              ],
            ),
          )),
    );
  }
}
