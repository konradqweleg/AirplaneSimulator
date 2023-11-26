
import 'dart:ui';


import 'package:flutter/material.dart';

import '../plane/MapPlane.dart';

class OpenPainter extends CustomPainter {


  OpenPainter(this.position);
  double position = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;

    var points = [Offset(100, position)];

    canvas.drawPoints(PointMode.points, points, paint1);

    var paintStartStopPoint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;

    var pointsStart = [Offset(100, 50)];
    var pointsStop = [Offset(100, 750)];
    canvas.drawPoints(PointMode.points, pointsStart, paintStartStopPoint);
    canvas.drawPoints(PointMode.points, pointsStop, paintStartStopPoint);

    var verticalHorizontPoints = [Offset(100,50 ),Offset(100, 750)];


    canvas.drawLine(verticalHorizontPoints[0], verticalHorizontPoints[1], paintStartStopPoint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class MapWidgetFly extends StatelessWidget{
  MapWidgetFly(this.map, {super.key});
  double position = 750.0;
  double METER_ON_PIXELS = 0.25;
  MapPlane map;


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
        image: DecorationImage(
          image: AssetImage('assets/mapfly.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: CustomPaint(
        painter: OpenPainter( 750 - (750 * map.getPercentagePath())),
      ),
    );

  }

}