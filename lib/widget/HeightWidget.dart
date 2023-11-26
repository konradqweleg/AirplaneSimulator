import 'package:airplane/plane/Warning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Height.dart';

class HeightWidget extends StatefulWidget{
  HeightWidget(this.height);
  Height height;

  @override
  State<StatefulWidget> createState() {
   return HeightWidgetState();
  }

}

class HeightWidgetState extends State<HeightWidget>{
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      margin: EdgeInsets.all(5.0),
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color: Warning.isLowHeight?  Colors.red : Colors.grey,
        ),

      ),
      padding: EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10.0),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("WYSOKOŚĆ",style: TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("m n.p.m"), Text("${widget.height.metresNPM.toStringAsFixed(3)} m")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Status"), Text(Warning.isLowHeight?"NISKA WYSOKOŚĆ" :"OK")],
                ),
                // Container(width: 200.0,child: Text("Pozostało : ${tank.getLevelFuelInLitres()} litrów paliwa")),
                // Container(width: 200.0,child: Text("Wystarczy na : ${tank.getMaxKMOnActualFuelLevel()} km")),
                // Container(width: 200.0,child: Text("BŁĄD"))
              ],
            ),
          )
      ),
    );
  }

}