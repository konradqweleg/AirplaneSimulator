import 'dart:async';

import 'package:airplane/plane/Plane.dart';
import 'package:airplane/widget/AtitudeInfoValuesWidget.dart';
import 'package:airplane/widget/AttitudeIndicatorWidget.dart';
import 'package:airplane/widget/AutoPilotWidget.dart';
import 'package:airplane/widget/BrakesInfoWidget.dart';
import 'package:airplane/widget/BrakesWidget.dart';
import 'package:airplane/widget/ChassisInfoWidget.dart';
import 'package:airplane/widget/ChassisWidget.dart';
import 'package:airplane/widget/ControlColumnWidget.dart';
import 'package:airplane/widget/DistanceWidgetInfo.dart';
import 'package:airplane/widget/FlapsInfoWidget.dart';
import 'package:airplane/widget/FlapsWidget.dart';
import 'package:airplane/widget/GyrocompassWidget.dart';
import 'package:airplane/widget/HeightWidget.dart';
import 'package:airplane/widget/MapWidget.dart';
import 'package:airplane/widget/MapWidgetFly.dart';
import 'package:airplane/widget/RestrictorWidget.dart';
import 'package:airplane/widget/EngineWidget.dart';
import 'package:airplane/widget/FuelWidget.dart';
import 'package:airplane/widget/SimulationStatusWidget.dart';
import 'package:airplane/widget/ThrustReversersInfoWidget.dart';
import 'package:airplane/widget/ThrustReversersWidget.dart';
import 'package:airplane/widget/VelocityWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Boeing_737_800 plane = Boeing_737_800();

  Widget mapWidget = MapWidget(0.0);

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        plane.process();
        updateMapView();
        //  print("working");
      });
    });
  }

  void updateMapView() {
    setState(() {
      if (plane.distance.getMetresFromStartingRunWay() < plane.positionPlane.endRunway) {
        mapWidget = MapWidget(plane.distance.getMetresFromStartingRunWay());
      } else if(plane.distance.getMetresFromStartingRunWay() < (plane.positionPlane.endRunway + plane.positionPlane.endFlightPosition)) {
        mapWidget = MapWidgetFly(plane.positionPlane);
      }else{
        mapWidget = MapWidget(plane.distance.getMetresFromStartingRunWay() - (plane.positionPlane.endFlightPosition + plane.positionPlane.endRunway));
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
        plane.analiseSituation.isCrashFlight() ||  plane.analiseSituation.getIsLandingOk() ?
        SimulationStatusWidget(plane.analiseSituation):
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "BOEING 737-800",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Środowisko"),
                Text("Wskaźniki"),
                Text("Przyrządy")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[mapWidget],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          FuelWidget(plane.getTankDevice()),
                          HeightWidget(plane.height),
                          BrakesInfoWidget(plane.brakes)
                        ],
                      ),
                      Row(
                        children: [
                          EngineWidget(plane.left, "LEWY"),
                          EngineWidget(plane.right, "PRAWY"),
                          ThrustReversersInfoWidget(plane.thrustReversers)
                        ],
                      ),
                      Row(
                        children: [
                          VelocityWidget(plane.velocity.getVelocityHorizontal()),
                          FlapsInfoWidget(plane.flaps),
                          ChassisInfoWidget(plane.chassis)
                        ],
                      ),
                      Row(
                        children: [
                          AttitudeInidactorWidget(
                              plane.inclination.getRawHorizontalInclinationAngle(),
                              plane.inclination.getRawVerticalInclinationAngle()),
                          AttitudeInfoValues(
                              plane.inclination.getHorizontalInclinationAngle(),
                              plane.inclination.getVerticalInclinationAngle(),"L"),
                          DistanceInfoWidget( plane.distance.getMetresFromStartingRunWay())
                        ],
                      ),
                      Row(
                        children: [
                          AttitudeInidactorWidget(
                              plane.inclination.getRawHorizontalInclinationAngle(),
                              plane.inclination.getRawVerticalInclinationAngle()),
                          AttitudeInfoValues(
                              plane.inclination.getHorizontalInclinationAngle(),
                              plane.inclination.getVerticalInclinationAngle(),"S"),
                          GyrocompassWidget()
                        ],
                      ),
                      Row(
                        children: [
                          AttitudeInidactorWidget(
                              plane.inclination.getRawHorizontalInclinationAngle(),
                              plane.inclination.getRawVerticalInclinationAngle()),
                          AttitudeInfoValues(
                              plane.inclination.getHorizontalInclinationAngle(),
                              plane.inclination.getVerticalInclinationAngle(),"P"),
                          AutoPilotWidget()
                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          children:[ RestrictorWidget(plane.restrictor),ControlColumnWidget(plane.controlColumn)]
                      )
                     ,
                      Row(
                        children: [BrakesWidget(plane.brakes),ThrustReversersWidget(plane.thrustReversers)],
                      ),
                      Row(
                        children: [
                          FlapsWidget(plane.flaps),ChassisWidget(plane.chassis)
                        ],
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
