import 'package:flutter/material.dart';

class AttitudeInforValues extends StatelessWidget{

  double horizontal = 0.0;
  double vertical = 0.0;
  AttitudeInforValues(this.vertical,this.horizontal, {super.key});



  String calculateHorizontalDegres(double vertical){
    double finalPositionVertical =0.0;
    if(vertical > 100.0){
       finalPositionVertical =- (vertical - 100.0);
    }else{
      finalPositionVertical = (vertical);
      finalPositionVertical = 100 -  finalPositionVertical;
    }

    return finalPositionVertical.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),

      ),
      padding: EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10.0),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SZTUCZNY HORYZONT",
                        style: TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pionowy"),
                    Text("${(horizontal -100 ).toStringAsFixed(3)}")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Poziomy"), Text("${calculateHorizontalDegres(vertical)}")],
                ),
                // Container(width: 200.0,child: Text("Pozostało : ${tank.getLevelFuelInLitres()} litrów paliwa")),
                // Container(width: 200.0,child: Text("Wystarczy na : ${tank.getMaxKMOnActualFuelLevel()} km")),
                // Container(width: 200.0,child: Text("BŁĄD"))
              ],
            ),
          )
      ),
    );
  }

}