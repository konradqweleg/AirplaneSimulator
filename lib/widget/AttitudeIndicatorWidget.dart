
import 'dart:math';
import 'dart:ui';


import 'package:flutter/material.dart';

class OpenPainterAInd extends CustomPainter {

  double verticalActualPosition = 0;
  double horizontalActualPosition = 0;

  OpenPainterAInd(this.horizontalActualPosition,this.verticalActualPosition);

  int min_x = 0;
  int max_x = 250;
  int max_y = 150;

  var verticalHorizontPoints = [Offset(0,75 ),Offset(246, 75)];
  var horizontalHorizontPoints = [Offset(125, 0),Offset(125, 150)];

  Offset rotateLine(Offset point1, Offset point2, double angleDegrees) {
    double angleRadians = angleDegrees * (pi / 180); // Konwersja kąta na radiany

    double dx = point2.dx - point1.dx;
    double dy = point2.dy - point1.dy;

    double x2 = dx * cos(angleRadians) - dy * sin(angleRadians);
    double y2 = dx * sin(angleRadians) + dy * cos(angleRadians);

    return Offset(x2 + point1.dx, y2 + point1.dy);
  }


  void drawLineVertical(Canvas canvas,double positionVertical){
    var paint1 = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 3;

    var positionX = ((250.0/200.0)*positionVertical);


    canvas.drawLine(Offset(positionX, 0),Offset(positionX,150), paint1);


    var paint2= Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    Offset twoRotate = rotateLine(Offset(positionX, 0), Offset(positionX,150), 5.0);
    canvas.drawLine(Offset(positionX, 0),twoRotate, paint2);



  }

  void drawLineHorizontal(Canvas canvas,double positionHorizontal){
    var paint1 = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 3;

    var positionY = ((150.0/200.0)*positionHorizontal);


    canvas.drawLine(Offset(0, positionY),Offset(250,positionY), paint1);


    var paint2= Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    Offset twoRotate = rotateLine(Offset(0, positionY), Offset(250,positionY), 5.0);
    canvas.drawLine(Offset(0, positionY),twoRotate, paint2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    canvas.drawLine(verticalHorizontPoints[0], verticalHorizontPoints[1], paint1);
    canvas.drawLine(horizontalHorizontPoints[0], horizontalHorizontPoints[1], paint1);
    drawLineVertical(canvas, verticalActualPosition);
    drawLineHorizontal(canvas, horizontalActualPosition);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class AttitudeInidactorWidget extends StatelessWidget{
  AttitudeInidactorWidget(this.position_horiontal,this.position_vertical, {super.key});
  double position_vertical = 100.0;
  double position_horiontal = 100;

  double START_PASS_POSITION = 750.0;
  double END_PASS_POSITION = 0.0;
  double PASS_LENGTH_IN_METER = 3000.0;
  double METER_ON_PIXELS = 0.25;



  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: 250,
          height: 150,
          decoration:  BoxDecoration(
            border: Border.all(
              width: 1,
              color:   Colors.grey,
            ),
          ),

          child: CustomPaint(
            painter: OpenPainterAInd( this.position_horiontal,this.position_vertical),
          ),
        ),

      ],
    );

  }

}