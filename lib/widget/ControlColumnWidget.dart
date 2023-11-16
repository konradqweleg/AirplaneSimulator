import 'package:flutter/material.dart';

import '../plane/ControlColumn.dart';
import '../plane/Restrictor.dart';


class ControlColumnWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ControlColumnWidgetState();
  }

  ControlColumn controlColumn;
  ControlColumnWidget(this.controlColumn, {super.key});
}

class ControlColumnWidgetState extends State<ControlColumnWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color:   Colors.grey,
        ),

      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("WOLANT",style: TextStyle(fontWeight: FontWeight.bold))

            ],
          ),
          Container(
            height: 40,
            width: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("PION"), Text("POZIOM")],
            ),
          ),
          Container(
            height: 250,
            width: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget.controlColumn.horizontalPosition,
                    max: 200.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget.controlColumn.horizontalPosition = newValue;

                      });
                    },
                  ),
                ),
                Slider(
                  value: widget.controlColumn.verticalPosition,
                  max: 200.0,
                  onChanged: (newValue) {
                    setState(() {
                      widget.controlColumn.verticalPosition = newValue;

                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
