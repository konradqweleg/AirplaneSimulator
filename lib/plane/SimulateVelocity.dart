import 'Engine.dart';
import 'Height.dart';
import 'Restrictor.dart';
import 'Velocity.dart';

class SimulateVelocity{

  double MAX_SPEED_ON_GROUND_KM_PER_HOUR = 400.0;
  double MAX_SPEED_ON_FLY_KM_PER_HOUR = 1000.0;
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
  double getMaxAccelerationOnOnePointInRestrictor(Height height,Restritor restrictor,List<Engine> engines){



    double maxAccelerationMetresPerSecond = 0.0;
    if(height.metresNPM < GROUND_HEIGHT_THRESHOLD_IN_METRES){
      maxAccelerationMetresPerSecond = changeKMPerHourToMetresOnSeconds(MAX_SPEED_ON_GROUND_KM_PER_HOUR);
     // return startMaxV;
    }else{
     // return flyMaxV;
     maxAccelerationMetresPerSecond= changeKMPerHourToMetresOnSeconds(MAX_SPEED_ON_FLY_KM_PER_HOUR);
    }

    double maxAccelerationPerOnePointInRestrictor = maxAccelerationMetresPerSecond/ (restrictor.max * engines.length);

    log("Max przyspieszenie na jeden poziom przepustnicy ${maxAccelerationPerOnePointInRestrictor}");

    return maxAccelerationPerOnePointInRestrictor;

  }

  double getMaxAcceleration(Height height){
    double startMaxV = 0.000017057; //przyspieszenie maksymalne
    double flyMaxV = 0.000042647;
    if(height.metresNPM < GROUND_HEIGHT_THRESHOLD_IN_METRES){
       return startMaxV;
    }else{
       return flyMaxV;
    }
  }

  double calculateMaxVelocityOnActualPositionRestrictor(Height height,Restritor restrictor,List<Engine> engines){

    double maxVOnActualRestrictorPosition = (getMaxAccelerationOnOnePointInRestrictor(height,restrictor,engines) * (restrictor.left+restrictor.right));
    log("Max V dla aktualnej pozycji przepustnicy ${maxVOnActualRestrictorPosition} ");
    return maxVOnActualRestrictorPosition;

  }

  double getMaxVelocity(Height height){
    if(height.metresNPM < GROUND_HEIGHT_THRESHOLD_IN_METRES){
      return changeKMPerHourToMetresOnSeconds(MAX_SPEED_ON_GROUND_KM_PER_HOUR);
    }else{
      return changeKMPerHourToMetresOnSeconds(MAX_SPEED_ON_FLY_KM_PER_HOUR);
    }
  }

  double updateVelocity(double maxVelocityOnActualPositionRestrictor, double maxVelocityOnPointRestrictor,double sumPositionRestrictors,double actualVelocity){
    log("Aktualna prędkosc ${actualVelocity} przed zmianą");
    //If speed is lower then limit for actual restrictor position speed up
    if(actualVelocity < maxVelocityOnActualPositionRestrictor) {
      log("Wzrost prekośći  o ${(maxVelocityOnPointRestrictor * (sumPositionRestrictors) )}");
      double newVelocity = actualVelocity + (maxVelocityOnPointRestrictor * (sumPositionRestrictors) );
      log("Powiększona prędkość ${newVelocity}");
      return newVelocity;
    }
    else{
      //If speed is more then max for actual restrictor position slow down

      double diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors = actualVelocity - maxVelocityOnActualPositionRestrictor;
      log("Różnica predkośći max dla aktualnego poziomu przepustnicy do aktualnej V ${diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors}");

      if (diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors > 0) {
        double newVelocity = actualVelocity - ((diffrenceBetweenVelocityAndMaxVelocityOnPositionRestrictors / 75) + 1.0);

        if(newVelocity < 0 ){
          newVelocity = 0.0;
        }
        return newVelocity;
      }else{
        return actualVelocity;
      }

    }
  }

  Velocity getActualAcceleration(List<Engine> engines,Restritor restrictor,Height height, Velocity actualVelocity){
    double maxSpeedOnActualPositionRestrictor = calculateMaxVelocityOnActualPositionRestrictor(height,restrictor,engines);
    double maxSpeedOnPointRestrictor = getMaxAcceleration(height);

    actualVelocity.velocity = updateVelocity(maxSpeedOnActualPositionRestrictor, maxSpeedOnPointRestrictor, restrictor.left + restrictor.right, actualVelocity.velocity);
    return actualVelocity;
  }
}