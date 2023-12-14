import 'package:flutter/material.dart';
import '../plane/Brakes.dart';

class BrakesWidget extends StatefulWidget{

  BrakesWidget(this._brakes ,{super.key});
  Brakes _brakes;


  @override
  State<StatefulWidget> createState() {
    return BrakesState();
  }

}

class BrakesState extends State<BrakesWidget>{

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
                  children: [Text("HAMULCE",style: TextStyle(fontWeight: FontWeight.bold,))

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
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._brakes.disableBrakes();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Włączone'),
                      leading: Radio(
                        value: 2,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                            widget._brakes.enableBrakes();
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