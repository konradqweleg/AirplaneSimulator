import 'Engine.dart';
import 'Height.dart';
import 'Restrictor.dart';
import 'Velocity.dart';

class SimulateVelocity{

  double MAX_VELOCITY_ON_GROUND_KM_PER_HOUR = 400.0;
  double MAX_VELOCITY_ON_FLY_KM_PER_HOUR = 1000.0;
  double GROUND_HEIGHT_THRESHOLD_IN_METRES = 1.0;

  bool IS_LOG_ENABLED = true;

  void log(String text){
    if(IS_LOG_ENABLED){
      print(text);
    }
  }


  double changeKMPerHourToMetresOnSeconds(double kmPerHour){
    return kmPerHour/3.6;
  }

  //Przyspieszenie
  double getMaxVelocityOnOnePointInRestrictor(Height height,Restritor restrictor,List<Engine> engines){



    double maxVelocityMetresPerSecond = 0.0;
    if(height.metresNPM < GROUND_HEIGHT_THRESHOLD_IN_METRES){
      maxVelocityMetresPerSecond = changeKMPerHourToMetresOnSeconds(MAX_VELOCITY_ON_GROUND_KM_PER_HOUR);
     // return startMaxV;
    }else{
     // return flyMaxV;
     maxVelocityMetresPerSecond= changeKMPerHourToMetresOnSeconds(MAX_VELOCITY_ON_FLY_KM_PER_HOUR);
    }

    double maxVelocityPerOnePointInRestrictor = maxVelocityMetresPerSecond/ (restrictor.max * engines.length);

    log("Max przyspieszenie na jeden poziom przepustnicy ${maxVelocityPerOnePointInRestrictor}");

    return maxVelocityPerOnePointInRestrictor;

  }

  double getMaxSpeedUp(Height height){
    double startMaxV = 0.000017057; //przyspieszenie maksymalne
    double flyMaxV = 0.000042647;
    if(height.metresNPM < GROUND_HEIGHT_THRESHOLD_IN_METRES){
       return startMaxV;
    }else{
       return flyMaxV;
    }
  }

  double calculateMaxVelocityOnActualPositionRestrictor(Height height,Restritor restrictor,List<Engine> engines){

    double maxVOnActualRestrictorPosition = (getMaxVelocityOnOnePointInRestrictor(height,restrictor,engines) * (restrictor.left+restrictor.right));
    log("Max V dla aktualnej pozycji przepustnicy ${maxVOnActualRestrictorPosition} ");
    return maxVOnActualRestrictorPosition;

  }

  double getMaxVelocity(Height height){
    if(height.metresNPM < GROUND_HEIGHT_THRESHOLD_IN_METRES){
      return changeKMPerHourToMetresOnSeconds(MAX_VELOCITY_ON_GROUND_KM_PER_HOUR);
    }else{
      return changeKMPerHourToMetresOnSeconds(MAX_VELOCITY_ON_FLY_KM_PER_HOUR);
    }
  }

  double updateVelocity(double maxVelocityOnActualRestrictorPosition, double maxVelocityOnPointRestrictor,double sumPositionRestrictors,double actualVelocityMetersPerSecond){
    log("Aktualna prędkosc ${actualVelocityMetersPerSecond} przed zmianą");
    //If speed is lower then limit for actual restrictor position speed up
    if(actualVelocityMetersPerSecond < maxVelocityOnActualRestrictorPosition) {
      log("Wzrost prekośći  o ${(maxVelocityOnPointRestrictor * (sumPositionRestrictors) )}");
      double speedUpVelocity = actualVelocityMetersPerSecond + (maxVelocityOnPointRestrictor * (sumPositionRestrictors) );
      log("Powiększona prędkość ${speedUpVelocity}");
      return speedUpVelocity;
    }
    else{
      //If speed is more then max for actual restrictor position slow down

      double diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors = actualVelocityMetersPerSecond - maxVelocityOnActualRestrictorPosition;
      log("Różnica predkośći max dla aktualnego poziomu przepustnicy do aktualnej V ${diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors}");

      if (diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors > 0) {
        double slowerVelocity = actualVelocityMetersPerSecond - ((diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors / 75) + 1.0);

        if(slowerVelocity < 0 ){
          slowerVelocity = 0.0;
        }
        return slowerVelocity;
      }else{
        return actualVelocityMetersPerSecond;
      }

    }
  }

  Velocity getActualVelocity(List<Engine> engines,Restritor restrictor,Height height, Velocity actualVelocity){
    double maxVelocityOnActualPositionRestrictor = calculateMaxVelocityOnActualPositionRestrictor(height,restrictor,engines);
    double maxVelocityOnPointRestrictor = getMaxSpeedUp(height);

    actualVelocity.v = updateVelocity(maxVelocityOnActualPositionRestrictor, maxVelocityOnPointRestrictor, restrictor.left + restrictor.right, actualVelocity.v);
    return actualVelocity;
  }
}