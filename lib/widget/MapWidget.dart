
import 'dart:ui';


import 'package:flutter/material.dart';

class OpenPainter extends CustomPainter {

  double _position = 750;
  OpenPainter(this._position);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;

    var points = [Offset(100, _position)];

    canvas.drawPoints(PointMode.points, points, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class MapWidget extends StatelessWidget{
  MapWidget(this._position, {super.key});
  double _position = 750.0;
  double _METER_ON_PIXELS = 0.25;



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
        painter: OpenPainter( (3000 - _position) * _METER_ON_PIXELS),
      ),
    );

  }

}