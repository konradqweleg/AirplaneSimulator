
import 'dart:ui';


import 'package:flutter/material.dart';

class OpenPainter extends CustomPainter {

  double position = 750;
  OpenPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;

    var points = [Offset(100, position)];

    canvas.drawPoints(PointMode.points, points, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class MapWidget extends StatelessWidget{
  MapWidget(this.position, {super.key});
  double position = 750.0;

  double START_PASS_POSITION = 750.0;
  double END_PASS_POSITION = 0.0;
  double PASS_LENGTH_IN_METER = 3000.0;
  double METER_ON_PIXELS = 0.25;



  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 200,
      height: 800,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/runway.png'),
          fit: BoxFit.cover,
        ),
      ),

      child: CustomPaint(
        painter: OpenPainter( (3000 - position) * METER_ON_PIXELS),
      ),
    );

  }

}