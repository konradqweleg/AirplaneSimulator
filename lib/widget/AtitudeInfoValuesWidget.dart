import 'package:flutter/material.dart';

class AttitudeInfoValues extends StatelessWidget {
  double _horizontal = 0.0;
  double _vertical = 0.0;

  AttitudeInfoValues(this._vertical, this._horizontal, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
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
                Text("SZTUCZNY HORYZONT",
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pionowy"),
                Text("${(_horizontal).toStringAsFixed(3)}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Poziomy"),
                Text("${(_vertical).toStringAsFixed(3)}")
              ],
            ),
          ],
        ),
      )),
    );
  }
}
