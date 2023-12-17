import 'package:flutter/material.dart';
import '../plane/Height.dart';
import '../plane/ThrustReversers.dart';

class ThrustReversersWidget extends StatefulWidget{

  ThrustReversersWidget(this._thrustReversers,this._height ,{super.key});
  ThrustReversers _thrustReversers;
  Height _height;


  @override
  State<StatefulWidget> createState() {
    return ThrustReversersState();
  }

}

class ThrustReversersState extends State<ThrustReversersWidget>{

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
      padding: const EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(10.0),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("ODWRACZACZE CIĄGU",style: TextStyle(fontWeight: FontWeight.bold,))

                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Wyłączone'),
                      leading: Radio(
                        value: 1,
                        groupValue: _selectedOption,
                        onChanged:  (widget._height.getHeightPlaneAboveTheGroundInMetres() > 0.001) ? null :  (int? value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._thrustReversers.disableThrustReversers();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Włączone'),
                      leading: Radio(
                        value: 2,
                        groupValue: _selectedOption,
                        onChanged: (widget._height.getHeightPlaneAboveTheGroundInMetres() > 0.001) ? null :   (int? value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._thrustReversers.enableThrustReversers();
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