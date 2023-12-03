import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/PositionPlane.dart';
import 'package:airplane/plane/Velocity.dart';

class AnaliseSituation {
  static const  double _MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS = 333.3;
  String _crashReason = "";
  bool _isCrash = false;
  bool _isLandingOk = false;

  bool _isNotSafetySpeedVertical(Velocity velocity) {
    return velocity.velocityVertical >
        _MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS;
  }

  bool _isCorrectHeight(Height height, PositionPlane positionPlane) {
    if (positionPlane.position < positionPlane.endRunway) {
      return true;
    } else if (positionPlane.position > positionPlane.endRunway &&
        (positionPlane.position <
            (positionPlane.endRunway + positionPlane.endFlightPosition))) {
      if (height.getHeightPlaneAboveTheGroundInMetres() < 0.001) {
        return false;
      }
    } else if (positionPlane.position >
        (positionPlane.endRunway + positionPlane.endFlightPosition)) {
      return true;
    }
    return true;
  }

  bool _isCrashByHitOnGround(Height height, PositionPlane positionPlane) {
    return !_isCorrectHeight(height, positionPlane);
  }

  bool _isOutsideRunWayOnGround(Height height, PositionPlane positionPlane) {
    if ((positionPlane.position > positionPlane.endRunway) &&
        (height.getHeightPlaneAboveTheGroundInMetres() < 0.001) &&
        (positionPlane.position < (positionPlane.endRunway + 500))) {
      //Staring
      return true;
    } else if ((positionPlane.position >
            (positionPlane.endRunway +
                positionPlane.endFlightPosition +
                positionPlane.endRunway)) &&
        (height.getHeightPlaneAboveTheGroundInMetres() < 0.001)) {
      //Landing
      return true;
    }

    return false;
  }

  bool _isLandingCorrectly(
      Velocity velocity, Height height, PositionPlane positionPlane) {
    if ((positionPlane.position >
            (positionPlane.endRunway + positionPlane.endFlightPosition)) &&
        (height.getHeightPlaneAboveTheGroundInMetres() < 0.001) &&
        (velocity.velocityHorizontal < 0.001)) {
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
      Velocity velocity, Height height, PositionPlane positionPlane) {
    _analisePotentialCrashPlane(velocity, height, positionPlane);
    _analiseIfActualIsCorrectLanding(velocity, height, positionPlane);
  }

  void _analiseIfActualIsCorrectLanding(
      Velocity velocity, Height height, PositionPlane positionPlane) {
    _isLandingOk = _isLandingCorrectly(velocity, height, positionPlane);
  }

  void _analisePotentialCrashPlane(
      Velocity velocity, Height height, PositionPlane positionPlane) {
    if (_isNotSafetySpeedVertical(velocity)) {
      _setCrashPlane("Za duża prędkość");
    } else if (_isOutsideRunWayOnGround(height, positionPlane)) {
      _setCrashPlane("Wypadnięcie z pasa");
    } else if (_isCrashByHitOnGround(height, positionPlane)) {
      _setCrashPlane("Rozbicie o ziemię");
    } else {
      _resetCrashPlaneStatus();
    }
  }
}
