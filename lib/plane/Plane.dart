import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/Engine.dart';
import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/SimulateVelocity.dart';
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
  SimulateVelocity simulateVelocity = SimulateVelocity();
  ControlColumn controlColumn = ControlColumn();

  Tank getTankDevice(){
    return tank;
  }

  void process(){
    tank.useFuel(left.getFuelInGramConsumptionPerSecond() + right.getFuelInGramConsumptionPerSecond());
    left.setThrustInNewton(restrictor.left);
    right.setThrustInNewton(restrictor.right);



   double old_velocity = velocity.velocity;
   velocity = simulateVelocity.getActualAcceleration([left,right],restrictor,height,velocity);



    distance.metres += ((old_velocity + velocity.velocity)/2);

  }


}