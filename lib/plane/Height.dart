import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';

import 'Restrictor.dart';
import 'Velocity.dart';

class Height{
  double metresNPM = 0;
  double MAX_RATE_OF_CLIMB_IN_METRES_PER_SECOND = 15;

  double calculateRateOfClimb(double horizontalSpeedMetersPerSecond, double angleOfAttackDegrees) {
    double angleInRadians = angleOfAttackDegrees * (3.14159 / 180);
    // Obliczenie prędkości wznoszenia w metrach na sekundę
    return horizontalSpeedMetersPerSecond * tan(angleInRadians);
  }



  bool isNotV1Speed(Velocity velocity){
    if(metresNPM < 1.0 && velocity.velocity >= velocity.speedV1MetresPerSecond){
      return true;
    }
    return false;
  }

  void calculateStartHeight(Velocity velocity,ControlColumn controlColumn){
        if((velocity.velocity < velocity.speedV1MetresPerSecond) && (metresNPM < 1.0)){
          return;
        }else{
          if(controlColumn.xPosition < 100.0){
            metresNPM = 1.0;
          }
        }

  }



  bool isHeightInFly(Velocity velocity){
    if(metresNPM >1.0){
      return true;
    }
    return false;
  }


  void calculateHeightInFly(Velocity velocity,ControlColumn controlColumn){
    double horizontalSpeedMetersPerSecond = velocity.velocity;
    double angleOfAttackDegrees =  ( (100 -controlColumn.xPosition) /100 )*90;


    print("Pozycja y "+controlColumn.xPosition.toString());


    double rateOfClimb = calculateRateOfClimb(horizontalSpeedMetersPerSecond, angleOfAttackDegrees) * 0.30;
    print("Kąt natarcia $angleOfAttackDegrees");
    print('Prędkość wznoszenia wynosi: $rateOfClimb metrów na sekundę.');

    metresNPM = metresNPM + rateOfClimb;
  }


  void calculateHeight(Velocity velocity,ControlColumn controlColumn){

    if(isNotV1Speed(velocity)){
      calculateStartHeight(velocity,controlColumn);
    }else{
      calculateHeightInFly(velocity, controlColumn);
    }


  }








}