import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Engine.dart';

class EngineWidget extends StatelessWidget{

  EngineWidget(this.engine,this.title, {super.key});
  Engine engine;
  String title;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      margin: EdgeInsets.all(5.0),
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color:   Colors.grey,
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
                  children: [Text("SILNIK ${title}",style: TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Moc"), Text("${engine.getThrustInKNewton().toStringAsFixed(3)} KN")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Status"), Text(engine.getThrustInKNewton() > 0 ? "PRACUJE":"BIEG JAŁOWY")],
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