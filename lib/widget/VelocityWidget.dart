import 'package:airplane/plane/Warning.dart';
import 'package:flutter/material.dart';

class VelocityWidget extends StatelessWidget{

  double _velocityMS = 0.0;
  VelocityWidget(this._velocityMS, {super.key});

  @override
   Widget build(BuildContext context) {
     return Container(
       height: 150.0,
       width: 250.0,
       margin: const EdgeInsets.all(5.0),
       decoration: BoxDecoration(
         border: Border.all(
           width: 1,
           color: Warning.isCloseStall()? Colors.red: Colors.grey,
         ),

       ),
       padding: const EdgeInsets.all(5.0),
       child: Scaffold(
           body: Container(
             margin: EdgeInsets.all(10.0),


             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("PRĘDKOŚĆ",
                         style: TextStyle(fontWeight: FontWeight.bold))

                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text("V"),
                     Text("${(_velocityMS * 3.60).toStringAsFixed(3)} km/h")
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [const Text("Status"), Text(Warning.isCloseStall()? "PRZECIĄGNIECIE": "OK")],
                 ),

               ],
             ),
           )
       ),
     );
   }

}