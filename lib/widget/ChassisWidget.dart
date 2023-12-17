import 'package:flutter/material.dart';
import '../plane/Chassis.dart';
import '../plane/Height.dart';

class ChassisWidget extends StatefulWidget{

  ChassisWidget(this._chassis,this._height ,{super.key});
  Chassis _chassis;
  Height _height;


  @override
  State<StatefulWidget> createState() {
    return BrakesState();
  }

}

class BrakesState extends State<ChassisWidget>{

  int _selectedOption = 1;
  final double NEARLY_ZERO_METRES = 0.001;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 310,
      width: 240,
      margin:const EdgeInsets.all(10.0) ,
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
                  children: [Text("PODWOZIE",style: TextStyle(fontWeight: FontWeight.bold,))

                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Wysunięte'),
                      leading: Radio(
                        value: 1,
                        groupValue: _selectedOption,
                        onChanged: widget._height.getHeightPlaneAboveTheGroundInMetres() < NEARLY_ZERO_METRES ? null : (int? value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._chassis.ejectChassis();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Schowane'),
                      leading: Radio(
                        value: 2,
                        groupValue: _selectedOption,
                        onChanged:widget._height.getHeightPlaneAboveTheGroundInMetres() < NEARLY_ZERO_METRES ? null : (int? value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._chassis.hideChassis();
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