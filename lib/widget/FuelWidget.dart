import 'package:airplane/plane/Warning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Tank.dart';

class FuelWidget extends StatelessWidget{
  Tank _tank;
  FuelWidget(this._tank, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      decoration:  BoxDecoration(
          border: Border.all(
            width: 1,
            color:  (Warning.isLowLevelFuel())? Colors.red:  Colors.grey,
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
                children: [Text("PALIWO",style: TextStyle(fontWeight: FontWeight.bold))

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Pozosotało"), Text("${_tank.getFuelInKg().toStringAsFixed(3)} L")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Wystarczy na"),Text("${_tank.getMaxKMOnActualFuelLevel().toStringAsFixed(3)} km")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(""),Text((Warning.isLowLevelFuel())? "\u26A0 Niski poziom paliwa":"\u2713")],
              )
            ],
          ),
        )
      ),
    );
  }

}