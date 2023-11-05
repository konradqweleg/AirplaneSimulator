import 'package:flutter/material.dart';

import '../plane/Restrictor.dart';

class RestrictorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RestrictorWidgetState();
  }

  Restritor restrictor;
  RestrictorWidget(this.restrictor);
}

class RestrictorWidgetState extends State<RestrictorWidget> {



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
            children: [Text("PRZEPUSTNICA",style: TextStyle(fontWeight: FontWeight.bold))

            ],
          ),
          Container(
            height: 40,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("L"), Text("O"), Text("P")],
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
                    value: widget.restrictor.left,
                    max: 121000.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget.restrictor.left = newValue;

                      });
                    },
                  ),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget.restrictor.both,
                    max: 121000.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget.restrictor.left = newValue;
                        widget.restrictor.right = newValue;
                        widget.restrictor.both = newValue;

                      });
                    },
                  ),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget.restrictor.right,
                    max: 121000.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget.restrictor.right = newValue;
                        widget.restrictor.right = newValue;

                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
