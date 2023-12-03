import 'package:airplane/recorder/FlightDataRecorder.dart';

class Engine {

  static const double THRUST_NEWTON = 121000.0;
  static const double GRAM_FUEL_ON_NEWTON_PER_SECONDE = 0.01063;
  static const double KILO_PREFIX = 1000;

  double _actualThrust = 0.0;

  void setThrustInNewton(double thrust){
    _actualThrust = thrust;
  }

  double getFuelInGramConsumptionPerSecond(){
    return _actualThrust * GRAM_FUEL_ON_NEWTON_PER_SECONDE;
  }

  double getThrustInNewton(){
    return _actualThrust;
  }

  double getThrustInKNewton(){
    return _actualThrust / KILO_PREFIX;
  }

}