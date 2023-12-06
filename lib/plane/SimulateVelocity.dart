import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/Inclination.dart';
import 'package:airplane/plane/Warning.dart';

import 'Engine.dart';
import 'Flaps.dart';
import 'Height.dart';
import 'Restrictor.dart';
import 'Velocity.dart';

class SimulateVelocity {
  static const double _MAX_SPEED_ON_GROUND_KM_PER_HOUR = 400.0;
  static const double _MAX_SPEED_ON_FLY_KM_PER_HOUR = 1250.0;//1250
  static const double _GROUND_HEIGHT_THRESHOLD_IN_METRES = 1.0;

  static const bool _IS_LOG_ENABLED = false;
  static const double _FACTOR_METRES_HOUR_PER_SECONDS = 3.6;

  void _log(String text) {
    if (_IS_LOG_ENABLED) {
      print(text);
    }
  }

  double _changeKMPerHourToMetresOnSeconds(double kmPerHour) {
    return kmPerHour / _FACTOR_METRES_HOUR_PER_SECONDS;
  }

  double _changeMPerSecondeToKMPerHour(double mPerSecond) {
    return mPerSecond * _FACTOR_METRES_HOUR_PER_SECONDS;
  }

  //Przyspieszenie
  double _getMaxAccelerationOnOnePointInRestrictor(
      Height height, Restrictor restrictor, List<Engine> engines) {
    double maxAccelerationMetresPerSecond = 0.0;
    if (height.getHeightPlaneAboveTheGroundInMetres() <
        _GROUND_HEIGHT_THRESHOLD_IN_METRES) {
      maxAccelerationMetresPerSecond =
          _changeKMPerHourToMetresOnSeconds(_MAX_SPEED_ON_GROUND_KM_PER_HOUR);
    } else {
      maxAccelerationMetresPerSecond =
          _changeKMPerHourToMetresOnSeconds(_MAX_SPEED_ON_FLY_KM_PER_HOUR);
    }

    double maxAccelerationPerOnePointInRestrictor =
        maxAccelerationMetresPerSecond /
            (restrictor.getMaxPositionRestrictor() * engines.length);

    _log(
        "Max przyspieszenie na jeden poziom przepustnicy ${maxAccelerationPerOnePointInRestrictor}");

    return maxAccelerationPerOnePointInRestrictor;
  }

  double _evaluatePolynomial(List<double> coefficients, double x) {
    double result = 0;
    for (int i = 0; i < coefficients.length; i++) {
      result += coefficients[i] * pow(x, i);
    }
    return result;
  }

  double _getFactorMultiplyForVelocityViaControlColumn(Inclination inclination){
    double horizontalAngle = inclination.getHorizontalInclinationAngle();

    List<double> coefficients = [  1.00377426,-0.00661536715,-0.0000136571710]; // x^2 x c


    double result = _evaluatePolynomial(coefficients, horizontalAngle);


    return result;
  }

  double _getMaxAcceleration(Height height) {
    double startMaxV = 0.000017057; //przyspieszenie maksymalne
    double flyMaxV = 0.000042647;
    if (height.getHeightPlaneAboveTheGroundInMetres() <
        _GROUND_HEIGHT_THRESHOLD_IN_METRES) {
      return startMaxV;
    } else {
      return flyMaxV;
    }
  }

  double _calculateMaxVelocityOnActualPositionRestrictor(Height height, Restrictor restrictor, List<Engine> engines,Inclination inclination) {
     double maxVOnActualRestrictorPosition = (_getMaxAccelerationOnOnePointInRestrictor(height, restrictor, engines) * (restrictor.getSumPositionRestrictor()));
     double coefficientOfMaximumSpeedRelativeToTheAngleOfAttack = _getFactorMultiplyForVelocityViaControlColumn(inclination);
     double finalMaxVelocityOnPointRestrictor = maxVOnActualRestrictorPosition * coefficientOfMaximumSpeedRelativeToTheAngleOfAttack;
    return finalMaxVelocityOnPointRestrictor;
  }

  double _getMaxVelocity(Height height) {
    if (height.getHeightPlaneAboveTheGroundInMetres() <
        _GROUND_HEIGHT_THRESHOLD_IN_METRES) {
      return _changeKMPerHourToMetresOnSeconds(
          _MAX_SPEED_ON_GROUND_KM_PER_HOUR);
    } else {
      return _changeKMPerHourToMetresOnSeconds(_MAX_SPEED_ON_FLY_KM_PER_HOUR);
    }
  }

