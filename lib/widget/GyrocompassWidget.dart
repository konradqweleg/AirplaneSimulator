
import 'package:flutter/material.dart';

class GyrocompassWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color:  Colors.grey,
        ),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(10.0),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Wskaźnik kierunku lotu", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kierunek"),
                    Text("0°")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status"),
                    Text("OK")
                  ],
                )
              ],
            ),
          )),
    );
  }
}
