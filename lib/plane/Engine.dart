import 'dart:math';

import 'package:airplane/plane/Warning.dart';
import 'package:airplane/recorder/FlightDataRecorder.dart';

class Engine {

  static const double THRUST_NEWTON = 121000.0;
  static const double GRAM_FUEL_ON_NEWTON_PER_SECONDE = 0.01063;
  static const double KILO_PREFIX = 1000;

  Engine(this._name);
  String _name;

  double _actualThrust = 0.0;

  void setThrustInNewton(double thrust){
    _actualThrust = thrust;
  }

  double getFuelInGramConsumptionPerSecond(){
    return _actualThrust * GRAM_FUEL_ON_NEWTON_PER_SECONDE;
  }


  double getThrustFilteredByError(double actualThrust){
    double failureChancePercentage = 0.000001;
    Random random = Random();
    double randomNumber = random.nextDouble() * 100000000;

    double threshold = 100000000 * failureChancePercentage;

    if((_name == "Lewy") && (Warning.isLeftEngineFailure())){
      return 0;
    }

    if((_name == "Prawy") && (Warning.isRightEngineFailure())){
      return 0;
    }

    if (randomNumber < threshold) {
      if(_name == "Lewy"){
        Warning.setLeftEngineFailureError();
      }else{
        Warning.setRightEngineFailureError();
      }

      return 0;

    } else {
      return actualThrust;
    }
  }

  double getThrustInNewton(){
    return getThrustFilteredByError(_actualThrust);
    //return _actualThrust;
  }

  double getThrustInKNewton(){
    return getThrustFilteredByError(_actualThrust) / KILO_PREFIX;
  }

}