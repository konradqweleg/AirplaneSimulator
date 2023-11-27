import 'package:airplane/plane/Warning.dart';
import 'package:flutter/material.dart';


class DistanceInfoWidget extends StatelessWidget{


  DistanceInfoWidget(this.distanceMetres ,{super.key});
  double distanceMetres = 0.0;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color: Warning.isBadClapPosition? Colors.red : Colors.grey,
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
                  children: [Text("Odległośc od startu",style: TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Odległość"), Text("${distanceMetres.toStringAsFixed(3)} m")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Status"),Text( "OK")],
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


