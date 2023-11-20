import 'dart:async';

import 'package:airplane/plane/Plane.dart';
import 'package:airplane/widget/AtitudeInfoValuesWidget.dart';
import 'package:airplane/widget/AttitudeIndicatorWidget.dart';
import 'package:airplane/widget/ControlColumnWidget.dart';
import 'package:airplane/widget/HeightWidget.dart';
import 'package:airplane/widget/MapWidget.dart';
import 'package:airplane/widget/RestrictorWidget.dart';
import 'package:airplane/widget/EngineWidget.dart';
import 'package:airplane/widget/FuelWidget.dart';
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

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        plane.process();
        //  print("working");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("BOEING 737-800",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)
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
                    children: <Widget>[

                     MapWidget(plane.distance.metres)

                    ],
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
                          HeightWidget(plane.height)
                        ],
                      ),
                      Row(
                        children: [
                          EngineWidget(plane.left, "LEWY"),
                          EngineWidget(plane.right, "PRAWY")
                        ],
                      ),
                      Row(
                        children: [
                          VelocityWidget(plane.velocity.velocity)
                        ],
                      ),
                      Row(
                        children: [
                          AttitudeInidactorWidget(plane.controlColumn.horizontalPosition,plane.controlColumn.verticalPosition),
                          AttitudeInforValues(plane.controlColumn.getHorizontalAngle(),plane.controlColumn.getVerticalAngle())
                        ],
                      )


                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      RestrictorWidget(plane.restrictor),
                      Row(
                        children: [
                         ControlColumnWidget(plane.controlColumn)
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
