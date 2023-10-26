import 'package:airplane/plane/Engine.dart';
import 'package:airplane/plane/Height.dart';

import 'Restrictor.dart';
import 'Tank.dart';

class Boeing_737_800{
  double x = 7.0;
  Tank tank = Tank(500000.0);
  Engine left = Engine();
  Engine right = Engine();
  Restritor restrictor = Restritor();
  Height height = Height();

  Tank getTankDevice(){
    return tank;
  }

  void process(){
    tank.useFuel(left.getFuelInGramConsumptionPerSecond() + right.getFuelInGramConsumptionPerSecond());
    left.setThrustInNewton(restrictor.left);
    right.setThrustInNewton(restrictor.right);

  }


}