
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





  void drawCrossPattern(Canvas canvas){

    var colorCrossPatternLine = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    var verticalHorizontPoints = [Offset(0,75 ),Offset(246, 75)];
    var horizontalHorizontPoints = [Offset(125, 0),Offset(125, 150)];

     canvas.drawLine(verticalHorizontPoints[0], verticalHorizontPoints[1], colorCrossPatternLine);
     canvas.drawLine(horizontalHorizontPoints[0], horizontalHorizontPoints[1], colorCrossPatternLine);

  }


  void drawHorizonBackground(Canvas canvas){
    var skyBackgroundColor = Paint()
      ..color = const HSLColor.fromAHSL(1.0, 210, 0.3, 0.7).toColor()
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    double leftSkyPosition = 0;
    double topSkyPosition = 0;
    double rightSkyPosition = 250;
    double bottomSkyPosition = 75;

    Rect rectSky = Rect.fromLTRB(leftSkyPosition, topSkyPosition, rightSkyPosition, bottomSkyPosition);
    canvas.drawRect(rectSky, skyBackgroundColor);


    var groundBackgroundColor = Paint()
      ..color = Colors.brown
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1;

    double leftGroundPosition = 0;
    double topGroundPosition = 75;
    double rightGroundPosition = 250;
    double bottomGroundPosition = 150;

    Rect rectGround = Rect.fromLTRB(leftGroundPosition, topGroundPosition, rightGroundPosition, bottomGroundPosition);
    canvas.drawRect(rectGround, groundBackgroundColor);


  }


  List<Offset> rotateLine(Offset point1, Offset point2, double angleDegrees) {
    // Oblicz środek odcinka
    double centerX = (point1.dx + point2.dx) / 2;
    double centerY = (point1.dy + point2.dy) / 2;

    // Przesunięcie punktów względem środka odcinka
    double dx1 = point1.dx - centerX;
    double dy1 = point1.dy - centerY;
    double dx2 = point2.dx - centerX;
    double dy2 = point2.dy - centerY;

    // Konwersja kąta na radiany
    double angleRadians = angleDegrees * (pi / 180);

    // Obliczenia obrotu
    double x1 = dx1 * cos(angleRadians) - dy1 * sin(angleRadians);
    double y1 = dx1 * sin(angleRadians) + dy1 * cos(angleRadians);
    double x2 = dx2 * cos(angleRadians) - dy2 * sin(angleRadians);
    double y2 = dx2 * sin(angleRadians) + dy2 * cos(angleRadians);

    // Przesunięcie punktów z powrotem
    x1 += centerX;
    y1 += centerY;
    x2 += centerX;
    y2 += centerY;

    return [Offset(x1, y1),Offset(x2, y2)];
  }

  void drawLineVertical(Canvas canvas,double positionVertical,double positionHorizontal){
    var lineColor = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5;

    var positionX = ((250.0/200.0)*positionVertical);


    canvas.drawLine(Offset(positionX, 0),Offset(positionX,150), lineColor);


  }


  void drawLineAttitideIndicator(Canvas canvas,double positionVertical,double positionHorizontal){
    var lineColor = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5;


    var positionY = ((150.0/200.0)*positionHorizontal);
    double rotateAngle = (((positionVertical/200)* 90)-45);

    List<Offset> twoRotate = rotateLine(Offset(0, positionY), Offset(250,positionY), rotateAngle);
    canvas.drawLine(twoRotate[0],twoRotate[1], lineColor);
  }

  void drawLineHorizontal(Canvas canvas,double positionHorizontal){
    var lineHorizontalColor = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 5;

    var positionY = ((150.0/200.0)*positionHorizontal);


    canvas.drawLine(Offset(0, positionY),Offset(250,positionY), lineHorizontalColor);

  }

  @override
  void paint(Canvas canvas, Size size) {


    drawHorizonBackground(canvas);
    // drawCrossPattern(canvas);

    drawLineAttitideIndicator(canvas, verticalActualPosition,horizontalActualPosition);
  //  drawLineVertical(canvas, verticalActualPosition,horizontalActualPosition);
  //  drawLineHorizontal(canvas, horizontalActualPosition);

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