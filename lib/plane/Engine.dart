class Engine {

  double THRUST_NEWTON = 121000.0;
  double GRAM_FUEL_ON_NEWTON_PER_SECONDE = 0.01063;

  double _actualThrust = 0.0;


  Engine(){

  }

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
    return _actualThrust / 1000;
  }

}