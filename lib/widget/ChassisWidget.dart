import 'package:flutter/material.dart';
import '../plane/Chassis.dart';

class ChassisWidget extends StatefulWidget{

  ChassisWidget(this._chassis ,{super.key});
  Chassis _chassis;


  @override
  State<StatefulWidget> createState() {
    return BrakesState();
  }

}

class BrakesState extends State<ChassisWidget>{

  int _selectedOption = 1;

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
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._chassis.hideChassis();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Schowane'),
                      leading: Radio(
                        value: 2,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._chassis.ejectChassis();
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