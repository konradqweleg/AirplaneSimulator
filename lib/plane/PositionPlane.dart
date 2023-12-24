import 'Distance.dart';

class PositionPlane{

  double position = 0.0;
  double y = 0.0;

  double startAirportPosition = 0;
  static double endRunway = 3000;
  static double endFlightPosition = 17000;
  double endYMetres =20000; //600000

  static double getEndRunwayDistanceInMetres(){
    return endRunway;
  }

  static double getEndDistanceInMetres(){
    return endFlightPosition;
  }

  void updatePosition(Distance distance){
    position = distance.getMetresFromStartingRunWay();
  }

  double getPercentagePathInFly(){
    if(position < 0.001){
      return 0.0;
    }else{
      return (position)/ (endFlightPosition + endRunway);
    }
  }



}