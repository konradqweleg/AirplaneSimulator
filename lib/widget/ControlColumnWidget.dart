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
    return Column(
      children: [
        Container(
          height: 40,
          width: 240,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("^"), Text("<>")],
          ),
        ),
        Container(
          height: 300,
          width: 240,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: Slider(
                  value: widget.controlColumn.xPosition,
                  max: 200.0,
                  onChanged: (newValue) {
                    setState(() {
                      widget.controlColumn.xPosition = newValue;

                    });
                  },
                ),
              ),
              Slider(
                value: widget.controlColumn.yPosition,
                max: 200.0,
                onChanged: (newValue) {
                  setState(() {
                    widget.controlColumn.yPosition = newValue;

                  });
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
