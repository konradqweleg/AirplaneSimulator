import 'dart:html';
import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/Warning.dart';
import 'Flaps.dart';
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
    if(metresNPM < 1.0 && velocity.velocityHorizontal <= velocity.speedV1MetresPerSecond){
      return true;
    }
    return false;
  }

  void calculateStartHeight(Velocity velocity,ControlColumn controlColumn){
        if((velocity.velocityHorizontal < velocity.speedV1MetresPerSecond)){
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
    double horizontalSpeedMetersPerSecond = velocity.velocityHorizontal;
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


  double calculateCL(double degrees,Flaps flaps){
    double liftCoefficientCL = 0.0;
    double maxForActualProfileWings = 1.5;
    double minForZeroDegrees = 0.5;



    List<double> actualCoefficientsCL = [-0.000000668968542,0.000131969308,-0.00834117785,0.164330792,0.458479337];

    if(flaps.getCurrentFlapsPosition() == 0){
      actualCoefficientsCL = [-0.000000668968542,0.000131969308,-0.00834117785,0.164330792,0.458479337];
    }else if(flaps.getCurrentFlapsPosition() == 15){
      actualCoefficientsCL = [-0.00000101 , 0.00019105, -0.01122009,  0.19316515 , 0.74044567];
    }else if(flaps.getCurrentFlapsPosition() == 30){
      actualCoefficientsCL = [-0.00000131,  0.00023987, -0.0134915,   0.21542229 , 0.9310216];
    }else{
      actualCoefficientsCL = [-0.00000146,  0.00025583 ,-0.01324251 , 0.1719971  , 1.34867048];
    }



    if(degrees < 60){
      liftCoefficientCL = calculatePolynomialValue(actualCoefficientsCL, degrees);
    }else{
      liftCoefficientCL = calculatePolynomialValue(actualCoefficientsCL, 60.0)/ (degrees/20);
    }


    return liftCoefficientCL;

  }




  bool calculateIfStall(Velocity velocity,ControlColumn controlColumn,Flaps flaps){

    double cl = calculateCL(controlColumn.getHorizontalAngle(),flaps);

    double wingAreaM2 = 124.6;
    double densityGroundKgPerM3 = 1.125;
    double density13KMNPMKgPerM3 = 0.1935;
    double rangeDensity =  densityGroundKgPerM3 - density13KMNPMKgPerM3;
    double actualDensity =  densityGroundKgPerM3 -  (metresNPM/13000) * rangeDensity;


    double liftForce = (1/2) * cl * actualDensity  * velocity.velocityHorizontal * wingAreaM2;

    double STALL_THRESHOOLD = 3000.0;
    print("Lift force ${liftForce}  ${liftForce < STALL_THRESHOOLD ? 'PRZECIĄGNIECIE':''}");
    print("Prędkość ${velocity.velocityHorizontal*3.6}");

    if(liftForce < STALL_THRESHOOLD){
      Warning.isCloseStall = true;
    }else{
      Warning.isCloseStall = false;
    }

    return liftForce < STALL_THRESHOOLD;

  }


  bool first = false;


  void calculateWarningHeight(){
    if(metresNPM < 200.0){
      Warning.isLowHeight = true;
    }else{
      Warning.isLowHeight = false;
    }
  }

  void calculateHeight(Velocity velocity,ControlColumn controlColumn,Flaps flaps){

    calculateWarningHeight();

   if(isNotV1Speed(velocity)){
     calculateStartHeight(velocity,controlColumn);
   }else{
     bool ifStall = calculateIfStall(velocity, controlColumn,flaps);
     if(ifStall){
        velocity.velocityHorizontal -= 2.0;
        velocity.velocityVertical += 3.0;
        metresNPM -= velocity.velocityVertical;


     }else {
        velocity.velocityVertical = 0.0;
        calculateHeightInFly(velocity, controlColumn);
     }
   }




  }








}