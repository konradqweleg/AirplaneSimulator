import 'package:airplane/simulation/AnaliseSituation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Height.dart';

class SimulationStatusWidget extends StatefulWidget{
  SimulationStatusWidget(this.analiseSituation);
  AnaliseSituation analiseSituation;

  @override
  State<StatefulWidget> createState() {
    return SimulationStatusWidgetState();
  }

}

class SimulationStatusWidgetState extends State<SimulationStatusWidget>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

               widget.analiseSituation.getIsLandingOk() ? Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [ Text("Udane lądowanie ",style: TextStyle(color: Colors.green,fontSize: 80))],
               ) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text("Katastrofa ${widget.analiseSituation.getCrashReason()} ",style: TextStyle(color: Colors.red,fontSize: 80))],
                ),

                // Container(width: 200.0,child: Text("Pozostało : ${tank.getLevelFuelInLitres()} litrów paliwa")),
                // Container(width: 200.0,child: Text("Wystarczy na : ${tank.getMaxKMOnActualFuelLevel()} km")),
                // Container(width: 200.0,child: Text("BŁĄD"))
              ],
            ),

      );
  }

}