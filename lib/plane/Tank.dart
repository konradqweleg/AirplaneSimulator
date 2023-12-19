import '../warning/Warning.dart';

class Tank{
  final double _MAX_FUEL_GRAMS = 18090000.0;
  final double _MAX_DISTANCE_IN_KM = 3900.0;
  final double _PREDICTED_FUEL_CONSUMPTION_ON_KM_IN_GRAMS = 4000.0;
  double __actualFuel = 0.0;

  Tank(double fuelLevelInLitres){
    if(fuelLevelInLitres> _MAX_FUEL_GRAMS){
      __actualFuel = _MAX_FUEL_GRAMS;
    }else{
      __actualFuel = fuelLevelInLitres;
    }
  }

  void addFuelInLitres(double addedLitres){
      if(__actualFuel + addedLitres > _MAX_FUEL_GRAMS){
        double tanked = _MAX_FUEL_GRAMS - __actualFuel;
        print("Zatankowano ${tanked} gramów paliwa, nastąpiła blokada tankowania");
        __actualFuel = _MAX_FUEL_GRAMS;
      }else{
        __actualFuel += addedLitres;
        print("Zatankowano ${addedLitres} gramów paliwa");
      }

  }

  double getLevelFuelInGrams(){
    return __actualFuel;
  }

  double getFuelInKg(){
    return __actualFuel/1000.0;
  }

  double getMaxKMOnActualFuelLevel(){
    return __actualFuel / _PREDICTED_FUEL_CONSUMPTION_ON_KM_IN_GRAMS;
  }

  void useFuel(double useFuel){
    if(__actualFuel < 1000000.0){
      Warning.setLowLevelFuelError();
    }else{
      Warning.clearErrorLowLevelFuel();
    }

    if(__actualFuel - useFuel < 0){
      __actualFuel = 0;
    }else{
      __actualFuel = __actualFuel - useFuel;
    }


  }

}