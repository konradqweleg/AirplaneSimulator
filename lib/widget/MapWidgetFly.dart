
import 'dart:ui';


import 'package:flutter/material.dart';

import '../plane/PositionPlane.dart';

class OpenPainter extends CustomPainter {


  OpenPainter(this._position);
  double _position = 0.0;


  void drawText(Canvas canvas,double positionY,String text){


    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
    );

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: 50.0,
    );

    final offset = Offset(
      75,
      positionY,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;

    var points = [Offset(100, _position)];

    canvas.drawPoints(PointMode.points, points, paint1);

    var paintStartStopPoint = Paint()
      ..color = Colors.brown
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var pointsStart = [Offset(100, 50)];
    var pointsStop = [Offset(100, 750)];
    canvas.drawPoints(PointMode.points, pointsStart, paintStartStopPoint);
    canvas.drawPoints(PointMode.points, pointsStop, paintStartStopPoint);

    var verticalHorizontPoints = [Offset(100,50 ),Offset(100, 750)];


    canvas.drawLine(verticalHorizontPoints[0], verticalHorizontPoints[1], paintStartStopPoint);
    drawText(canvas, 750,"Start");
    drawText(canvas, 20,"Stop");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class MapWidgetFly extends StatelessWidget{
  MapWidgetFly(this.map, {super.key});
  double position = 750.0;
  double METER_ON_PIXELS = 0.25;
  PositionPlane map;


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 200,
      height: 800,
      decoration:  BoxDecoration(
          border: Border.all(
            width: 1,
            color:Colors.grey,
          ),
        image: const DecorationImage(
          image: AssetImage('assets/mapfly.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: CustomPaint(
        painter: OpenPainter( 700 - (700 * map.getPercentagePathInFly())),
      ),
    );

  }

}