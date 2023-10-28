import 'package:flutter/material.dart';

class VelocityWidget extends StatelessWidget{

  double velocityMS = 0.0;
  VelocityWidget(this.velocityMS, {super.key});

  @override
  Widget build(BuildContext context) {
   return Text((velocityMS * 3.60) .toStringAsFixed(3));
  }

}