import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/FlapsPosition.dart';
import 'package:airplane/plane/Warning.dart';
import 'Flaps.dart';
import 'Velocity.dart';

class Height {
  double _metresPlaneAboveTheGround = 0;
  static const double MAX_RATE_OF_CLIMB_IN_METRES_PER_SECOND = 15;
  static const double THRESHOLD_MAX_CALCULATION_ANGLE = 70.0;
  static const double ONE_METRES = 1.0;
  static const double ZERO_METRES = 0.0;
  static const double FACTOR_RATE_OF_CLIMB = 0.3; //decreasing rate of climb


  static const List<double> _coefficientClForClapRetractedPosition_0 = [
    -0.000000668968542,
    0.000131969308,
    -0.00834117785,
    0.164330792,
    0.458479337
  ];

  static const List<double>  _coefficientClForClapTakeOffPosition_15 = [
    -0.00000101,
    0.00019105,
    -0.01122009,
    0.19316515,
    0.74044567
  ];

  static const List<double>  _coefficientClForClapTakeOffPosition_30 = [
    -0.00000131,
    0.00023987,
    -0.0134915,
    0.21542229,
    0.9310216
  ];

  static const List<double> _coefficientClForClapExtendedPosition_45   =  [
    -0.00000146,
    0.00025583,
    -0.01324251,
    0.1719971,
    1.34867048
  ];






  double getHeightPlaneAboveTheGroundInMetres() {
    return _metresPlaneAboveTheGround;
  }

  double _calculateRealAngleForAttackTrimToMax70(double angleOfAttackDegrees) {
    // If angle is more than 70 degrees set 70 degrees
    if (angleOfAttackDegrees > THRESHOLD_MAX_CALCULATION_ANGLE) {
      angleOfAttackDegrees = THRESHOLD_MAX_CALCULATION_ANGLE;
    }

    if (angleOfAttackDegrees < -THRESHOLD_MAX_CALCULATION_ANGLE) {
      angleOfAttackDegrees = -THRESHOLD_MAX_CALCULATION_ANGLE;
    }

    return angleOfAttackDegrees;
  }

  double calculateRateOfClimb(double horizontalSpeedMetersPerSecond, double angleOfAttackDegrees) {

    angleOfAttackDegrees = _calculateRealAngleForAttackTrimToMax70(angleOfAttackDegrees);
    double angleInRadians = angleOfAttackDegrees * (3.14159 / 180);

    double scaleRateOfClimb = (horizontalSpeedMetersPerSecond * tan(angleInRadians)) * FACTOR_RATE_OF_CLIMB;
    return scaleRateOfClimb;
  }

  bool _isNotV1Speed(Velocity velocity) {
    if ((_metresPlaneAboveTheGround < ONE_METRES) &&
        (velocity.velocityHorizontal <= velocity.speedV1MetresPerSecond)) {
      return true;
    }
    return false;
  }

  bool _isPlaneHasV1Speed(Velocity velocity) {
    return velocity.velocityHorizontal < velocity.speedV1MetresPerSecond;
  }

  bool _isAngleAscent(ControlColumn controlColumn) {
    return controlColumn.getHorizontalAngle() > ZERO_METRES;
  }

  void _startFlight(){
    _metresPlaneAboveTheGround = ONE_METRES;
  }

  void _calculateIfPlaneCanStartingFly(Velocity velocity, ControlColumn controlColumn) {
    if (_isPlaneHasV1Speed(velocity) && _isAngleAscent(controlColumn)) {
      _startFlight();
    }
  }

  bool _isPlaneIsInAir(Velocity velocity) {
    if (_metresPlaneAboveTheGround > ONE_METRES) {
      return true;
    }
    return false;
  }


  void _ifCalculationHeightOnAirOnLowerThenZeroMetresSetZeroMetres(double rateOfClimb){//czy to potrzebne w ogóle ?
    if ((_metresPlaneAboveTheGround + rateOfClimb) < 0) {
      _metresPlaneAboveTheGround = 0;
    }
  }

