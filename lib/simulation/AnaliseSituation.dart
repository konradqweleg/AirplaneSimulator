import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/PositionPlane.dart';
import 'package:airplane/plane/Velocity.dart';

import '../plane/Flaps.dart';

class AnaliseSituation {
  static const  double _MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS = 333.3;
  String _crashReason = "";
  bool _isCrash = false;
  bool _isLandingOk = false;

  static const double _NEARLY_ZERO_VALUE = 0.001;
  static const double _END_RUN_WAY_OFFSET = 500; //Used to distinguish between runway excursions and off-airport accidents

  bool _isNotSafetySpeedVertical(Velocity velocity) {
    return velocity.getVelocityVertical() >
        _MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS;
  }

  bool _isCorrectHeight(Height height, PositionPlane positionPlane) {
    if (positionPlane.position < PositionPlane.endRunway) {
      return true;
    } else if (positionPlane.position > PositionPlane.endRunway &&
        (positionPlane.position <
            (PositionPlane.endRunway + PositionPlane.endFlightPosition))) {
      if (height.getHeightPlaneAboveTheGroundInMetres() < 0.001) {
        return false;
      }
    } else if (positionPlane.position >
        (PositionPlane.endRunway + PositionPlane.endFlightPosition)) {
      return true;
    }
    return true;
  }

  bool _isCrashByHitOnGround(Height height, PositionPlane positionPlane) {
    return !_isCorrectHeight(height, positionPlane);
  }

  bool _isOutsideRunWayOnGround(Height height, PositionPlane positionPlane) {
    if ((positionPlane.position > PositionPlane.endRunway) &&
        (height.getHeightPlaneAboveTheGroundInMetres() < _NEARLY_ZERO_VALUE) &&
        (positionPlane.position < (PositionPlane.endRunway + _END_RUN_WAY_OFFSET))) {
      //Staring
      return true;
    } else if ((positionPlane.position >
            (PositionPlane.endRunway +
                PositionPlane.endFlightPosition +
                PositionPlane.endRunway)) &&
        (height.getHeightPlaneAboveTheGroundInMetres() < _NEARLY_ZERO_VALUE)) {
      //Landing
      return true;
    }

    return false;
  }

  bool _isLandingCorrectly(
      Velocity velocity, Height height, PositionPlane positionPlane) {
    if ((positionPlane.position >
            (PositionPlane.endRunway + PositionPlane.endFlightPosition)) &&
        (height.getHeightPlaneAboveTheGroundInMetres() < _NEARLY_ZERO_VALUE) &&
        (velocity.getVelocityHorizontal() < _NEARLY_ZERO_VALUE)) {
      return true;
    }
    return false;
  }

  bool isCrashFlight() {
    return _isCrash;
  }

  String getCrashReason() {
    return _crashReason;
  }

  bool getIsLandingOk() {
    return _isLandingOk;
  }

  void _setCrashPlane(String reason) {
    _isCrash = true;
    _crashReason = reason;
  }

  void _resetCrashPlaneStatus() {
    _isCrash = false;
    _crashReason = "";
  }

  void analiseActualPlaneSituation(
      Velocity velocity, Height height, PositionPlane positionPlane,Flaps flaps) {
    _analisePotentialCrashPlane(velocity, height, positionPlane,flaps);
    _analiseIfActualIsCorrectLanding(velocity, height, positionPlane);
  }

  void _analiseIfActualIsCorrectLanding(
      Velocity velocity, Height height, PositionPlane positionPlane) {
    _isLandingOk = _isLandingCorrectly(velocity, height, positionPlane);
  }

  bool _ifBadClapPositionOnStartAndLanding(Flaps flaps,Height height){
    if( (height.getHeightPlaneAboveTheGroundInMetres()) > 0.001 &&  (height.getHeightPlaneAboveTheGroundInMetres() < 100)) {
      if (flaps.getCurrentFlapsPosition() < 15) {
        return true;
      }
      return false;
    }else{
      return false;
    }
  }

  void _analisePotentialCrashPlane(Velocity velocity, Height height, PositionPlane positionPlane,Flaps flaps) {
    if (_isNotSafetySpeedVertical(velocity)) {
      _setCrashPlane("Za duża prędkość");
    } else if (_isOutsideRunWayOnGround(height, positionPlane)) {
      _setCrashPlane("Wypadnięcie z pasa");
    } else if (_isCrashByHitOnGround(height, positionPlane)) {
      _setCrashPlane("Rozbicie o ziemię");
    }else if(_ifBadClapPositionOnStartAndLanding(flaps, height))
    {
      _setCrashPlane("Przeciągniecie, zła pozycja klap");
    }
    else {
      _resetCrashPlaneStatus();
    }
  }
}