  double _calculateInfluenceClapsOnVelocity(Flaps flaps) {
    double factorToClapsPosition = 1.0;

    if (flaps.getCurrentFlapsPosition() == 0) {
      factorToClapsPosition = 1.0;
    } else if (flaps.getCurrentFlapsPosition() == 15) {
      factorToClapsPosition = 0.9;
    } else if (flaps.getCurrentFlapsPosition() == 30) {
      factorToClapsPosition = 0.65;
    } else {
      factorToClapsPosition = 0.45;
    }

    return factorToClapsPosition;
  }

  double _ifVelocityLowerThenZeroSetVelocityToZero(double rawVelocity) {
    if (rawVelocity < 0) {
      rawVelocity = 0.0;
    }
    return rawVelocity;
  }

  double _updateVelocity(
      double maxVelocityOnActualPositionRestrictor,
      double maxVelocityOnPointRestrictor,
      Inclination inclination,
      double sumPositionRestrictors,
      double actualVelocity,
      Flaps flaps) {
    _log("Aktualna prędkosc ${actualVelocity} przed zmianą");
    //If speed is lower then limit for actual restrictor position speed up
    if (actualVelocity < maxVelocityOnActualPositionRestrictor) {
      _log(
          "Wzrost prekośći  o ${(maxVelocityOnPointRestrictor * (sumPositionRestrictors))}");


      double factorIncreaseVelocityBaseOnControlColumn =
          (90 - (100 - inclination.getRawHorizontalInclinationAngle())) /
              90;

      double factorToClapsPosition = _calculateInfluenceClapsOnVelocity(flaps);

      double newVelocity = actualVelocity +
          ((maxVelocityOnPointRestrictor *
                  (sumPositionRestrictors) *
                  factorIncreaseVelocityBaseOnControlColumn) *
              factorToClapsPosition);
      _log("Powiększona prędkość ${newVelocity}");
      return newVelocity;
    } else {
      //If speed is more then max for actual restrictor position slow down

      double diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors =
          actualVelocity - maxVelocityOnActualPositionRestrictor;
      _log(
          "Różnica predkośći max dla aktualnego poziomu przepustnicy do aktualnej V ${diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors}");

      double factorToClapsPosition = _calculateInfluenceClapsOnVelocity(flaps);

      if (diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors > 0) {
        double newVelocity = actualVelocity -
            (((diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors /
                        75) +
                    1.0) *
                factorToClapsPosition);
        newVelocity = _ifVelocityLowerThenZeroSetVelocityToZero(newVelocity);
        return newVelocity;
      } else {
        return actualVelocity;
      }
    }
  }

  void _analiseWarningClapPosition(
      Flaps flaps, Restrictor restritor, Height height) {
    if (flaps.getCurrentFlapsPosition() != 15 &&
        flaps.getCurrentFlapsPosition() != 30 &&
        height.getHeightPlaneAboveTheGroundInMetres() < 0.001 &&
        ((restritor.getSumPositionRestrictor()) > 0)) {
      Warning.setBadClapError();
    } else {
      Warning.clearErrorBadClapPosition();
    }
  }

  Velocity getActualAcceleration(
      List<Engine> engines,
      Restrictor restrictor,
      Height height,
      Velocity actualVelocity,
      Inclination inclination,
      Flaps flaps) {
    _analiseWarningClapPosition(flaps, restrictor, height);

    double maxSpeedOnActualPositionRestrictor =
        _calculateMaxVelocityOnActualPositionRestrictor(
            height, restrictor, engines,inclination);
    double maxSpeedOnPointRestrictor = _getMaxAcceleration(height);

    double maxVelocityOnPhaseFly = _getMaxVelocity(height);
    //print("MAX predkość ${maxVelocityOnPhaseFly} vs aktualba ${ (actualVelocity.velocity)}");

    actualVelocity.setVelocityHorizontal(
        _updateVelocity(
          maxSpeedOnActualPositionRestrictor,
          maxSpeedOnPointRestrictor,
          inclination,
          restrictor.getSumPositionRestrictor(),
          actualVelocity.getVelocityHorizontal(),
          flaps
        )
    );

    if (actualVelocity.getVelocityHorizontal() > maxVelocityOnPhaseFly) {
      actualVelocity.setVelocityHorizontal(maxVelocityOnPhaseFly);
      return actualVelocity;
    }

    return actualVelocity;
  }
}
