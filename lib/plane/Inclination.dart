import 'dart:math';

import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/Velocity.dart';

class Inclination{
  double _horizontalAngle = 0.0;
  double _verticalAngle = 0.0;
  static const double NEARLY_ZERO_METRES = 0.001;
  static const double MAX_CHANGE_RAW_ANGLE_PER_SECONDS = 1.0;
  static const double NEARLY_ZERO_SPEED = 0.001;
  double offsetWhenFailure = 0;

  void simulateWithPossibilityFailure(double failureChancePercentage,ControlColumn controlColumn,Height height,Velocity velocity) {//from  0.000001% to 100% on each second
    Random random = Random();
    double randomNumber = random.nextDouble() * 100000000;

    double threshold = 100000000 * failureChancePercentage;

    if (randomNumber < threshold) {
      offsetWhenFailure = random.nextDouble() * 4 - 2; //from -2 to 2
      print("błąd ${offsetWhenFailure}");
    } else {

    }

    simulate(controlColumn, height, velocity);
  }





  void simulate(ControlColumn controlColumn,Height height,Velocity velocity){

    _horizontalAngle += offsetWhenFailure;
    _verticalAngle += offsetWhenFailure;

    if((height.getHeightPlaneAboveTheGroundInMetres() > NEARLY_ZERO_METRES) || velocity.getVelocityHorizontal() > Velocity.getSpeedV1InMetresPerSeconds()) {
      if ((controlColumn.getHorizontalAngle() > _horizontalAngle)) {
        if (_horizontalAngle + controlColumn.getHorizontalAngle() > 200) {
          _horizontalAngle = 200;
        } else {
          _horizontalAngle =
              _horizontalAngle + MAX_CHANGE_RAW_ANGLE_PER_SECONDS + offsetWhenFailure;
        }
      }

      if (controlColumn.getHorizontalAngle() < _horizontalAngle) {
        if (_horizontalAngle - controlColumn.getHorizontalAngle() < 0) {
          _horizontalAngle = 0;
        } else {
          _horizontalAngle =
              _horizontalAngle - MAX_CHANGE_RAW_ANGLE_PER_SECONDS + offsetWhenFailure;
        }
      }


      if ((controlColumn.getVerticalAngle() > _verticalAngle)) {
        if (_verticalAngle + controlColumn.getVerticalAngle() > 200) {
          _verticalAngle = 200;
        } else {
          _verticalAngle = _verticalAngle + MAX_CHANGE_RAW_ANGLE_PER_SECONDS;
        }
      }

      if (controlColumn.getVerticalAngle() < _verticalAngle) {
        if (_verticalAngle - controlColumn.getVerticalAngle() < 0) {
          _verticalAngle = 0;
        } else {
          _verticalAngle = _verticalAngle - MAX_CHANGE_RAW_ANGLE_PER_SECONDS;
        }
      }
    }

  }


  double getHorizontalInclinationAngle(){
    return _horizontalAngle;
  }

  double getVerticalInclinationAngle(){
    return _verticalAngle;
  }

  double getRawHorizontalInclinationAngle(){
    double scaledValue = ((_horizontalAngle + 90) / 180) * 200;
    return scaledValue;
  }

  double getRawVerticalInclinationAngle(){
    double scaledValue = ((_verticalAngle + 90) / 180) * 200;
    return scaledValue;
  }
}