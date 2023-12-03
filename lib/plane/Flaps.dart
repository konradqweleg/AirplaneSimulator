

import 'FlapsPosition.dart';

class Flaps{

  Map<FlapsPosition, int> flapAngles = {
    FlapsPosition.retracted: 0,   // Retracted flap, angle equal to 0 degrees
    FlapsPosition.takeoff: 15,    // Takeoff flap, example angle of 15 degrees
    FlapsPosition.landing: 30,    // Landing flap, example angle of 30 degrees
    FlapsPosition.extended: 45    // Extended flap, example angle of 45 degrees
  };

  FlapsPosition _currentFlapsPosition = FlapsPosition.retracted;

  int getCurrentFlapsPosition(){
    int angle = flapAngles[_currentFlapsPosition] ?? 0;
    return angle;
  }

  FlapsPosition getFlapsPosition(){
    return _currentFlapsPosition;
  }

  void setFlapsPosition(FlapsPosition newFlapPosition){
    _currentFlapsPosition = newFlapPosition;
  }



}