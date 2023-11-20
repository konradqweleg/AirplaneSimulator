class ControlColumn {
  double horizontalPosition = 100.0;
  double verticalPosition = 100.0;


  double getHorizontalAngle() {
    double scaledToAngeleRange = horizontalPosition * 0.9;

    if (scaledToAngeleRange >= 90) {

      if((-(scaledToAngeleRange - 90)) > -0.001 ){
        return 0.0;
      }

      return -(scaledToAngeleRange - 90);
    } else {

      return 90 - scaledToAngeleRange;
    }
  }

  double getVerticalAngle(){
    double scaledToAngeleRange = verticalPosition * 0.9;
    if(scaledToAngeleRange > 90){
      return scaledToAngeleRange - 90;
    }else{

      if(-(90 - scaledToAngeleRange) > -0.001){
        return 0.0;
      }

      return -(90 - scaledToAngeleRange);
    }




  }




}
