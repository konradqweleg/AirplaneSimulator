import 'package:airplane/recorder/FlightDataRecorder.dart';
import 'package:airplane/simulation/AnaliseSituation.dart';
import 'package:airplane/plane/ControlColumn.dart';
import 'package:airplane/plane/Engine.dart';
import 'package:airplane/plane/Flaps.dart';
import 'package:airplane/plane/Height.dart';
import 'package:airplane/plane/SimulateVelocity.dart';
import 'package:airplane/plane/Velocity.dart';

import 'Brakes.dart';
import 'Chassis.dart';
import 'Distance.dart';
import 'Inclination.dart';
import 'PositionPlane.dart';
import 'Restrictor.dart';
import 'Tank.dart';
import 'ThrustReversers.dart';

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
  Inclination inclination = Inclination();
  Brakes brakes = Brakes();
  ThrustReversers thrustReversers = ThrustReversers();
  Chassis chassis = Chassis();

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

    velocity = simulateVelocity.getActualAcceleration([left,right],restrictor, height,velocity,inclination,flaps,brakes,thrustReversers);
    height.calculateHeight(velocity, inclination,flaps);
    double oldVelocity = velocity.getVelocityHorizontal();
    distance.updateDistance(((oldVelocity + velocity.getVelocityHorizontal())/2));
    analiseSituation.analiseActualPlaneSituation(velocity,height,positionPlane,flaps);
    positionPlane.updatePosition(distance);
    inclination.simulate(controlColumn,height,velocity);


    FlightDataRecorder.saveLeftEngineStatus(left.getThrustInKNewton());






  }





}