  void calculateHeightInAir(Velocity velocity, ControlColumn controlColumn) {
    double horizontalSpeedMetersPerSecond = velocity.velocityHorizontal;
    double angleOfAttackDegrees = controlColumn.getHorizontalAngle();
    double rateOfClimb = calculateRateOfClimb(horizontalSpeedMetersPerSecond, angleOfAttackDegrees);

    _ifCalculationHeightOnAirOnLowerThenZeroMetresSetZeroMetres(rateOfClimb);
    _metresPlaneAboveTheGround = _metresPlaneAboveTheGround + rateOfClimb;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.14159 / 180);
  }

  double _calculatePolynomialValue(List<double> coefficients, double x) {
    double result = 0;
    int power = coefficients.length - 1;

    for (double coefficient in coefficients) {
      result += coefficient * pow(x, power);
      power--;
    }

    return result;
  }



  List<double> _getCoefficientClForClapPosition(Flaps flaps){
    List<double> actualCoefficientsCL = _coefficientClForClapRetractedPosition_0;

    if (flaps.getFlapsPosition() == FlapsPosition.retracted) {
      actualCoefficientsCL = _coefficientClForClapRetractedPosition_0;
    } else if (flaps.getFlapsPosition() == FlapsPosition.takeoff) {
      actualCoefficientsCL = _coefficientClForClapTakeOffPosition_15;
    } else if (flaps.getFlapsPosition() == FlapsPosition.landing) {
      actualCoefficientsCL = _coefficientClForClapTakeOffPosition_30;
    } else {
      actualCoefficientsCL = _coefficientClForClapExtendedPosition_45;
    }

    return actualCoefficientsCL;
  }

  //Calculates the lift coefficient based on the angle of attack and flap position
  double _calculateCLBasedOnDegreesAttackAndFlapsPosition(double degrees, Flaps flaps) {
    double liftCoefficientCL = 0.0;

    List<double> actualCoefficientsCL = _getCoefficientClForClapPosition(flaps);

    if (degrees < 60) {
      liftCoefficientCL =
          _calculatePolynomialValue(actualCoefficientsCL, degrees);
    } else {
      liftCoefficientCL =
          _calculatePolynomialValue(actualCoefficientsCL, 60.0) / (degrees / 20);
    }

    return liftCoefficientCL;
  }

  double WARNING_INFO_LEVEL = 500;

  bool calculateIfStall(
      Velocity velocity, ControlColumn controlColumn, Flaps flaps) {
    double cl = _calculateCLBasedOnDegreesAttackAndFlapsPosition(controlColumn.getHorizontalAngle(), flaps);

    double wingAreaM2 = 124.6;
    double densityGroundKgPerM3 = 1.125;
    double density13KMNPMKgPerM3 = 0.0;
    double rangeDensity = densityGroundKgPerM3 - density13KMNPMKgPerM3;
    double actualDensity = densityGroundKgPerM3 -
        (_metresPlaneAboveTheGround / 13000) * rangeDensity;

    double liftForce =
        (1 / 2) * cl * actualDensity * velocity.velocityHorizontal * wingAreaM2;

    double STALL_THRESHOOLD = 3000.0;
    print(
        "Lift force ${liftForce}  ${liftForce < STALL_THRESHOOLD ? 'PRZECIĄGNIECIE' : ''}");
    print("Prędkość ${velocity.velocityHorizontal * 3.6}");

    if ((liftForce < (STALL_THRESHOOLD + WARNING_INFO_LEVEL)) &&
        (controlColumn.getHorizontalAngle() >= 0)) {
      Warning.isCloseStall = true;
    } else {
      Warning.isCloseStall = false;
    }

    if (controlColumn.getHorizontalAngle() >= 0) {
      return liftForce < STALL_THRESHOOLD;
    } else {
      return false;
    }
  }

  bool first = false;

  void calculateWarningHeight(Velocity velocity) {
    if (_metresPlaneAboveTheGround < 200.0 &&
        velocity.velocityHorizontal > 100.0) {
      Warning.isLowHeight = true;
    } else {
      Warning.isLowHeight = false;
    }
  }

  void calculateHeight(
      Velocity velocity, ControlColumn controlColumn, Flaps flaps) {
    print("Wysokość ${_metresPlaneAboveTheGround}");
    calculateWarningHeight(velocity);

    if (_isNotV1Speed(velocity)) {
      _calculateIfPlaneCanStartingFly(velocity, controlColumn);
    } else {
      if (_metresPlaneAboveTheGround > 0) {
        bool ifStall = calculateIfStall(velocity, controlColumn, flaps);

        if (ifStall) {
          velocity.velocityHorizontal -= 2.0;
          velocity.velocityVertical += 3.0;
          _metresPlaneAboveTheGround -= velocity.velocityVertical;
        } else {
          velocity.velocityVertical = 0.0;
          calculateHeightInAir(velocity, controlColumn);
        }
      } else {
        _calculateIfPlaneCanStartingFly(velocity, controlColumn);
      }

      if (_metresPlaneAboveTheGround < 0) {
        _metresPlaneAboveTheGround = 0;
      }
    }
  }
}
