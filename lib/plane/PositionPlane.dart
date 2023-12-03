import 'Distance.dart';

class PositionPlane{

  double position = 0.0;
  double y = 0.0;

  double startAirportPosition = 0;
  double endRunway = 3000;
  double endFlightPosition = 10000;
  double endYMetres = 10000; //600000

  void updatePosition(Distance distance){
    position = distance.metres;
  }

  double getPercentagePathInFly(){
    if(position < 0.001){
      return 0.0;
    }else{
      return (position)/ (endFlightPosition + endRunway);
    }
  }



}