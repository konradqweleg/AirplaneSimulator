class Tank{
  final double MAX_FUEL_GRAMS = 18090000.0;
  final double MAX_DISTANCE_IN_KM = 3900.0;
  final double PREDICTED_FUEL_CONSUMPTION_ON_KM_IN_GRAMS = 4000.0;
  double __actualFuel = 0.0;

  Tank(double fuelLevelInLitres){
    if(fuelLevelInLitres> MAX_FUEL_GRAMS){
      __actualFuel = MAX_FUEL_GRAMS;
    }else{
      __actualFuel = fuelLevelInLitres;
    }
  }

  void addFuelInLitres(double addedLitres){
      if(__actualFuel + addedLitres > MAX_FUEL_GRAMS){
        double tanked = MAX_FUEL_GRAMS - __actualFuel;
        print("Zatankowano ${tanked} gramów paliwa, nastąpiła blokada tankowania");
        __actualFuel = MAX_FUEL_GRAMS;
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
    return __actualFuel / PREDICTED_FUEL_CONSUMPTION_ON_KM_IN_GRAMS;
  }

  void useFuel(double useFuel){
    __actualFuel = __actualFuel - useFuel;
  }

}