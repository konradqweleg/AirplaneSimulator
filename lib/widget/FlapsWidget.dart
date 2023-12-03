import 'package:airplane/plane/FlapsPosition.dart';
import 'package:flutter/material.dart';

import '../plane/Flaps.dart';

class FlapsWidget extends StatefulWidget{


  FlapsWidget(this.flaps ,{super.key});
  Flaps flaps;


  @override
  State<StatefulWidget> createState() {
    return FlapsState();
  }

}

class FlapsState extends State<FlapsWidget>{

  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 250,
      width: 240,
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color:  Colors.grey,
        ),

      ),
      padding: EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10.0),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("KLAPY USTAWIENIE",style: TextStyle(fontWeight: FontWeight.bold,))

                  ],
                ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: const Text('0°'),
                          leading: Radio(
                            value: 1,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                widget.flaps.setFlapsPosition(FlapsPosition.retracted);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('15°'),
                          leading: Radio(
                            value: 2,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                widget.flaps.setFlapsPosition(FlapsPosition.takeoff);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('30°'),
                          leading: Radio(
                            value: 3,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                widget.flaps.setFlapsPosition(FlapsPosition.landing);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('45°'),
                          leading: Radio(
                            value: 4,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                                widget.flaps.setFlapsPosition(FlapsPosition.extended);
                              });
                            },
                          ),
                        ),
                      ],
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