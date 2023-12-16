import 'package:flutter/material.dart';

import '../plane/Restrictor.dart';

class RestrictorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RestrictorWidgetState();
  }

  Restrictor _restrictor;
  RestrictorWidget(this._restrictor, {super.key});
}

class RestrictorWidgetState extends State<RestrictorWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(

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
            children: [Text("PRZEPUSTNICA",style: TextStyle(fontWeight: FontWeight.bold))

            ],
          ),
          Container(
            height: 40,
            width: 200,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("L"), Text("O"), Text("P")],
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
                    value: widget._restrictor.getLeftPositionRestrictor(),
                    max: 121000.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget._restrictor.setLeftPositionRestrictor(newValue);

                      });
                    },
                  ),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget._restrictor.getBothRestrictorPosition(),
                    max: 121000.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget._restrictor.setLeftPositionRestrictor(newValue);
                        widget._restrictor.setRightPositionRestrictor(newValue);
                        widget._restrictor.setBothRestrictorPosition(newValue);
                      });
                    },
                  ),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    value: widget._restrictor.getRightPositionRestrictor(),
                    max: 121000.0,
                    onChanged: (newValue) {
                      setState(() {
                        widget._restrictor.setRightPositionRestrictor(newValue);

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
