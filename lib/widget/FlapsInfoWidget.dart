import 'package:airplane/plane/Warning.dart';
import 'package:flutter/material.dart';

import '../plane/Flaps.dart';

class FlapsInfoWidget extends StatelessWidget {
  FlapsInfoWidget(this._flaps, {super.key});

  Flaps _flaps;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Warning.isBadClapPosition() ? Colors.red : Colors.grey,
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
                Text("Klapy kąt", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kąt"),
                Text("${_flaps.getCurrentFlapsPosition()}°")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text(Warning.isBadClapPosition() ? "\u26A0 zła pozycja klap" : "\u2713")
              ],
            )
          ],
        ),
      )),
    );
  }
}
