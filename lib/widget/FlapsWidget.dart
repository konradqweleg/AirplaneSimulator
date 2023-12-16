import 'package:airplane/plane/FlapsPosition.dart';
import 'package:flutter/material.dart';

import '../plane/Flaps.dart';

class FlapsWidget extends StatefulWidget{


  FlapsWidget(this._flaps ,{super.key});
  Flaps _flaps;


  @override
  State<StatefulWidget> createState() {
    return FlapsState();
  }

}

class FlapsState extends State<FlapsWidget>{

  int _selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 310,
      width: 240,
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color:  Colors.grey,
        ),

      ),

      child: Scaffold(
          body: Container(

            margin: const EdgeInsets.all(15.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
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
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                                widget._flaps.setFlapsPosition(FlapsPosition.retracted);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('15°'),
                          leading: Radio(
                            value: 2,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                                widget._flaps.setFlapsPosition(FlapsPosition.takeoff);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('30°'),
                          leading: Radio(
                            value: 3,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                                widget._flaps.setFlapsPosition(FlapsPosition.landing);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('45°'),
                          leading: Radio(
                            value: 4,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                                widget._flaps.setFlapsPosition(FlapsPosition.extended);
                              });
                            },
                          ),
                        ),
                      ],
                    ),

              ],
            ),
          )
      ),
    );
  }

}