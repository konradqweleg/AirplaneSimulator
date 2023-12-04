import 'package:airplane/recorder/FlightDataRecorder.dart';
import 'package:airplane/simulation/AnaliseSituation.dart';
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
  final Tank _tank = Tank(500000.0);
  Engine left = Engine();
  Engine right = Engine();
  Restrictor restrictor = Restrictor();
  Height height = Height();
  Velocity velocity = Velocity();
  Distance distance = Distance();
  SimulateVelocity simulateVelocity = SimulateVelocity();
  ControlColumn controlColumn = ControlColumn();
  AnaliseSituation analiseSituation = AnaliseSituation();
  Flaps flaps = Flaps();
  PositionPlane positionPlane = PositionPlane();


  Boeing_737_800(){
    FlightDataRecorder.deleteAllDatas();
  }

  Tank getTankDevice(){
    return _tank;
  }



  void process(){
    _tank.useFuel(left.getFuelInGramConsumptionPerSecond() + right.getFuelInGramConsumptionPerSecond());
    left.setThrustInNewton(restrictor.getLeftPositionRestrictor());
    right.setThrustInNewton(restrictor.getRightPositionRestrictor());

    velocity = simulateVelocity.getActualAcceleration([left,right],restrictor, height,velocity,controlColumn,flaps);
    height.calculateHeight(velocity, controlColumn,flaps);
    double oldVelocity = velocity.getVelocityHorizontal();
    distance.updateDistance(((oldVelocity + velocity.getVelocityHorizontal())/2));
    analiseSituation.analiseActualPlaneSituation(velocity,height,positionPlane);
    positionPlane.updatePosition(distance);


    FlightDataRecorder.saveLeftEngineStatus(left.getThrustInKNewton());



  }


}