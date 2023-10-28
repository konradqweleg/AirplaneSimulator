import 'package:airplane/plane/Engine.dart';
import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/Velocity.dart';

import 'Distance.dart';
import 'Restrictor.dart';
import 'Tank.dart';

class Boeing_737_800{
  double x = 7.0;
  Tank tank = Tank(500000.0);
  Engine left = Engine();
  Engine right = Engine();
  Restritor restrictor = Restritor();
  Height height = Height();
  Velocity velocity = Velocity();
  Distance distance = Distance();

  Tank getTankDevice(){
    return tank;
  }

  void process(){
    tank.useFuel(left.getFuelInGramConsumptionPerSecond() + right.getFuelInGramConsumptionPerSecond());
    left.setThrustInNewton(restrictor.left);
    right.setThrustInNewton(restrictor.right);




    double maxInActualVelocitySet = velocity.maxVWhenStartingMS * (restrictor.left+restrictor.right);
    print("MAX  "+  (maxInActualVelocitySet*3.6).toStringAsPrecision(4));
    print("VEL "+(velocity.v*3.6).toStringAsPrecision(4));


    double beforeUpdateVelocity = velocity.v;
    if(velocity.v < maxInActualVelocitySet) {
      velocity.v += velocity.startMaxV * (restrictor.left + restrictor.right);

    }else{
      print("TU");
      if(velocity.v < maxInActualVelocitySet) {
        double diffrence = velocity.v - (restrictor.left + restrictor.right);
        if ((velocity.v - (diffrence / 75) + 1.0) > 0) {
          velocity.v -= (diffrence / 75) + 1.0;
        }

        if (velocity.v < 0) {
          velocity.v = 0;
        }
      }

    }


    distance.metres += ((beforeUpdateVelocity + velocity.v)/2);

  }


}