import 'package:airplane/plane/Warning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Tank.dart';

class FuelWidget extends StatelessWidget{
  Tank tank;
  FuelWidget(this.tank, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      decoration:  BoxDecoration(
          border: Border.all(
            width: 1,
            color:  (Warning.isLowLevelFuel)? Colors.red:  Colors.grey,
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
                children: [Text("PALIWO",style: TextStyle(fontWeight: FontWeight.bold))

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Pozosotało"), Text("${tank.getFuelInKg().toStringAsFixed(3)} L")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Wystarczy na"),Text("${tank.getMaxKMOnActualFuelLevel().toStringAsFixed(3)} km")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Status"),Text((Warning.isLowLevelFuel)? "NISKI POZIOM PALIWA":"OK")],
              )
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