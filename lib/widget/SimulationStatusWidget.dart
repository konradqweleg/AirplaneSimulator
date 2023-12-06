import 'package:airplane/simulation/AnaliseSituation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Height.dart';

class SimulationStatusWidget extends StatefulWidget{
  SimulationStatusWidget(this._analiseSituation);
  AnaliseSituation _analiseSituation;

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

               widget._analiseSituation.getIsLandingOk() ? const Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [ Text("Udane lądowanie ",style: TextStyle(color: Colors.green,fontSize: 80))],
               ) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text("Katastrofa ${widget._analiseSituation.getCrashReason()} ",style: TextStyle(color: Colors.red,fontSize: 80))],
                ),

              ],
            ),

      );
  }

}