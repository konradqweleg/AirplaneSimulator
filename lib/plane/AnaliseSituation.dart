import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/PositionPlane.dart';
import 'package:airplane/plane/Velocity.dart';

class AnaliseSituation{

  double MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS = 333.3;
  String crashReason = "";
  bool isCrash = false;

  bool isOkFlight = false;

  bool isSafetySpeedVertical(Velocity velocity){
    return velocity.velocityVertical < MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS ;
  }


  bool isCorrectHeight(Height height,PositionPlane positionPlane){
    if(positionPlane.position < positionPlane.endRunway){
      return true;
    }else if(positionPlane.position > positionPlane.endRunway && (positionPlane.position < (positionPlane.endRunway + positionPlane.endFlightPosition)) ){
      if(height.metresNPM < 0.001){
        return false;
      }
    }else if(positionPlane.position > (positionPlane.endRunway + positionPlane.endFlightPosition)){
      return true;
    }
    return true;
  }



  bool isOutsideRunWayOnGround(Height height,PositionPlane positionPlane){
    if((positionPlane.position > positionPlane.endRunway) && (height.metresNPM < 0.001)  && (positionPlane.position < (positionPlane.endRunway + positionPlane.endFlightPosition))){
      return true;
    }

    return false;
  }

  bool isCrashFlight(){
    return isCrash;
  }

  String getCrashReason(){
    return crashReason;
  }



  void analise(Velocity velocity,Height height,PositionPlane positionPlane){
    bool isSafetySpeed =  isSafetySpeedVertical(velocity);
    bool isCorrectHeightPlane = isCorrectHeight(height,positionPlane);
    bool isOutsideRunwayOnGround = isOutsideRunWayOnGround(height,positionPlane);


   if(!isCorrectHeightPlane){
      isCrash = true;
      crashReason = "Rozbicie o ziemie";
    }else  if(!isSafetySpeed){
      isCrash = true;
      crashReason = "Za duża prędkość";
    }
   else if(isOutsideRunwayOnGround){
      isCrash = true;
      crashReason = "Wypadnięcie z pasa";
    }
    else{
      isCrash = false;
      crashReason = "";
    }

  }

}