import 'package:airplane/plane/Warning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Height.dart';

class HeightWidget extends StatefulWidget {
  HeightWidget(this._height);

  Height _height;

  @override
  State<StatefulWidget> createState() {
    return HeightWidgetState();
  }
}

class HeightWidgetState extends State<HeightWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Warning.isCloseStall() ? Colors.red : Colors.grey,
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
                Text("WYSOKOŚĆ", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("m n.p.m"),
                Text(
                    "${widget._height.getHeightPlaneAboveTheGroundInMetres().toStringAsFixed(3)} m")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status"),
                Text(Warning.isCloseStall() ? "NISKA WYSOKOŚĆ" : "OK")
              ],
            ),
          ],
        ),
      )),
    );
  }
}
