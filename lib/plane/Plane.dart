import 'package:airplane/warning/Warning.dart';
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
  final Tank _tank = Tank(8900000.0);
  Engine left = Engine("Lewy");
  Engine right = Engine("Prawy");
  Restrictor restrictor = Restrictor();
  Height height = Height();
  Velocity velocity = Velocity();
  Distance distance = Distance();
  SimulateVelocity simulateVelocity = SimulateVelocity();
  ControlColumn controlColumn = ControlColumn();
  AnaliseSituation analiseSituation = AnaliseSituation();
  Flaps flaps = Flaps();
  PositionPlane positionPlane = PositionPlane();
  Inclination inclinationPilot = Inclination();
  Inclination inclinationSecondPilot = Inclination();
  Inclination inclinationReference = Inclination();
  Inclination inclinationReality = Inclination();
  Brakes brakes = Brakes();
  ThrustReversers thrustReversers = ThrustReversers();
  Chassis chassis = Chassis();

  Boeing_737_800(){
    FlightDataRecorder.deleteAllDatas();
  }

  Tank getTankDevice(){
    return _tank;
  }


  void _analiseWarning(){
    Warning.analiseWarningUnnecessarilyExtendedChassis(height,chassis);
    Warning.analiseWarningSpeedAboveThreshold(velocity.getVelocityHorizontal());
    Warning.analiseWarningLowHeight(height, distance);
    Warning.analiseWarningIsDifferentIndicators(inclinationReality, inclinationSecondPilot, inclinationReference);
  }

  void process(){
    _tank.useFuel(left.getFuelInGramConsumptionPerSecond() + right.getFuelInGramConsumptionPerSecond());
    left.setThrustInNewton(restrictor.getLeftPositionRestrictor());
    right.setThrustInNewton(restrictor.getRightPositionRestrictor());

    velocity = simulateVelocity.getActualAcceleration([left,right],restrictor, height,velocity,inclinationReality,flaps,brakes,thrustReversers);
    height.calculateHeight(velocity, inclinationReality,flaps);
    double oldVelocity = velocity.getVelocityHorizontal();
    distance.updateDistance(((oldVelocity + velocity.getVelocityHorizontal())/2));
    analiseSituation.analiseActualPlaneSituation(velocity,height,positionPlane,flaps);
    positionPlane.updatePosition(distance);

    inclinationReality.simulate(controlColumn,height,velocity);

    inclinationSecondPilot.simulateWithPossibilityFailure(0.000001,controlColumn,height,velocity);
    inclinationReference.simulateWithPossibilityFailure(0.000001,controlColumn, height, velocity);
    inclinationPilot.simulateWithPossibilityFailure(0.000001,controlColumn, height, velocity);


    FlightDataRecorder.saveBrakesStatus(brakes.isBrakesEnabled());
    FlightDataRecorder.saveChassisStatus(chassis.isEjectedChassis());
    FlightDataRecorder.saveControlColumnHorizontalStatus(controlColumn.getHorizontalAngle());
    FlightDataRecorder.saveControlColumnVerticalStatus(controlColumn.getVerticalAngle());
    FlightDataRecorder.saveFlapsStatus(flaps.getCurrentFlapsPosition());
    FlightDataRecorder.saveHeightStatus(height.getHeightPlaneAboveTheGroundInMetres());
    FlightDataRecorder.saveInclinationHorizontalPilot(inclinationPilot.getHorizontalInclinationAngle());
    FlightDataRecorder.saveInclinationVerticalPilot(inclinationPilot.getVerticalInclinationAngle());
    FlightDataRecorder.saveInclinationHorizontalSecondPilot(inclinationSecondPilot.getHorizontalInclinationAngle());
    FlightDataRecorder.saveInclinationVerticalSecondPilot(inclinationSecondPilot.getVerticalInclinationAngle());
    FlightDataRecorder.saveInclinationHorizontalReference(inclinationReference.getHorizontalInclinationAngle());
    FlightDataRecorder.saveInclinationVerticalReference(inclinationReference.getVerticalInclinationAngle());
    FlightDataRecorder.saveLeftEngineStatus(left.getThrustInNewton());
    FlightDataRecorder.saveRightEngineStatus(right.getThrustInNewton());
    FlightDataRecorder.saveFuel(_tank.getLevelFuelInGrams());
    FlightDataRecorder.saveThrustReverser(thrustReversers.isThrustReversersEnabled());
    FlightDataRecorder.saveVelocityVertical(velocity.getVelocityVertical());
    FlightDataRecorder.saveVelocityHorizontal(velocity.getVelocityHorizontal());
    FlightDataRecorder.saveWarningIsBadClapPosition(Warning.isBadClapPosition());
    FlightDataRecorder.saveWarningIsLowLevelFuel(Warning.isLowLevelFuel());
    FlightDataRecorder.saveWarningIsLowHeight(Warning.isLowHeight());
    FlightDataRecorder.saveWarningIsCloseStall(Warning.isCloseStall());
    FlightDataRecorder.saveWarningIsBrakeNoExpectedEnable(Warning.isBrakeNoExpectedEnabled());
    FlightDataRecorder.saveWarningIsThrustReverserNoExpectedEnable(Warning.isThrustReversersNoExpectedEnabled());
    FlightDataRecorder.saveWarningIsUnnecessarilyExtendedChassis(Warning.isUnnecessarilyExtendedChassisEnabled());
    FlightDataRecorder.saveWarningIsSpeedAboveThreshold(Warning.isSpeedAboveThreshold());
    FlightDataRecorder.saveWarningIsDifferentIndicators(Warning.isDifferentIndicators());
    FlightDataRecorder.saveWarningLeftEngineFailure(Warning.isLeftEngineFailure());
    FlightDataRecorder.saveWarningRightEngineFailure(Warning.isRightEngineFailure());
    FlightDataRecorder.saveActualTime();

    _analiseWarning();


  }





}