import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';

import 'Restrictor.dart';
import 'Velocity.dart';
//Sprawdz prędkość
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
    double angleOfAttackDegrees =  ( (100 -controlColumn.horizontalPosition) /100 )*90;


    print("Pozycja y "+controlColumn.horizontalPosition.toString());


    double rateOfClimb = calculateRateOfClimb(horizontalSpeedMetersPerSecond, angleOfAttackDegrees) * 0.30;
    print("Kąt natarcia $angleOfAttackDegrees");
    print('Prędkość wznoszenia wynosi: $rateOfClimb metrów na sekundę.');

    metresNPM = metresNPM + rateOfClimb;
  }



  double degreesToRadians(double degrees) {
    return degrees * (3.14159 / 180); // Zamiana stopni na radiany (π ≈ 3.14159)
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


    // if (degrees <= 15) {
    //   liftCoefficientCL = minForZeroDegrees + (maxForActualProfileWings * sin(degreesToRadians(degrees)));
    // } else if (degrees <= 30) {
    //   liftCoefficientCL = minForZeroDegrees + (maxForActualProfileWings * sin(degreesToRadians( 15 - ( degrees - 15))));
    // } else if (degrees <= 45) {
    //   liftCoefficientCL = (minForZeroDegrees/2) + (maxForActualProfileWings * sin(degreesToRadians(45 - (degrees - 45))) * 0.8);
    // } else {
    //   liftCoefficientCL = (minForZeroDegrees/8) + (maxForActualProfileWings * sin(degreesToRadians(45 - (degrees - 45))) * 0.5);
    // }


    return liftCoefficientCL;

  }

  void calculateIfStall(Velocity velocity,ControlColumn controlColumn){
    //double maxSpeedInMetersPerSecond = 277.77;
    //double minSpeedInFly = 72.2;

    double cl = calculateCL(controlColumn.getHorizontalAngle());
    print("CL = ${cl}");

    double wingAreaM2 = 124.6;

    double densityGroundKgPerM3 = 1.125;
    double density13KMNPMKgPerM3 = 0.1935;
    double rangeDensity =  densityGroundKgPerM3 - density13KMNPMKgPerM3;
    double actualDensity =  densityGroundKgPerM3 -  (metresNPM/13000) * rangeDensity;
    print("Actual density ${actualDensity}");

    double liftForce = (1/2) * cl * actualDensity  * velocity.velocity * wingAreaM2;
    print("Lift force ${liftForce}");




  }

  void calculateHeight(Velocity velocity,ControlColumn controlColumn){
    print("Kąt poziomy ${controlColumn.getHorizontalAngle()}");
    print("Kąt pionowy ${controlColumn.getVerticalAngle()}");

    if(isNotV1Speed(velocity)){
      calculateStartHeight(velocity,controlColumn);
    }else{
      calculateHeightInFly(velocity, controlColumn);
    }

    calculateIfStall(velocity, controlColumn);


  }








}