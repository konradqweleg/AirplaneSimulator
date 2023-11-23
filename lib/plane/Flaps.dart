

import 'FlapsPosition.dart';

class Flaps{
  double positionFlaps = 0.0;

  Map<FlapsPosition, int> flapAngles = {
    FlapsPosition.retracted: 0,   // Klapa złożona, kąt równy 0 stopni
    FlapsPosition.takeoff: 15,    // Klapa startowa, przykładowy kąt 15 stopni
    FlapsPosition.landing: 30,    // Klapa do lądowania, przykładowy kąt 30 stopni
    FlapsPosition.extended: 45    // Klapa wysunięta, przykładowy kąt 45 stopni
  };


  FlapsPosition currentFlaps = FlapsPosition.retracted;


  int getCurrentFlapsPosition(){
    int angle = flapAngles[currentFlaps] ?? 0;
    return angle;
  }

  void setFlapsAngle(FlapsPosition newFlapPosition){
    currentFlaps = newFlapPosition;
  }

  // int angle = flapAngles[currentFlaps] ?? 0;

}