import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../plane/Engine.dart';
import '../warning/Warning.dart';

class EngineWidget extends StatelessWidget{

  EngineWidget(this._engine,this._title, {super.key});
  Engine _engine;
  String _title;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150.0,
      width: 250.0,
      margin: const EdgeInsets.all(5.0),
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color: ((Warning.isLeftEngineFailure() && _title=="LEWY") || (Warning.isRightEngineFailure() && _title=="PRAWY"))? Colors.red : Colors.grey,
        ),

      ),
      padding: const EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(10.0),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("SILNIK ${_title}",style: const TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Moc"), Text("${_engine.getThrustInKNewton().toStringAsFixed(3)} KN")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [ Text(_engine.getThrustInKNewton() > 0 ? "\u2713":"BIEG JAŁOWY")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((Warning.isLeftEngineFailure() && _title=="LEWY")? "\u26A0 AWARIA" :"" ),
                    Text((Warning.isRightEngineFailure() && _title=="PRAWY")? "\u26A0 AWARIA" :"" )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }

}