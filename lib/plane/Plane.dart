import 'package:airplane/plane/AnaliseSituation.dart';
import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/Engine.dart';
import 'package:airplane/plane/Flaps.dart';
import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/SimulateVelocity.dart';
import 'package:airplane/plane/Velocity.dart';

import 'Distance.dart';
import 'PositionPlane.dart';
import 'Restrictor.dart';
import 'Tank.dart';

class Boeing_737_800{
  Tank tank = Tank(500000.0);
  Engine left = Engine();
  Engine right = Engine();
  Restritor restrictor = Restritor();
  Height height = Height();
  Velocity velocity = Velocity();
  Distance distance = Distance();
  SimulateVelocity simulateVelocity = SimulateVelocity();
  ControlColumn controlColumn = ControlColumn();
  AnaliseSituation analiseSituation = AnaliseSituation();
  Flaps flaps = Flaps();
  PositionPlane positionPlane = PositionPlane();

  Tank getTankDevice(){
    return tank;
  }



  void process(){
    tank.useFuel(left.getFuelInGramConsumptionPerSecond() + right.getFuelInGramConsumptionPerSecond());
    left.setThrustInNewton(restrictor.left);
    right.setThrustInNewton(restrictor.right);

    velocity = simulateVelocity.getActualAcceleration([left,right],restrictor, height,velocity,controlColumn,flaps);
    height.calculateHeight(velocity, controlColumn,flaps);
    double oldVelocity = velocity.velocityHorizontal;
    distance.updateDistance(((oldVelocity + velocity.velocityHorizontal)/2));
    analiseSituation.analise(velocity,height,positionPlane);
    positionPlane.updatePosition(distance);



  }


}