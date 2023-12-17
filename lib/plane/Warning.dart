import 'package:airplane/plane/Chassis.dart';
import 'package:airplane/plane/Distance.dart';
import 'package:airplane/plane/PositionPlane.dart';

import 'Height.dart';

class Warning{
  static bool _isBadClapPosition = false;
  static bool _isLowLevelFuel = false;
  static bool _isLowHeight = false;
  static bool _isCloseStall = false;
  static bool _isBrakeNoExpectedEnable = false;
  static bool _isThrustReverserNoExpectedEnable = false;
  static bool _isUnnecessarilyExtendedChassis = false;
  static bool _isSpeedAboveThreshold = false;

  static void analiseWarningSpeedAboveThreshold(double speedInKmh){
    const double SPEED_THRESHOLD_KMH = 1000;
    double THRESHOLD_METRES_PER_SECOND = SPEED_THRESHOLD_KMH / 3.6;
    if(speedInKmh > THRESHOLD_METRES_PER_SECOND){
      Warning.setSpeedAboveThreshold();
    } else {
      Warning.clearSpeedAboveThreshold();
    }
  }

  static void setSpeedAboveThreshold(){
    _isSpeedAboveThreshold = true;
  }

  static void clearSpeedAboveThreshold(){
    _isSpeedAboveThreshold = false;
  }

  static bool isSpeedAboveThreshold(){
    return _isSpeedAboveThreshold;
  }


 static void analiseWarningUnnecessarilyExtendedChassis(Height height,Chassis chassis){
    int THRESHOOLD_METRES_BELOW_ERROR = 1000;
    if( (height.getHeightPlaneAboveTheGroundInMetres() > THRESHOOLD_METRES_BELOW_ERROR) && (chassis.isEjectedChassis())){
      Warning.setUnnecessarilyExtendedChassisEnabled();
    }else{
      Warning.clearUnnecessarilyExtendedChassisEnabled();
    }
  }

  static void setUnnecessarilyExtendedChassisEnabled(){
    _isUnnecessarilyExtendedChassis = true;
  }

  static void clearUnnecessarilyExtendedChassisEnabled(){
    _isUnnecessarilyExtendedChassis = false;
  }

  static bool isUnnecessarilyExtendedChassisEnabled(){
    return _isUnnecessarilyExtendedChassis;
  }

  static void setThrustReversersNoExpectedEnabled(){
    _isThrustReverserNoExpectedEnable = true;
  }

  static void clearThrustReversersNoExpectedEnabled(){
    _isThrustReverserNoExpectedEnable = false;
  }

  static bool isThrustReversersNoExpectedEnabled(){
    return _isThrustReverserNoExpectedEnable;
  }


  static void setBrakeNoExpectedEnabled(){
    _isBrakeNoExpectedEnable = true;
  }

  static void clearBrakeNoExpectedEnabled(){
    _isBrakeNoExpectedEnable = false;
  }

  static bool isBrakeNoExpectedEnabled(){
    return _isBrakeNoExpectedEnable;
  }


  static void setBadClapError(){
    _isBadClapPosition = true;
  }
  static void clearErrorBadClapPosition(){
    _isBadClapPosition = false;
  }

  static bool isBadClapPosition(){
    return _isBadClapPosition;
  }

  static void setLowLevelFuelError(){
    _isLowLevelFuel = true;
  }
  static void clearErrorLowLevelFuel(){
    _isLowLevelFuel = false;
  }

  static bool isLowLevelFuel(){
    return _isLowLevelFuel;
  }

  static void setLowHeightError(){
    _isLowHeight = true;
  }
  static void clearLowHeightError(){
    _isLowHeight = false;
  }

  static bool isLowHeight(){
    return _isLowHeight;
  }

  static void analiseWarningLowHeight(Height height, Distance distance){
    const double ALTITUDE_THRESHOLD_METRES = 100;
    const double OFFSET_START_AND_END_FLIGHT_POSITION_IN_METRES = 5000;
    if( (height.getHeightPlaneAboveTheGroundInMetres() < ALTITUDE_THRESHOLD_METRES)  && (distance.getMetresFromStartingRunWay() > (PositionPlane.endRunway + OFFSET_START_AND_END_FLIGHT_POSITION_IN_METRES)) && (distance.getMetresFromStartingRunWay() < (PositionPlane.getEndDistanceInMetres() - OFFSET_START_AND_END_FLIGHT_POSITION_IN_METRES))  ){
      Warning.setLowHeightError();
    } else {
      Warning.clearLowHeightError();
    }
  }

  static void setCloseStallError(){
    _isCloseStall = true;
  }
  static void clearCloseStallError(){
    _isCloseStall = false;
  }

  static bool isCloseStall(){
    return _isCloseStall;
  }


}