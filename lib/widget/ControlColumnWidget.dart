import 'package:flutter/material.dart';

import '../plane/ControlColumn.dart';
import '../plane/Restrictor.dart';


class ControlColumnWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ControlColumnWidgetState();
  }

  ControlColumn _controlColumn;
  ControlColumnWidget(this._controlColumn, {super.key});
}

class ControlColumnWidgetState extends State<ControlColumnWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration:  BoxDecoration(
        border: Border.all(
          width: 1,
          color:   Colors.grey,
        ),

      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("WOLANT",style: TextStyle(fontWeight: FontWeight.bold))

            ],
          ),
          const SizedBox(
            height: 40,
            width: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("PION"), Text("POZIOM")],
            ),
          ),
          SizedBox(
            height: 250,
            width: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget._controlColumn.getRawHorizontalControlColumnPosition(),
                    max: 200.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget._controlColumn.setRawHorizontalControlColumnPosition(newValue);
                      });
                    },
                  ),
                ),
                Slider(
                  value: widget._controlColumn.getRawVerticalControlColumnPosition(),
                  max: 200.0,
                  onChanged: (newValue) {
                    setState(() {
                      widget._controlColumn.setRawVerticalControlColumnPosition(newValue);
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
