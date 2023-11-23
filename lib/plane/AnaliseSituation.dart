import 'package:airplane/plane/Velocity.dart';

class AnaliseSituation{

  double MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS = 333.3;

  void analiseIsSafetySpeedVertical(Velocity velocity){

    print("PRĘDKOŚĆ PIONOWA ${velocity.velocityVertical}");
    if(velocity.velocityVertical > MAX_SAFETY_VELOCITY_VERTICAL_METRES_PER_SECONDS ){
      print("KATASTROFA");
    }

  }

  void analise(Velocity velocity){
    analiseIsSafetySpeedVertical(velocity);

  }

}