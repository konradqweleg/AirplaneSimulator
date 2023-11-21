import 'dart:html';
import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';
import 'Velocity.dart';

class Height{
  double metresNPM = 0;
  double MAX_RATE_OF_CLIMB_IN_METRES_PER_SECOND = 15;

  double calculateRateOfClimb(double horizontalSpeedMetersPerSecond, double angleOfAttackDegrees) {
    //When tg >70.0 increase height is too high
    if(angleOfAttackDegrees > 70.0){
      angleOfAttackDegrees = 70.0;
    }

    if(angleOfAttackDegrees < -70.00){
      angleOfAttackDegrees = -70.00;
    }

    double angleInRadians = angleOfAttackDegrees * (3.14159 / 180);
    return horizontalSpeedMetersPerSecond * tan(angleInRadians);

  }



  bool isNotV1Speed(Velocity velocity){
    if(metresNPM < 1.0 && velocity.velocity <= velocity.speedV1MetresPerSecond){
      return true;
    }
    return false;
  }

  void calculateStartHeight(Velocity velocity,ControlColumn controlColumn){
        if((velocity.velocity < velocity.speedV1MetresPerSecond)){
          return;
        }else{
          if(controlColumn.horizontalPosition < 100.0){
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
    double angleOfAttackDegrees =  controlColumn.getHorizontalAngle();
    double rateOfClimb = calculateRateOfClimb(horizontalSpeedMetersPerSecond, angleOfAttackDegrees) * 0.30;

    metresNPM = metresNPM + rateOfClimb;
  }



  double degreesToRadians(double degrees) {
    return degrees * (3.14159 / 180);
  }


  double calculatePolynomialValue(List<double> coefficients, double x) {
    double result = 0;
    int power = coefficients.length - 1;

    for (double coefficient in coefficients) {
      result += coefficient * pow(x, power);
      power--;
    }

    return result;
  }


  double calculateCL(double degrees){
    double liftCoefficientCL = 0.0;
    double maxForActualProfileWings = 1.5;
    double minForZeroDegrees = 0.5;

    List<double> coefficientsCL = [-0.000000668968542,0.000131969308,-0.00834117785,0.164330792,0.458479337];

    if(degrees < 60){
      liftCoefficientCL = calculatePolynomialValue(coefficientsCL, degrees);
    }else{
      liftCoefficientCL = calculatePolynomialValue(coefficientsCL, 60.0)/ (degrees/20);
    }


    return liftCoefficientCL;

  }

  void calculateIfStall(Velocity velocity,ControlColumn controlColumn){

    double cl = calculateCL(controlColumn.getHorizontalAngle());

    double wingAreaM2 = 124.6;
    double densityGroundKgPerM3 = 1.125;
    double density13KMNPMKgPerM3 = 0.1935;
    double rangeDensity =  densityGroundKgPerM3 - density13KMNPMKgPerM3;
    double actualDensity =  densityGroundKgPerM3 -  (metresNPM/13000) * rangeDensity;


    double liftForce = (1/2) * cl * actualDensity  * velocity.velocity * wingAreaM2;
    print("Lift force ${liftForce}  ${liftForce < 2200.0 ? 'PRZECIĄGNIECIE':''}");


  }


  bool first = false;
  void calculateHeight(Velocity velocity,ControlColumn controlColumn){

   if(isNotV1Speed(velocity)){
     calculateStartHeight(velocity,controlColumn);
   }else{
      calculateHeightInFly(velocity, controlColumn);
   }

    calculateIfStall(velocity, controlColumn);


  }








}