import 'package:airplane/plane/Velocity.dart';

class MapPlane{

  double x = 0.0;
  double y = 0.0;

  double endYMetres = 600000;

  void updatePosition(Velocity velocity){
    x += velocity.velocityHorizontal;
  }

  double getPercentagePath(){
    if(x < 0.001){
      return 0.0;
    }else{
      return x/endYMetres;
    }
  }



}