import 'package:airplane/warning/Warning.dart';
import 'package:flutter/material.dart';


class DistanceInfoWidget extends StatelessWidget{


  DistanceInfoWidget(this._distanceMetres ,{super.key});
  double _distanceMetres = 0.0;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      decoration:  BoxDecoration(
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
                  children: [Text("Odległośc od startu",style: TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Odległość"), Text("${_distanceMetres.toStringAsFixed(3)} m")],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(""),Text( "\u2713")],
                )
              ],
            ),
          )
      ),
    );
  }




}


